# 次世代定序、生物資訊學與基因體醫學(VI)

## 本次課程主要內容
學習利用`hap.py`比較 Haplotypecaller 和 Mutect2 的分析結果，以了解它們在不同情境下的性能和準確性。


> [!Warning]
> #### 前情提要：需先準備好之前 tutorial 做完的兩種 VariantCalling: HaplotypeCaller 及 Mutect2 的結果！！
> 如果尚未完成請先回到 [variantcalling.md] 完成 tutorial 的內容~

> [!Important]
> #### 什麼是`hap.py`？
> `hap.py`（Haplotype Comparison Tools）是一個用於比較基因組變異的工具。它經常被用來評估 variant calling 算法的準確性，特別是在體細胞或生殖細胞中的 SNPs 和 Indels 等變異的識別。`hap.py` 可以用來對比 variant calling 結果與已知的標準答案（例如 gold standard VCF ），以評估變異檢測方法的靈敏度 (Recall)、精確度 (Precision)等指標。

### step 1 : 執行 [`hap.py`](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/script/hap.sh)

1. 複製上課所需執行檔與標準檔。
```markdown=
cd /work/username/result/analysis
rsync -avz /work/evelyn92/2026NGS/HW3/hap.sh ./
rsync -avz /work/evelyn92/KnownPositives_hg38_Liftover.vcf ./
rsync -avz /work/evelyn92/High-Confidence_Regions_v1.2.bed.gz ./
```

2. 打開`hap.sh`並寫入正確的路徑名稱。  \
   (1)🔴 **紅色** 部分：**username** 改成自己的。  \
   (2)🟡 **黃色** 部分：改成自己的sample。  
   ![螢幕擷取畫面 2026-03-30 133405](https://hackmd.io/_uploads/BJ0NhKPiZl.png)


> [!Important]
> #### 提醒：
> **bcftools 命令的部分是將 vcf 檔中的 multialelic 去除，以便`hap.py`可以讀取。**
> 

3. 執行```hap.sh```
```
sbatch hap.sh
```
4. 得到結果 : 共11個檔案。
- output_prefix.runinfo.json
- output_prefix.metrics.json.gz
- output_prefix.roc.Locations.SNP.csv.gz
- output_prefix.roc.Locations.SNP.PASS.csv.gz
- output_prefix.roc.Locations.INDEL.csv.gz 
- output_prefix.roc.Locations.INDEL.PASS.csv.gz
- output_prefix.roc.all.csv.gz
- output_prefix.summary.csv
- output_prefix.extended.csv
- output_prefix.vcf.gz
- output_prefix.vcf.gz.tbi


### step 2 : 利用 [`rocplot.sh`](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/script/rocplot.sh) 結果製作 ROC 圖

1. 複製上課所需執行檔。
```markdown=
cd /work/username/result/analysis
rsync -avz /work/evelyn92/2026NGS/HW3/rocplot.sh ./
rsync -avz /work/evelyn92/rocplot/rocplot_test.Rscript ./
```
2. 進入R，載入需要的 package
```markdown=
R
install.packages("ggplot2")
61
install.packages("tools")
q()
n
```

3. 更改正確路徑  \
   (1)🔴 **紅色** 的部分：需換成自己的 **username**。  \
   (2)🟡 **黃色** 部分：改成自己的sample。  \
   (3)🔵 **藍色** 的部分：須注意是 **Haplotypecaller 或是 Mutect2 的檔案**。  \
![螢幕擷取畫面 2026-03-30 170606](https://hackmd.io/_uploads/H1HtphwsZl.png)


5. 執行`rocplot.sh`
```
sbatch rocplot.sh
```
5. 得到結果存於 rocplot_HC 或 rocplot_M2 資料夾，裡面各有兩張圖。


例如：
- S14, S15, S18 Mutect2 在 SNP 的結果比較：
![hap_plot.SNP](https://hackmd.io/_uploads/SJz1Ym6Tee.png)




- S14, S15, S18 Mutect2 在 Indel 的結果比較：
![hap_plot.INDEL](https://hackmd.io/_uploads/H17xYQTaxx.png)


6. 也可以打開 IGV 比較`hap.py`的結果。
結果儲存於```output_prefix.vcf.gz```
- 工具間的比較：
    舉例：S18 Mutect2 及 Haplotypecaller 的 SNP 比較，在 chr1 的241,884,674這個位點可以在 Haplotypecaller 被找到，但在 Mutect2 找不到。
![螢幕擷取畫面 2025-10-15 214642](https://hackmd.io/_uploads/S1CWFQpTee.png)
- 樣本間的比較：
    舉例：S14, S15, S18 Mutect2 的 SNP 比較。
![樣本間比較](https://hackmd.io/_uploads/BkJmFQapee.png)
