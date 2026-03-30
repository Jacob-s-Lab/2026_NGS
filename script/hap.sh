#!/usr/bin/sh
#SBATCH -A ACD114093          # Project name: The project number for our class.
#SBATCH -J hap                # Job name: You can change this to any name you prefer.
#SBATCH -p ngscourse          # Partition Name
#SBATCH -c 2                  # Number of CPU cores
#SBATCH --mem=13g             # Memory allocation
#SBATCH -o hap_HC_out.log     # -o: This exports the out.log file, which will record the steps executed by the program.
#SBATCH -e hap_HC_err.log     # -e: This exports the err.log file, which will record any failures; if not specified otherwise, both log files will be located in the current directory of the SH file.
#SBATCH --mail-user=          # Here, you can input your email. An email will be sent to you if the next line's conditions are met.
#SBATCH --mail-type=END       # Email will be sent when the job ends.


set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

# Please enter the your username and sample name
user=username
sample=SRR13076392
IN_DIR=/work/${user}/result/analysys

# output
OUT_DIR=/work/${user}/result/analysys/output_${sample}
mkdir -p ${OUT_DIR}
cd ${OUT_DIR}

#REF_PATH=/opt/ohpc/Taiwania3/pkg/biology/reference
truth=${IN_DIR}/KnownPositives_hg38_Liftover.vcf
query=${OUT_DIR}/VC/${sample}.sorted.markdup.HC.vcf.gz

REF_DIR=/opt/ohpc/Taiwania3/pkg/biology/reference

# module load old-module
module load biology
module load Python/2.7.18
module load bcftools

## create a new directory for hap
DIR_hap=${OUT_DIR}/hap
mkdir -p ${DIR_hap}
DIR_hap_HC=${DIR_hap}/hap_HC
mkdir -p ${DIR_hap_HC}
cd ${DIR_hap_HC}
echo "pwd for hap: "
pwd


########################################
# Restrict variants to biallelic sites #
########################################
echo "bcftools start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

bcftools view \
-m2 \
-M2 \
${query} \
-Oz \
-o ${DIR_hap_HC}/${sample}.HC.modified.vcf.gz
bcftools index ${DIR_hap_HC}/${sample}.HC.modified.vcf.gz

echo "bcftools finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


query_modified=${DIR_hap_HC}/${sample}.HC.modified.vcf.gz
export HGREF=${REF_DIR}/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta
##########
# hap.py #
##########
echo "hap.py start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

/opt/ohpc/Taiwania3/pkg/biology/illumina_hap.py/hap.py_v0.3.15/bin/hap.py ${truth} ${query_modified} \
--filter-nonref \
-f ${IN_DIR}/High-Confidence_Regions_v1.2.bed.gz \
-o ${DIR_hap_HC}/output_prefix \
-r ${REF_DIR}/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta \
--leftshift \
--bcftools-norm 

echo "hap.py finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

printf "##############################################################################\n"
printf "###              Work completed: $(date '+%Y-%m-%d %H:%M:%S')              ###\n"
printf "##############################################################################\n"
