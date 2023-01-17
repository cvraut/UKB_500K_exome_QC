#!/bin/bash
# This file uses PLINK2 to filter the downloaded WES bgen file based on the list of variants produced by the
# Aggregate_All_QC_Filters.ipynb file.

cd ${DATA_OUT}

for ((i=1;i<=22;i++))
do
cd ${DATA_OUT}final_qc_plink/chr${i}

plink2 --bgen ${DATA_IN}ukb23159_c${i}_b0_v1.bgen 'ref-first' \
       --sample ${DATA_IN}ukb23159_c${i}_b0_v1.sample \
       --extract final_qced_variants.list \
       --make-bed \
       --out ukbb_500k_exome_final_qced_hq_chr${i}
done

pwd