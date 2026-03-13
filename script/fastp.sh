#!/usr/bin/sh
#SBATCH -A MST109178          # Account name/project number
#SBATCH -J fastp              # Job name
#SBATCH -p NGS_t2             # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 14                 # 使用的core數 請參考Queue資源設定
#SBATCH --mem=92g             # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o out.log            # Path to the standard output file
#SBATCH -e err.log            # Path to the standard error ouput file
#SBATCH --mail-user=          # email
#SBATCH --mail-type=END      # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL

#---------------------------------#
# 👆請依據 tutorial 的指示修改 SLURM #
#---------------------------------#

set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

#---------------------------------------------#
# 👇請依據 tutorial 的指示修改 username 和sample #
#---------------------------------------------#

# Please enter the R1 & R2 file name and your username
user=username
IN_DIR=/work/${user}/result/fastq
sample=SRR13076392
R1=${IN_DIR}/${sample}_1.fastq.gz
R2=${IN_DIR}/${sample}_2.fastq.gz


# output
OUT_DIR=/work/${user}/result/fastp_${sample}
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

#-------------------------------#
# 👇請依據 tutorial 指示修改 input #
#-------------------------------#

fastp \
  -i ${R2} -I ${R2} \
  -o ${OUT1} -O ${OUT2} \
  -h ${HTML} -j ${JSON} \
  -w 3

echo "fastp finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
#------------fastp finished------------#
