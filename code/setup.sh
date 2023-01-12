#!/bin/bash
# This file creates environment variables that get used by the rest of the project

# Check if the "UKB_500K_exome_QC" conda environment exists
FOUND_ENV=$(conda info --envs | grep "UKB_500K_exome_QC")

if [ -z "$FOUND_ENV" ]; then # check if variable is empty
    # Print an error message
    echo -e "UKB_500K_exome_QC not found for $USER.\nRemember to run '\$ mamba env create -f environment.yml'"
else
    # Tell user to activate environment
    echo -e "Found environment for UKB_500K_exome_QC.\nRemember to run '\$ conda activate UKB_500K_exome_QC'"
fi

# the rest of the environment variables (should change to address personal preferences)
PROJECT_LOC=~/wkspce/UKB_500K_exome_QC/
export PROJECT_LOC

RAND_SEED=19890418
export RAND_SEED

DATA_OUT=/mnt/speliotes-lab/Projects/UK_ATLAS/IndivProj/craut/UKB_500K_exome_QC/
export DATA_OUT
mkdir -p ${DATA_OUT}

DATA_IN=/mnt/speliotes-lab/Projects/UK_ATLAS/GENODATA/Exomechip_10_13_2022/
export DATA_IN