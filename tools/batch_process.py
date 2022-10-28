# this script runs through the vcf file read depth and allele depth data to 
# compute read depth and allele balance summaries for each variant in a pVCF file
# how to use:
# time bcftools query -f '%CHROM\t%POS\t%ID\t[ %DP]\t[ %AD]\n' ${DATA_IN}ukb23157_c21_b10_v1.vcf.gz > test.output3

import sys
import numpy as np

N_ind = 469835
offset = 3



if __name__ == "__main__":
  # lim = 360

  for line in sys.stdin:
    line = line.strip().split()
    snp_id = line[2]
    # dot means that value is missing
    dp = np.asarray([c for c in line[offset:N_ind+offset] if c != "."]).astype('int')
    if ";" in snp_id:
      snp_id = snp_id.split(";")
      ab = [0]*len(snp_id)
      for ra in line[N_ind+offset:2*N_ind+offset]:
        if ra == ".":
          # this means that value is missing
          continue
        ref_alts = list(map(lambda x: int(x) if x != "." else 0,ra.split(",")))
        total = sum(ref_alts)
        for i in range(len(snp_id)):
          if total > 0:
            ab_temp = ref_alts[i+1]/total
            if ab_temp > ab[i]:
              ab[i] = ab_temp
        if min(ab) >= 0.2:
          break
      for snp,abl in zip(snp_id,ab):
        print(snp,np.mean(dp),np.percentile(dp,25),min(dp),abl,sep="\t")
    else:
      ab = 0
      for ra in line[N_ind+offset:2*N_ind+offset]:
        if ra == ".":
          # means that value is missing
          continue
        r,a = map(lambda x: int(x) if x != "." else 0,ra.split(","))
        if r+a > 0:
          ab_temp = a/(r+a)
          if ab_temp > ab:
            ab = ab_temp
          if ab >= 0.2:
            break
      print(snp_id,np.mean(dp),np.percentile(dp,25),min(dp),ab,sep="\t")
    # if lim == 0:
    #   break
    # else:
    #   lim-=1