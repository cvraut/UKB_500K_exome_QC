#!/bin/bash

# this script setups up the env on the rap

# give the conda installations in a neat copy paste format
echo -e "Run following conda install cmds:\n"
echo -e "conda install -c bioconda -y bcftools\nconda install -c conda-forge -y numpy\nconda install -c conda-forge -y htop\nconda install -c conda-forge -y parallel\n"

# link the input to the home dir:
cd /opt/notebooks
ln -s /mnt/project/Bulk/Exome\ sequences/Population\ level\ exome\ OQFE\ variants\,\ pVCF\ format\ -\ final\ release/ pVCF

# create the output dirs
mkdir -p output
for ((i=1;i<=10;i++))
do
  cd /opt/notebooks/output
  mkdir -p group${i}
done