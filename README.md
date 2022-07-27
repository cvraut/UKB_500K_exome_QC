# UKB_500K_exome_QC

Some scripts to run QC on the UK Biobank 500k exome data


## Environment & requirements
 - This was developed & tested on **RHEL**
   - YMMV
 - Have either **conda or mamba >= 4.12**

## To Run

```bash
$ mamba env create -f environment.yml
$ mamba activate UKB_500K_exome_QC
$ ./run_all.sh
```

## Steps
 1. filter out individuals with missingness < 10%
    1. combine 22 chromosome into one file
    2. create exclusion list of individuals with filter: missingness < 10%
    3. for each chromosome, apply filter of individual missingness
 2. filter out variants with low coverage depth
    1. read coverage depth of < 7 (for SNPs) & < 10 (for indels)
 3. ensure at least one sample per site passed allele balance threshold
    1. allele balance threshold > 0.15 (for SNPs) & > 0.20 (for indels)
 3. filter out variant missingness < 10% or Hardy Weinberg Equilibrium p-value>10^-15
    



---
## Note

This QC procedure is what [Speliotes Lab](spelioteslab.com/) uses.

General steps are outlined above, but Software is provided as is.

Feel free to raise issues, but this project will not be maintained regularly.

⭐ the repo if you found it useful.
---
