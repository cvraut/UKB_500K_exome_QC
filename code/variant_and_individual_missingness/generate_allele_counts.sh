#!/bin/bash
# This file uses PLINK2 to determine the allele frequencies and missingness counts of the UKBB WES bgen data
# note: the WES was downloaded as bgen --> then converted to PLINK format

cd ${DATA_OUT}
mkdir -p allele_counts

for ((i=1;i<=22;i++))
do
cd ${DATA_OUT}allele_counts
mkdir -p chr${i}
cd chr${i}

plink2 --bgen ${DATA_IN}BGEN/ukb23159_c${i}_b0_v1.bgen 'ref-first' \
       --sample ${DATA_IN}BGEN/ukb23159_c${i}_b0_v1.sample \
       --freq counts \
       --geno-counts \
       --missing \
       --out var_counts
done

pwd