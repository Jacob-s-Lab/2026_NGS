# 次世代定序、生物資訊學與基因體醫學(III)

> [!Warning]
> ### 課前助教小提醒~
> #### 1. NCHC資料夾層級介紹
> ![image](https://hackmd.io/_uploads/BymXkrFT0.png)
> ![image](https://hackmd.io/_uploads/rkYAvrYTA.png)
> 
> *** **上課內容請在`work/$user`之下執行** ***
> #### 2. 如何使用`mv`
> - `mv` 是一個用於移動或重新命名文件和資料夾的命令行工具，在 > Linux 和 macOS 系統中廣泛使用。`mv` 命令可以幫助你將文件或目錄從一個位置移動到另一個位置，或者將文件或目錄重新命名。
> - 移動文件:`mv <source_file> <destination_directory>/`
> - 重新命名:`mv <old_filename> <new_filename>`
> - 移動並重新命名:`mv <source_file> /<new_directory>/<new_filename>`
> - 移動目錄:`mv <source_directory>/ <destination_directory>/`

## 本次課程主要內容
 1. 利用BWA做alignment
 2. ❗利用picard做mark duplicates❗
> [!Caution]
> **運算時間: 20~21 h**

## 本次課程的樹狀資料結構
[Alignment](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/tree/NGS_HW3_1_tree.txt)

## Alignment
> [!Important]
> #### 甚麼是Alignment?
> Alignment（比對）是bioinformatics中的一個重要概念，指的是將兩條或多條序列進行比較，以找出它們之間的相似性和差異性。這些序列可以是DNA、RNA或蛋白質的序列。Alignment 的主要目的是通過比較不同的生物序列來推測它們之間的進化關係、功能相似性或結構特徵。

> [!Important]
>  #### BWA / Picard / MarkDuplicates 說明
<details>
<summary>(點擊展開)</summary> 
 
> #### 甚麼是BWA?
> BWA（Burrows-Wheeler Aligner）是一個用於基因組序列比對的工具，特別適用於將短序列讀段（reads）比對到參考基因組(reference genome)。
> #### 甚麼是Picard?
> Picard 是一套genomic data analysis，專為處理高通量測序數據設計，提供了一系列功能強大的工具，幫助用戶在分析過程中進行各種操作，提供如 MarkDuplicates、調整讀數群組、重新排序、數據清理、統計分析和格式轉換等功能，廣泛應用於變異檢測和基因體分析的工作流程中。
> 
> #### 甚麼是MarkDuplicats?
> - 在Genomics和次世代定序（NGS）中，重複讀數（duplicate reads）是指在定序的過程中由同一原始DNA分子產生的多個讀數。這些讀數的出現通常是由於PCR amplification的過程造成的，在每個擴增循環中，DNA polymerase會複製template DNA，使得每個循環後的DNA量都會成倍增加。理論上，這應該會產生大量相同的DNA片段，但因PCR的過程中，某些DNA片段的擴增效率比其他片段高，會影響最終測序數據的代表性和準確性。這種影響可能源於幾個因素：Primer的設計、DNA sequence的GC含量、DNA的二級結構(hairpin)、PCR的溫度時間及DNA polymerase的效率等。
> - **因此我們利用MarkDuplicates來辨識並標記 duplicate reads。這個過程通常在比對alignment之後進行，主要目的是防止來自同一個DNA序列因為重複讀數在後續分析中引起錯誤結果。**

</details>

### Step 1在國網上建立路徑
1. 登入國網（忘記怎麼登入的人請參見[連結](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)）
2. 進入work資料夾輸入`cd /work/username/result`，接著輸入`mkdir analysis`可以在國網主機目前的位置下建立一個叫做analysis的資料夾，作為本次檔案儲存的資料夾
```marksown=
cd /work/username/result
mkdir analysis
```
3. 進入work資料夾輸入`cd /analysis`資料夾，接著複製上課所需執行檔
```marksown=
cd analysis
pwd
rsync -avz /work/evelyn92/2026NGS/HW3/ALN.sh ./
```

> [!Important]
> #### 命令小學堂
> `pwd`
> pwd 指令代表 "print working directory"（打印工作目錄），用於類 Unix 系統（例如 Linux 和 macOS）中，顯示當前正在工作的目錄。當在終端中執行 `pwd`時，它會顯示當前目錄的完整路徑。

### Step 2 修改分析執行檔
1. 進入 [ALN.sh](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/script/ALN.sh) 輸入`vim ALN.sh`
```
vim ALN.sh
```

> 如果檔案裡看不到任何內容，可能是無"讀取"權限：  
> (1) 鍵盤先按`Esc`鈕，再輸入`:wq`儲存離開     
> (2) 請確認此檔案的權限    
> ```
> ls -lh ALN.sh
> ```
> ![image](https://hackmd.io/_uploads/ByrfWHXoZl.png)
> 
> ℹ️    
> `--w-rwxrwx ` 代表：      
> > [類型][擁有者權限][群組權限][其他用戶權限]         
> > 1.	-：檔案類型（- 表示一般檔案，d 表示目錄）。      
> > 2.	擁有者權限（Owner）：--w-          
> >     僅有寫入權限，沒有讀取或執行權限。       
> > 3.	群組權限（Group）：rwx     
> >     群組成員擁有讀取、寫入和執行的所有權限。    
> > 4.	其他用戶權限（Others）：rwx    
> >     其他用戶也擁有所有權限。    
> - 你作為檔案的擁有者，沒有讀取權限，導致 vim 無法顯示檔案內容。   
> - 其他用戶和群組有完全的操作權限。   
>  
> (3) 更改此檔案的權限    
> ```
> chmod u+r ALN.sh
> ```
> 
> (4) `-rw-rwxrwx ` 開通讀取權限           
> ![image](https://hackmd.io/_uploads/HyadWSmjbg.png)
> 
> (5) 重複操作step2-1的指令      

2. 請輸入<kbd>i</kbd>更改以下程式碼：
```
#!/usr/bin/sh
#SBATCH -A ACD114093           #Account name/project number
#SBATCH -J alignment           ###Job name:可修改
#SBATCH -p ngscourse           ###Partition Name:等同PBS裡面的 -q Queue name
#SBATCH -c 2                   #使用的core數:請參考Queue資源設定
#SBATCH --mem=13g              #使用的記憶體量 請參考Queue資源設定
#SBATCH -o al_out.log          ###Path to the standard output file:可修改
#SBATCH -e al_err.log          ###Path to the standard error ouput file:可修改
#SBATCH --mail-user=           ###e-mail:可修改
#SBATCH --mail-type=END        ###指定送出email時機:可為NONE, BEGIN, END, FAIL, REQUEUE, ALL
```

3. 修改`username`、`sample`及檔案路徑    
```
# Please enter the R1 & R2 file name and your username
user=username
IN_DIR=/work/${user}/result/fastq
sample=SRR13076392
R1=${IN_DIR}/${sample}_1.fastq.gz
R2=${IN_DIR}/${sample}_2.fastq.gz
```

4. 建立資料夾(命名為`output_${sample}`)來存放結果
```
# output
OUT_DIR=/work/${user}/result/output_${sample}
mkdir -p ${OUT_DIR}
cd ${OUT_DIR}
```    
5. 鍵盤先按<kbd>Esc</kbd>鈕，再輸入`:wq`儲存離開
```
:wq
```
6. 執行script
(1)輸入以下指令，來以sbatch job的方式送出編輯完成的草稿
```
sbatch ALN.sh
```

(2)若送出成功將會出現以下文字 (ALN.sh的檔案跑完後會自動在`analysis`資料夾下建一個`output_sample/ALN`資料夾，將結果放在裡面)

![image](https://hackmd.io/_uploads/H1dbv9WT0.png)

(3)可使用以下指令查看工作執行情況
```
sacct
```
![螢幕擷取畫面 2024-09-12 151517](https://hackmd.io/_uploads/Hk33LGxp0.png)

 7. 察看結果:在`ALN`資料夾中會有`sam`,`bam`檔，並確認檔案完整性，詳細步驟逐條列在下面

(1)開啟`ALN`資料夾:可使用相對路徑或絕對路徑
```marksown=
cd output_sample/ALN                                  #可使用相對路徑
cd /work/username/result/analysis/output_sample/ALN   #或使用絕對路徑
```
> [!Important]
> #### 相對路徑vs.絕對路徑
> 1. **相對路徑**: 相對路徑是從當前工作目錄開始的路徑。它描述了相對於當前目錄的位置來找到某個文件或資料夾。例如，如果你在 "home" 目錄中，想要訪問 "home" 中的 "documents" 資料夾內的文件，你可以使用相對路徑 ./documents/filename.txt。
> 
> 2. **絕對路徑**: 絕對路徑是從文件系統的根目錄（用 "/" 表示）開始的完整路徑。它提供了文件或資料夾的確切位置，與當前工作目錄無關。例如，/home/username/documents/filename.txt 是一個絕對路徑，因為它從根目錄（/）開始，並且包含到文件的完整路徑。


(2)確認檔案存在:
```
ls
```
(3)確認檔案完整性:
```
less sample.sam
```
(4)利用 <kbd>shift</kbd>+<kbd>g</kbd> 查看檔案最底部
![image](https://hackmd.io/_uploads/HJUrZ7B60.png)   

> 可能會接連出現以下訊息&對應處理方法：   
> ![image](https://github.com/user-attachments/assets/cb3a456f-4fd7-44d7-84b1-53beb18a1423)   
> 鍵盤輸入 <kbd>Ctrl</kbd>+<kbd>C</kbd>，即可停止
> 
> ![image](https://github.com/user-attachments/assets/13e4791f-b8f9-4aab-9311-cc7b26f5a363)   
> 鍵盤輸入"任一鍵"，即可跳出
> 
> ![image](https://github.com/user-attachments/assets/048dbcd2-3444-4127-9d36-b1c51ea4b4de)   
> 鍵盤輸入`q`，即可退出    

(5)退出:
```
q
```

> [!Important]
> #### 檔案介紹
<details>
<summary>(點擊展開)</summary> 
 
> 1. **sam檔及bam檔介紹**:
SAM和BAM檔是生物信息學中用於表示序列比對結果的兩種常見文件格式。它們在基因組測序和變異分析中扮演了重要角色。
> (1)**SAM檔**（Sequence Alignment/Map）:
是一種文本格式，用於儲存序列比對結果。它是可讀的純文本格式，方便人們閱讀和調試。
> Example:
> ![image](https://hackmd.io/_uploads/SyzJRMxTR.png)
> - r001：讀段名稱（read name）。
> - 163：標誌位（FLAG），說明讀段的狀態（如是否雙端測序、是否是反向補序列等）。
> - chr1：參考基因組的染色體名稱（chromosome）。
> - 7：讀段比對的開始位置（position）。
> - 30：比對的質量得分（MAPQ）。
> - 10M：CIGAR 字符串，表示讀段如何比對到參考基因組（這裡的意思是 10 個碱基完全匹配）。
> - =：配對讀段的位置，這裡 = 表示和當前染色體相同。
> - 37：配對讀段的開始位置。
> - 39：插入的大小（insert size）。
> - AGCTTAGCTA：讀段的序列（sequence）。
> - *：未定義的質量分數（通常會有實際數值，但這裡是未填寫）。
> 
> (2)**BAM檔**（Binary Alignment/Map）:
是 SAM 文件的二進制版本。它提供了與 SAM 文件相同的信息，但以壓縮的二進制格式存儲，便於處理和存儲。
> - `less`
less 是一個用於在 Unix 和類 Unix 系統（如 Linux 和 macOS）中查看文本文件的命令行工具。它是一個頁面查看器，能夠方便地查看大文件，並提供多種導航和搜索功能。
> - `q`
退出`less`

</details>
