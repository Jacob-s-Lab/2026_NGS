# 次世代定序、生物資訊學與基因體醫學(IV)

## 本次課程主要內容
1. ❗**利用GATK做variant calling**❗
2. 學會看variant calling的結果
3. 用ThinLinc打開IGV查看variant calling後的結果
> [!Caution]
> **運算時間: 17~19 h**

> [!Important]
> #### GATK介紹
<details>
<summary>(點擊展開)</summary> 

>　- GATK（Genome Analysis Toolkit）是一套功能強大的基因組學分析軟件工具集，專門設計來處理高通量 DNA 和 RNA sequence data，特別是處理變異檢測（variant calling）、數據品質控制以及數據後處理。GATK 被廣泛應用於研究中，用來分析與疾病相關的遺傳變異、癌症基因組學及個體基因組分析。
> - 課程中使用的部分為HaplotypeCaller，是GATK 中最常用的變異檢測工具，專門用於檢測單核苷酸變異（SNPs）和插入/刪除變異（Indels）。
>
>    https://gatk.broadinstitute.org/hc/en-us

</details>

> [!Important]
> #### 甚麼是variant calling?
<details>
<summary>(點擊展開)</summary> 
 
> - Variant calling（變異檢測)是生物信息學中的一個過程，用於從 DNA sequnece data 中檢測和識別基因組中的遺傳變異。這些變異可能是不同的 DNA sequence與reference genome 相比存在的差異。變異檢測的常見應用包括尋找疾病相關的基因突變、個人基因組分析以及研究群體中的遺傳多樣性。
> 
> - 變異通常可以分為以下幾類：
> (1)單核苷酸變異（SNP，Single Nucleotide Polymorphisms）：單個核苷酸的改變。例如參考序列是 A，但在樣本中發現變為 T。
> (2)插入與刪除變異（Indels，Insertions and Deletions）：DNA 序列中插入或刪除了一個或多個核苷酸。
> (3)結構變異（Structural Variants, SVs）：較大範圍的變異，可能涉及基因組的大塊重排、複製、轉位等。

</details>

## 本次課程的樹狀資料結構
[Variantcalling](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/tree/NGS_HW3_2_tree.txt)

### step1 在國網上建立路徑
1. 登入國網（忘記怎麼登入的人請參見[連結](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)）
2. 進入`analysis`資料夾
```marksown=
cd /work/username/result/analysis
```
3. 複製上課所需執行檔
```marksown=
rsync -avz /work/evelyn92/2026NGS/HW3/VC_HC.sh ./
rsync -avz /work/evelyn92/2026NGS/HW3/Mutect2.sh ./
```

### step 2 修改分析執行檔
1. 進入 [VC_HC.sh](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/script/VC_HC.sh)
```
vim VC_HC.sh
```

