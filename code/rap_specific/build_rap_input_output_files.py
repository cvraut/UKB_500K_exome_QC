# this python script combs through the vcf index files we have to build the RAP specific 
# input-output files for the Read Depth and Allelic Balance Filters.

from glob import glob
import os
# note the pVCF files are found in the pVCF folder of data_input dir
DATA_IN = os.environ["DATA_IN"]+"pVCF/"
# how many batch files to put in the output directory
DOWNLOAD_BATCH_SIZE = 96

def get_all_files(ext=""):
  files = [fname.split("/")[-1] for fname in glob(DATA_IN+"*") if fname[(-1*len(ext)):] == ext]
  return files

def get_all_vcf_index_files():
  for fname in get_all_files(".tbi"):
    if "X" not in fname and "Y" not in fname:
      yield fname

def get_all_vcf_files():
  return get_all_files(".vcf.gz")

def get_missing_vcf_files():
  downloaded_vcf_files = set(get_all_vcf_files())
  for vcf_index in get_all_vcf_index_files():
    vcf_file = vcf_index[:-4]
    if vcf_file not in downloaded_vcf_files:
      yield vcf_file

def build_input_list():
  vcf_files = "pVCF/{}"
  with open("vcf.list","w+") as f:
    for fname in get_missing_vcf_files():
      f.write(vcf_files.format(fname)+"\n")

def build_output_list():
  group=0
  with open("out.list","w+") as f:
    for i,fname in enumerate(get_missing_vcf_files()):
      if i%DOWNLOAD_BATCH_SIZE == 0:
        group+=1
      f.write("output/group_{}/{}\n".format(group,fname))

if __name__ == "__main__":
  print(len(list(get_all_vcf_index_files())))
  print(len(get_all_vcf_files()))
  print(len(list(get_missing_vcf_files())))

  build_input_list()
  build_output_list()