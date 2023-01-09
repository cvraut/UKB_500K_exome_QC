# this script runs through the vcf file read depth and allele depth data to 
# compute read depth and allele balance summaries for each variant in a pVCF file
# how to use:
# time bcftools query -f '%CHROM\t%POS\t%ID\t[ %DP]\t[ %AD]\n' ${DATA_IN}ukb23157_c21_b10_v1.vcf.gz > test.output3

import sys
import numpy as np

N_ind = 469835
offset = 3

LOW_DEPTH = 7 # this is low depth for a snp

target_dp_prop = 0.9 # calculate the read depth for the 10% percentile (90% have more) accounting for missing = 0
ind_for_90pct = N_ind*target_dp_prop
ind_for_early_term = int(N_ind*(1-target_dp_prop))

if __name__ == "__main__":
  lim = 360

  for line in sys.stdin:
    line = line.strip().split()
    snp_id = line[2]
    # dot means that value is missing
    dp = np.asarray([c for c in line[offset:N_ind+offset] if c != "."]).astype('int')
    target_prop = (ind_for_90pct+(N_ind-len(dp)))/N_ind
    target_prop = int(100*(1-target_prop))
    num_low_depth = N_ind - len(dp)
    depth = 0
    if np.sum(dp<7)+num_low_depth >= ind_for_early_term:
      pass
    else:
      depth = np.percentile(dp,target_prop)
    if depth == 0:
      print(snp_id,0.0,0.0)
    elif ";" in snp_id:
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
        #print(snp,np.mean(dp),abl,sep="\t")
        print(snp,depth,abl,sep="\t")
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
      #print(snp_id,np.mean(dp),abl,sep="\t")
      print(snp_id,depth,ab,sep="\t")
    if lim == 0:
      break
    else:
      lim-=1