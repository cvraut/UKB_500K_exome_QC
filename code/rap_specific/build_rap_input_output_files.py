# this python script combs through the vcf index files we have to build the RAP specific 
# input-output files for the Read Depth and Allelic Balance Filters.

from glob import glob
import os
# note the pVCF files are found in the pVCF folder of data_input dir
DATA_IN = os.environ["DATA_IN"]


def get_all_vcf_index_files():
  return DATA_IN

if __name__ == "__main__":
  print(get_all_vcf_index_files())