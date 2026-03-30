#!/usr/bin/sh
#SBATCH -A ACD114093          # Project name: The project number for our class.
#SBATCH -J roc                # Job name: You can change this to any name you prefer.
#SBATCH -p ngscourse          # Partition Name
#SBATCH -c 2                  # Number of CPU cores
#SBATCH --mem=13g             # Memory allocation
#SBATCH -o roc_HC_out.log     # -o: This exports the out.log file, which will record the steps executed by the program.
#SBATCH -e roc_HC_err.log     # -e: This exports the err.log file, which will record any failures; if not specified otherwise, both log files will be located in the current directory of the SH file.
#SBATCH --mail-user=          # Here, you can input your email. An email will be sent to you if the next line's conditions are met.
#SBATCH --mail-type=END       # Email will be sent when the job ends.


# Please enter the your username and sample name
user=username
sample=SRR13076392
IN_DIR=/work/${user}/result/analysys

# output
OUT_DIR=/work/${user}/result/analysys/output_${sample}
mkdir -p ${OUT_DIR}
cd ${OUT_DIR}

# create a new directory for rocplot
DIR_roc=${OUT_DIR}/rocplot
mkdir -p ${DIR_roc}
cd ${DIR_roc}
echo "pwd for rocplot: "
pwd

Rscript ${IN_DIR}/rocplot_test.Rscript hap_plot -pr ${OUT_DIR}/hap/hap_HC/output_prefix:${sample}
