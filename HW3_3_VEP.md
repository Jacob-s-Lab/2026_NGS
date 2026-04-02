# 次世代定序、生物資訊學與基因體醫學(V)

## 本次課程主要內容
 1. 利用VEP做annotation

> [!Important]
> #### 甚麼是annotation?
> Annotation是指對生物序列（如DNA、RNA、蛋白質）進行功能標注，幫助解釋其生物意義，主要有結構資訊，用於標記基因的位置，列如exon、intron等；和功能資訊，用於預測基因的生物功能、蛋白質的作用等，這樣可以幫助我們理解結構與功能的關聯。
>
> #### VEP介紹
> VEP（Variant Effect Predictor）是由Ensembl開發的一款工具，用於分析遺傳資訊，特别是評估基因中的不同變異（如SNVs、insertion、deletion和Structural variants）對生物功能的影響，非常適合用於annotation。

> [!Caution]
> **運算時間: 1~2 h**

## 本次課程的樹狀資料結構
[Annotation](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/tree/NGS_HW3_3_tree.txt)

### step1:在國網上建立路徑
1. 登入國網（忘記怎麼登入的人請參見[連結](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)）
2. 進入`analysis`資料夾
```marksown=
cd /work/username/result/analysis
```
3. 複製上課所需執行檔
```marksown=
rsync -avz /work/evelyn92/2026NGS/HW3/vep_HC.sh ./
```

### step 2 修改分析執行檔
1. 進入 [vep_HC.sh](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week7_1015/vep.sh).
```
vim vep_HC.sh
```

2. 請輸入 <kbd>i</kbd> 更改以下程式碼:  
```
#!/usr/bin/sh
#SBATCH -A ACD114093           # Account name/project number
#SBATCH -J vep                 # Job name
#SBATCH -p ngscourse           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 2                   # 使用的core數 請參考Queue資源設定 
#SBATCH --mem=13g              # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o vep_out.log               # Path to the standard output file:可修改
#SBATCH -e vep_err.log               # Path to the standard error ouput file:可修改
#SBATCH --mail-user=
#SBATCH --mail-type=FAIL,END
```

* VEP 路徑
![image](https://hackmd.io/_uploads/SylbvuvjZe.png)

* Split multiallelic and normalized 拆分單一位置多種變異以及座標向左對齊  \
![image](https://hackmd.io/_uploads/By-XDuvoZl.png)

![Screenshot 2024-10-15 at 15.53.38](https://hackmd.io/_uploads/SJockiiyJe.png)

![Screenshot 2024-10-15 at 15.54.49](https://hackmd.io/_uploads/H10RyisJkx.png)

![Screenshot 2024-10-15 at 15.56.42](https://hackmd.io/_uploads/Sy5Ixjj11g.png)

![Screenshot 2024-10-15 at 16.31.47](https://hackmd.io/_uploads/SJp9uiikJx.png)

[https://genome.sph.umich.edu/wiki/Variant_Normalization](https://)
    
* VEP annotation 正式VEP註解遺傳變異  \
![image](https://hackmd.io/_uploads/rktdv_wiZe.png)

* Original VEP output 原始VEP格式（VCF）
![Screenshot 2024-10-15 at 16.09.19](https://hackmd.io/_uploads/SyxcSmis1kg.png)

* Format into TSV 轉換為Tab分隔格式
![image](https://hackmd.io/_uploads/r10nwOvjWe.png)

![Screenshot 2024-10-15 at 16.08.42](https://hackmd.io/_uploads/B1RI7js11g.png)


    
    
    
3. 輸入`:wq`儲存離開
```
:wq
```
4. 執行script

(1)輸入以下指令，來以sbatch job的方式送出編輯完成的草稿
```
sbatch vep_HC.sh
```


(2)若送出成功將會出現以下文字 

```Submitted batch job -------```



(3)可使用以下指令查看工作執行情況
```
sacct
```


5. 執行完成後會產生以下檔案：
- sample.HC.normed.vcf.gz：split multiallelic 後的 vcf
- sample.HC.VEP.vcf：VEP annotate 後以 vcf 的格式輸出sample.HC.VEP.vcf_summary.html
- sample.HC.VEP.vcf_warnings.txt：VEP annotate 完後的一些統計及警告的資料
- sample.HC.VEP.tsv及sample.HC.VEP_filtered.tsv：將 vcf 的格式轉換成 tsv 的格式，以及將一些的欄位刪減後的 tsv。每一行為一個 variant，若有不同 transcript 會以 "," 分隔
 
> [!Important] 
> #### tsv檔案講解說明
> 1. CHROM：變異所在的染色體
> 2. POS:變異所在的座標
> 3. REF：參考資料之等位基因
> 4. ALT：變異後的等位基因
> 5. DP：定序深度
> 6. Allele：與ALT相同
> 7. Consequence：變異位點所影響之等位基因。(https://www.ensembl.org/info/genome/variation/prediction/predicted_data.html)
> 8. SYMBOL：基因的官方名稱。
> 9. Gene：受影響基因的 ID（例如，ENSG00000223972 等）。
> 10. gnomADe_EAS_AF：此變異在gnomAD Exome資料庫中的東亞人群等位基因頻率。
> 11. gnomADg_EAS_AF：此變異在gnomAD Genome資料庫中的東亞人群等位基因頻率（如果存在）。
> 12. CLIN_SIG：在ClinVar database中臨床意義。
> 13. TWB_official_SNV_indel_AF：最新臺灣人體資料庫中此變異的等位基因頻率。(https://www.sciencedirect.com/science/article/pii/S2090123223004058?via%3Dihub)

---------------------
### 練習
用 VEP 對 Mutect2 VariantCalling 後的結果做 annotation
1. 請先確認Mutect2 VariantCalling是否已跑完
2. 確認`VC`資料夾下有Mutect2 output的完整檔案  
**提示：`ls`後有顯示`sample.sorted.markdup.M2.vcf.gz`**
3. 先複製一份 `vep_HC.sh`，並命名為 `vep_M2.sh`。
4. 修改 `vep_M2.sh` 中的參數。  
**提示：需要修改的內容為**  
  (1) 開頭部分 err.log 及 out.log 的檔案名稱。  
  (2) variant calling 時 output file 的檔案名稱。  
  (3) 因為 variant calling 時 output file 改名而造成變動的檔案名稱。  
  (4) split multiallelic 時 input file 和 output file 的檔案名稱。  
  (5) VEP 變數`INPUT_VCF` 和 `SAMPLE_ID` 的檔案名稱
> [!Warning]
> 如果沒有完整修改的話，當 output 檔案名稱與剛剛做出來的檔案名稱相同時，將會覆蓋掉之前的檔案。
5. 執行修改好的 shell script。
---------------------
