#!/bin/bash

# ==============================
# Usage:
# bash extract_only_TP.sh <username> <sample>
# Example:
# bash extract_only_TP.sh evelyn92 SRR13076392
# ==============================

# input
user=$1
sample=$2

# check input
if [ $# -ne 2 ]; then
    echo "Usage: bash extract_only_TP.sh <username> <sample>"
    exit 1
fi

# directories
WORK_DIR=/work/${user}/2026NGS/HW3/output_${sample}/hap
HC_DIR=${WORK_DIR}/hap_HC
M2_DIR=${WORK_DIR}/hap_M2

echo "Working directory: ${WORK_DIR}"
echo "Sample: ${sample}"

# load modules
module load biology
module load Python/2.7.18
module load bcftools

# ==============================
# Step 1: Extract TP variants
# ==============================

echo "Extracting HC TP variants..."
cd ${HC_DIR}
bcftools query -i 'FMT/BD[1]="TP"' \
-f '%CHROM\t%POS\t%REF\t%ALT\n' \
output_prefix.vcf.gz > ${WORK_DIR}/HC_TP_variants.tsv

echo "Extracting M2 TP variants..."
cd ${M2_DIR}
bcftools query -i 'FMT/BD[1]="TP"' \
-f '%CHROM\t%POS\t%REF\t%ALT\n' \
output_prefix.vcf.gz > ${WORK_DIR}/M2_TP_variants.tsv

# ==============================
# Step 2: Remove header (if any) + sort
# ==============================

cd ${WORK_DIR}

# Make sure no header
grep -v "^#" HC_TP_variants.tsv | sort > HC.sorted.tsv
grep -v "^#" M2_TP_variants.tsv | sort > M2.sorted.tsv

# ==============================
# Step 3: Find only variants
# ==============================

echo "Finding HC-only TP variants..."
comm -23 HC.sorted.tsv M2.sorted.tsv > HC_only_TP.tsv

echo "Finding M2-only TP variants..."
comm -13 HC.sorted.tsv M2.sorted.tsv > M2_only_TP.tsv


echo "=============================="
echo "Done!"
echo "Results:"
echo "HC-only TP variants : ${WORK_DIR}/HC_only_TP.tsv"
echo "M2-only TP variants : ${WORK_DIR}/M2_only_TP.tsv"
echo "=============================="
