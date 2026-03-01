#!/usr/bin/sh
#SBATCH -A MST109178          # Account name/project number
#SBATCH -J fastp              # Job name
#SBATCH -p NGS_t2             # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 14                 # 使用的core數 請參考Queue資源設定
#SBATCH --mem=92g             # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o p_out.log          # Path to the standard output file
#SBATCH -e p_err.log
#SBATCH --mail-user=
#SBATCH --mail-type=END


set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


# Please enter the R1 & R2 file name and your username
user=jacobhsu
IN_DIR=/staging/reserve/${user}/SEQC2
sample=SRR13076390
R1=${IN_DIR}/${sample}_1.fastq.gz
R2=${IN_DIR}/${sample}_2.fastq.gz


# output
OUT_DIR=/work/evelyn92/2026NGS/HW1/fastp_${sample}
mkdir -p ${OUT_DIR}

OUT1=${OUT_DIR}/${sample}_1.clean.fastq.gz
OUT2=${OUT_DIR}/${sample}_2.clean.fastq.gz
HTML=${OUT_DIR}/${sample}.html
JSON=${OUT_DIR}/${sample}.json


## Set up the environment for running fastp
module load biology
module load fastp


## Analyzing your sample's sequence QC by fastp
echo "fastp start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

fastp \
  -i ${R1} -I ${R2} \
  -o ${OUT1} -O ${OUT2} \
  -h ${HTML} -j ${JSON} \
  -w 3

echo "fastp finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
#------------fastp finished------------#
