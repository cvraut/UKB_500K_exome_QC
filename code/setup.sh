# This file creates environment variables that get used by the rest of the project

PROJECT_LOC=~/wkspce/UKB_500K_exome_QC/
export PROJECT_LOC

RAND_SEED=19890418
export RAND_SEED

DATA_OUT=/mnt/speliotes-lab/Projects/UK_ATLAS/IndivProj/craut/UKB_500K_exome_QC/
export DATA_OUT
mkdir -p ${DATA_OUT}

DATA_IN=/mnt/speliotes-lab/Projects/UK_ATLAS/GENODATA/Exomechip_10_13_2022/pVCF/
export DATA_IN