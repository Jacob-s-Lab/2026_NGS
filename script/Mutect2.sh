############################################
# Calling variants by GATK Mutect2 #
############################################
echo "variant calling: start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

gatk Mutect2 \
  -R ${ref} \
  -I ${DIR_ALN}/${sample}.sorted.markdup.bam \
  -O ${sample}.sorted.markdup.M2.vcf.gz \
  --bam-output ${sample}.sorted.markdup.M2.bam \
  -L chr1 -L chr2 -L chr3 -L chr4 -L chr5 -L chr6 -L chr7 -L chr8 -L chr9  \
  -L chr10 -L chr11 -L chr12 -L chr13 -L chr14 -L chr15 -L chr16 -L chr17  \
  -L chr18 -L chr19 -L chr20 -L chr21 -L chr22

echo "variant calling: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

#####################################
# Convert M2 bamout BAM to M2 CRAM  #
#####################################
echo "convert M2 bamout to cram: start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

samtools view -@ 2 -C -T ${ref} \
  -o ${sample}.sorted.markdup.M2.cram \
  ${sample}.sorted.markdup.M2.bam

samtools index -@ 2 ${sample}.sorted.markdup.M2.cram

echo "convert M2 bamout to cram: finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