2. 請輸入 <kbd>i</kbd> 更改以下程式碼：
> 以下以`VC_HC.sh`做為示範 (格式請依照裡面給你的範例，副檔名不用寫進去)
```
#!/usr/bin/sh
#SBATCH -A ACD114093                # Account name/project number
#SBATCH -J variantcalling           # Job name:可修改
#SBATCH -p ngscourse                # Partition Name:等同PBS裡面的 -q Queue name
#SBATCH -c 2                        # 使用的core數:請參考Queue資源設定
#SBATCH --mem=13g                   # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o vc_out.log               # Path to the standard output file:可修改
#SBATCH -e vc_err.log               # Path to the standard error ouput file:可修改
#SBATCH --mail-user=                # e-mail:可修改
#SBATCH --mail-type=FAIL,END        # 指定送出email時機:可為NONE, BEGIN, END, FAIL, REQUEUE, ALL
```
3. 將`username`的位子改成自己的主機帳號並修改成正確的檔案路徑
```
# Please enter the R1 & R2 file name and your username
user=username
IN_DIR=/work/${user}/result/fastq
sample=SRR13076392
R1=${IN_DIR}/${sample}_1.fastq.gz
R2=${IN_DIR}/${sample}_2.fastq.gz
```
> [!Warning]
> #### 本次加入的步驟:Variant calling
> ![image](https://hackmd.io/_uploads/HJewMZ4o-e.png)
> ![image](https://hackmd.io/_uploads/B1Kuzb4iZg.png)

❗為呈現完整的流程script會包含前一個步驟，若要節省時間，可以將重複的部分刪除，但請注意input和output檔案路徑及變數設定❗

4. 輸入`:wq`儲存離開
```
:wq
```
5. 執行script

(1)輸入以下指令，來以sbatch job的方式送出編輯完成的草稿
```
sbatch VC_HC.sh
```


(2)若送出成功將會出現以下文字 (`VC_HC.sh`的檔案跑完後會自動在`output_sample`資料夾下建立一個`VC`資料夾，將結果放在裡面)

![image](https://hackmd.io/_uploads/HymfEzrRR.png)



(3)可使用以下指令查看工作執行情況
```
sacct
```
![image](https://hackmd.io/_uploads/Bkor4GBAC.png)



 6. 查看結果:在`VC`資料夾中會有`vcf檔，並確認檔案完整性，詳細步驟逐條列在下面

(1)開啟VC資料夾:可使用相對路徑或絕對路徑
```marksown=
cd output_sample/VC                                  #可使用相對路徑
cd /work/username/result/analysis/output_sample/VC   #或使用絕對路徑
```

(2)確認檔案存在:
```
ls
```
(3)確認檔案完整性:
```
less sample.sorted.markdip.HC.vcf.gz
```
(4)利用 <kbd>shift</kbd>+<kbd>g</kbd> 查看檔案最底部

![image](https://hackmd.io/_uploads/SJofG57C0.png)


(5)退出:
```
q
```

> [!IMPORTANT]
> #### 何為vcf檔?
<details>
<summary>(點擊展開)</summary> 

> VCF（Variant Call Format）檔案是一種用於存儲基因變異數據的標準檔案格式，通常用來記錄 DNA sequence中與regerence genome不同的變異信息。VCF 檔案的主要應用是在基因組學研究中，特別是基於高通量測序（NGS）技術所產生的數據。這些檔案可以記錄多種類型的變異，包括單核苷酸多態性（SNPs）、插入或刪除變異（Indels）等。
> https://www.htslib.org/doc/vcf.html
>
> ![image](https://hackmd.io/_uploads/S17rF97RA.png)
> ![image](https://hackmd.io/_uploads/BkeBEXHRR.png)  

</details>

### 將 variant calling 的方式改為 GATK Mutect2
1. 先複製一份 `VC_HC.sh`，並命名為 `VC_M2.sh`。
```
cd /work/username/result/analysis
cp VC_HC.sh VC_M2.sh
```
4. 開啟`analysis`資料夾下的 [`Mutect2.sh`](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/script/Mutect2.sh)，並將裡面的內容複製並置換 `VC_M2.sh`中 variant calling 的部分。
5. 修改 `VC_M2.sh` 中的參數。  
**提示：需要修改的內容為**  
  (1) 開頭部分 err.log 及 out.log 的檔案名稱。  
  (2) variant calling 時 output file 的檔案名稱。  
  (3) 因為 variant calling 時 output file 改名而造成變動的檔案名稱。  
> [!Warning]
> 如果沒有完整修改的話，當 output 檔案名稱與剛剛用 hapltypecaller 做出來的檔案名稱相同時，將會覆蓋掉之前的檔案。
6. 執行修改好的 shell script。

## 用IGV察看結果
### step 1 使用Thinlinc、開啟IGV
1. 使用Thinlinc、開啟 'Xfce terminal'
2. 在terminal利用sh指令開啟IGV軟體
```
sh /opt/ohpc/Taiwania3/pkg/biology/IGV/IGV_v2.10.3/igv.sh
```
3. 透過畫面左上角的區域來選取相對應的reference genome
![HYRsUmf](https://hackmd.io/_uploads/HJa0cGxpA.png) 

(1) 左上角下拉選單選取**More...**
    ![upload_5665be535b603da2fd1d955771c76554](https://hackmd.io/_uploads/BJmviGeTC.jpg)  
    
(2) 搜尋**hg38**，下載**Human hg38**
    ![image](https://hackmd.io/_uploads/HyVI28a9eg.png)  
    
(3) 透過左上角的File → Load from file可匯入cram檔，檔案位於以下路徑：  
- bam file:`/work/username/result/analysis/output_sample/VC/sample.sorted.markdup.HC.cram`
![螢幕擷取畫面 2026-03-28 123402](https://hackmd.io/_uploads/rkqoe1Si-l.png)


> [!IMPORTANT]
> #### 何為cram檔?
<details>
<summary>(點擊展開)</summary> 

> **CRAM檔**（Compressed Reference-oriented Alignment Map）：
> 是一種用來儲存基因定序比對結果的壓縮格式，通常在序列完成與參考基因組（reference genome）比對後使用。它與 BAM 檔類似，差別在於 CRAM 會利用參考基因組記錄序列之間的差異，而不是完整儲存每條序列，因此能有效減少檔案大小，且在讀取時需搭配相同的參考基因組。
> - CRAM：利用 reference genome 進行壓縮
> - 儲存內容：read 與 reference 的差異資訊
> - 檔案型式：二進位格式（不可直接閱讀）
> - 相較 BAM：檔案更小，但需 reference 才能解讀

</details>

(4) 左上角可選取要看的染色體以及範圍（藍色框），右上角（紅色框）可選取要看的大小（需要放大到足夠的級距才能看到結果）
![螢幕擷取畫面 2026-03-28 123527](https://hackmd.io/_uploads/Hk9JRC4j-x.png)


> 以*chr16*為例：
> * 請在上方輸入**chr16:18,827,260-18,829,177**（可自行調整級距），若成功開啟會呈現如下圖的結果
![螢幕擷取畫面 2026-03-28 124019](https://hackmd.io/_uploads/H14HRCEobx.png)
> * 在左側灰色區域點右鍵
>   1. 勾選 "View as pairs"
>   2. Color alignments by → insert size and pair orientation
>   3. Sort alignments by → insert size     
>   ![螢幕擷取畫面 2026-03-28 122140](https://hackmd.io/_uploads/rkVIlJSjWe.png)
>   ![螢幕擷取畫面 2026-03-28 124732](https://hackmd.io/_uploads/Hygk-1BiWx.png)


若你想要了解在 IGV 中每個 read 的顏色所代表的意義，可以參考以下連結(https://igv.org/doc/desktop/#)
[User Guide > Tracks and Data Types > Alignments > Paired-end alignments > Detecting structral variants]

### step 2 觀察不同variant calling工具output的差異
![image](https://hackmd.io/_uploads/HJ8Rzwvibx.png)

- 點連結了解 [HaplotypeCaller](https://gatk.broadinstitute.org/hc/en-us/articles/360037225632-HaplotypeCaller) 和 [Mutect2](https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2) 的詳細資訊 
