# this function runs step2 for all chromosomes in parallel

#!/usr/bin/env bash

# @article{Tange2011a,
#   title = {GNU Parallel - The Command-Line Power Tool},
#   author = {O. Tange},
#   address = {Frederiksberg, Denmark},
#   journal = {;login: The USENIX Magazine},
#   month = {Feb},
#   number = {1},
#   volume = {36},
#   url = {http://www.gnu.org/s/parallel},
#   year = {2011},
#   pages = {42-47},
#   doi = {http://dx.doi.org/10.5281/zenodo.16303}
# }

# migrate to the working dir

parallel --link ./batch_process_updated.sh --file={1} --out={2} :::: vcf.list out.list