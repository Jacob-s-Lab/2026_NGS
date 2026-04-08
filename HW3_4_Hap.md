# 次世代定序、生物資訊學與基因體醫學(VI)

## 本次課程主要內容
學習利用`hap.py`比較 Haplotypecaller 和 Mutect2 的分析結果，以了解它們在不同情境下的性能和準確性。
> [!Warning]
> #### 前情提要：需先完成VariantCalling的tutorial！！
> 如果尚未完成請先回到 [HW3_2_VC.md](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/HW3_2_VC.md) 完成 tutorial 的內容~

> [!Caution]
> **運算時間: 30 m**

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
   (2)🟡 **黃色** 部分：改成自己的sample。  \
   (3)🔵 **藍色** 的部分：須注意是 **Haplotypecaller 或是 Mutect2 的檔案**。  \
   ![螢幕擷取畫面 2026-03-30 133405](https://hackmd.io/_uploads/BJ0NhKPiZl.png)
   ![螢幕擷取畫面 2026-04-07 120630](https://hackmd.io/_uploads/rJuPm-zhZe.png)

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
rsync -avz /work/evelyn92/rocplot/rocplot.Rscript ./
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
![螢幕擷取畫面 2026-04-05 002000](https://hackmd.io/_uploads/SJNpq2CoWx.png)

4. 執行`rocplot.sh`
```
sbatch rocplot.sh
```

5. 得到結果存於`rocplot`資料夾，裡面各有兩張圖。

例如：
- HaplotypeCaller 及 Mutect2 在 SNP 的結果比較：
![hap_plot.SNP](https://hackmd.io/_uploads/H1JO0jAoWg.png)

- HaplotypeCaller 及 Mutect2 在 Indel 的結果比較：
![hap_plot.INDEL](https://hackmd.io/_uploads/r1qdRjCi-l.png)

6. 打開 IGV 比較`hap.py`的結果。

(1)先比較HaplotypeCaller 及 Mutect2 找出只有一個工具有call出的pathogenic gene。  \
**提示:開啟`sample.HC.VEP.tsv` 和 `sample.M2.VEP.tsv` 用檔案內提供的數據來判斷  \
[(tsv檔案講解說明)](https://github.com/Jacob-s-Lab/2026_NGS/blob/main/HW3_3_VEP.md)**

(2)用ThinLinc開啟IGV
```
sh /opt/ohpc/Taiwania3/pkg/biology/IGV/IGV_v2.10.3/igv.sh
```
(3) 左上角下拉選擇Human hg38
![螢幕擷取畫面 2026-04-05 001518](https://hackmd.io/_uploads/H13uoh0i-l.png)

(4)透過左上角的File → Load from file可匯入儲存`hap.py`結果的檔案 (兩種工具各一個，共要匯入兩個檔案)
- file 1:`/work/username/result/analysis/output_sample/hap/hap_HC/output_prefix.vcf.gz`
- file 2:`/work/username/result/analysis/output_sample/hap/hap_M2/output_prefix.vcf.gz`

(5)進行工具間的比較
    舉例：某 sample 在 `chr2:218164209` 這個位點可以在 Mutect2 被找到，但在 Haplotypecaller 找不到。
![螢幕擷取畫面 2026-04-04 234121](https://hackmd.io/_uploads/B1TJ_h0sWx.png)

### step 3 找出被判定為 true positive（TP），且僅由其中一個 variant caller 成功呼叫（called）的變異。
1. 複製需執行檔
```
cd /work/username/result/analysis
rsync -avz /work/evelyn92/2026NGS/HW3/extract_only_TP.sh ./
```
2. 執行[`extract_only_TP.sh`]()
```
# Usage:
bash extract_only_TP.sh <username> <sample>
# Example:
bash extract_only_TP.sh evelyn92 SRR13076392
```
3. 得到結果 : 共4個檔案
HC.sorted.tsv
M2.sorted.tsv
HC_only_TP.tsv: **經hap判定為true positive(TP)，且僅由 HaplotypeCaller 呼叫到的變異**
M2_only_TP.tsv: **經hap判定為true positive(TP)，且僅由 Mutect2 呼叫到的變異**
