# UKB_500K_exome_QC

Some scripts to run QC on the UK Biobank 500k exome data


## Environment & requirements
 - This was developed & tested on **RHEL 7**
   - This code was designed to run on UKBB RAP
     - Read Depth & Allele Balance filters were run on RAP
   - YMMV
 - Have either **conda or mamba >= 4.12**

## To Run

```bash
$ mamba env create -f environment.yml
$ mamba activate UKB_500K_exome_QC
$ ./run_all.sh
```

## Steps
There are 5 filters (each one is applied independently). For a (individual, variant) datum to be retained it must pass all filters for its individual & variant
- Individual missingness (row filter)
  1. combine 22 chromosomes into 1 file
  2. each individual we keep must be missing less than 10% of variants
- Variant missingness (column filter)
  1. keep variants missing from less than 10% of people
- Variant HWE (column filter)
  1. compute HWE p-value for all variants
  2. keep variants with HWE p-value > 1e-15
- Variant read depth (column filter)
  1. calculate minimum read depth for each variant
  2. determine whether a variant is a SNP or INDEL
  3. keep variants with sufficient read depth
     - \>= 7 (for SNPs)
     - \>= 10 (for indels)
- Variant allelic balance (column filter)
  1. calculate allelic balance for each sample in each variant
  2. get the highest allelic balance for each variant
  3. determine whether a variant is a SNP or INDEL
  4. keep variants with sufficient allelic balance
     - \>= 0.15 (for SNPs)
     - \>= 0.20 (for indels)    

These steps are derived from the following publication:
> Szustakowski, J.D., Balasubramanian, S., Kvikstad, E. et al. Advancing human genetics research and drug discovery through exome sequencing of the UK Biobank. Nat Genet 53, 942–948 (2021). [https://doi.org/10.1038/s41588-021-00885-0](https://doi.org/10.1038/s41588-021-00885-0)

General steps are outlined above, but Software is provided as is.

Feel free to raise issues, but this project will not be maintained regularly.

⭐ the repo if you found it useful.
---
