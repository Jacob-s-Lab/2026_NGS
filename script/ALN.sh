#!/usr/bin/sh
#SBATCH -A MST109178          # Account name/project number
#SBATCH -J NGS                # Job name
#SBATCH -p ngs1T_18           # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 18                 # 使用的core數 請參考Queue資源設定
#SBATCH --mem=1000g           # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o out.log            # Path to the standard output file
#SBATCH -e err.log            # Path to the standard error ouput file
#SBATCH --mail-user=          # email
#SBATCH --mail-type=END       # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL

set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


# Please enter the R1 & R2 file name and your username
user=username
IN_DIR=/work/${user}/result/fastq
sample=SRR13076392
R1=${IN_DIR}/${sample}_1.fastq.gz
R2=${IN_DIR}/${sample}_2.fastq.gz

echo "pwd for analysis reault: "
pwd

# output
OUT_DIR=/work/${user}/result/analysis/output_${sample}
mkdir -p ${OUT_DIR}
cd ${OUT_DIR}

# ------------------------------------ #
# Please don't change the script below #
# ------------------------------------ #
# Reference: Homo_sapiens_assembly38.fasta
ref=/opt/ohpc/Taiwania3/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta

echo "Analysis started"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

echo "+----------alignment----------+"
# Create a new directory for alignment
DIR_ALN=${OUT_DIR}/ALN
mkdir -p ${DIR_ALN}
cd ${DIR_ALN}

echo "pwd for alignment: "
pwd

# Create the environment for alignment
module load biology
module load BWA/0.7.17
module load SAMTOOLS/1.18
set -euo pipefail

##############################
# Mapping reads with BWA-MEM #
##############################
echo "Mapping Reads: Start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

bwa mem -M -R "@RG\tID:GP_${sample}\tSM:SM_${sample}\tPL:ILLUMINA" -t 40 -K 1000000 ${ref} ${R1} ${R2} > ${sample}.sam

echo "Mapping Reads: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

######################################################
# Preparing for bam file  (sorting & indexing) #
######################################################
echo "preparing for bam file: start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

samtools view -@ 2 -S -b ${sample}.sam > ${sample}.bam
samtools sort -@ 2 ${sample}.bam -o ${sample}.sorted.bam
samtools index -@ 20 ${sample}.sorted.bam
echo "bam file has already prepared"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

###################
# Mark duplicates #
###################
echo "Mark duplicates: Start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

PICARD=/work/opt/ohpc/Taiwania3/pkg/biology/Picard/picard_v2.27.4/share/picard-2.27.4-0/picard.jar
java -jar ${PICARD} MarkDuplicates -I ${sample}.sorted.bam -O ${sample}.sorted.markdup.bam -M ${sample}_markdup_metrics.txt --CREATE_INDEX true

echo "Mark duplicates: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
