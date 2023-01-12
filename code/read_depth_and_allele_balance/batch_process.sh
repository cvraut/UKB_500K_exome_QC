# this function is a parallel helper for UKBB 500k exome QC
# specifically for each variant in a pVCF file it computes 
# the average read depth, minimum read depth, and the best 
# allele balance (early term at >0.2)
# this script uses bcftools & python>=3.9

# all code has bugs & problems. Be kind :)

Help()
{
   # Display Help
   echo "############# batch_process.sh #########################"
	 echo "Description: <whatever this script actually does>"
   echo
   echo "Syntax: scriptTemplate (-h)|(-f=.* -o=.*)"
   echo "options:"
	 echo "-h   | --help            Display this help prompt"
   echo "-f=* | --file=*          Path to the pVCF file."
   echo "-o=* | --out=*           Path/file to the output file."
	 echo
	 echo "examples:"
	 echo "\$ batch_process.sh -f=${DATA_IN}ukb23157_c21_b4_v1.vcf.gz -o=ukb23157_c21_b4_v1.vcf.gz.txt"
   echo
	 echo "contact <craut at umich.edu> for support"
}

### handle input args
# set default

# coallate all the inputs
VALID_ARGS=$(getopt -o "hf:o:" -l "help,file:,out:" -- "$@")
# check for invalid options
if [[ $? -ne 0 ]]; then
  exit 1;
fi

eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
    -h | --help)
        Help
				exit 0
        ;;
    -f | --file)
				file=$(echo "$2" | sed -e "s/^=//" -e "s/$//"); #remove any unwanted leading or trailing characters
        shift 2
        ;;
    -o | --out)
				out=$(echo "$2" | sed -e "s/^=//" -e "s/$//");
        shift 2
        ;;
    --) shift; 
        break 
        ;;
  esac
done

SECONDS=0

bcftools query -f "%CHROM\t%POS\t%ID\t[ %DP]\t[ %AD]\n" ${file} | python batch_process.py > ${out}

#echo ${file} > ${out}

echo ${file} "done"
echo $SECONDS "seconds"
