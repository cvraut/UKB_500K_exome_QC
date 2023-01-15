# Notes

Running list of all I have done & plan to do with this project

## 2023 01 15
- so group 4 & 5 are finished
  - We halfway there lads!
- processing of group 4 & 5 still looks good
  - still at 88% variant retention 👍

## 2023 01 14
- so group 2 & 3 are finished & results have been downloaded
- it seems like the analysis is speeding up for some reason, but I should need 94 more hours to finish at this rate


## 2023 01 13
- so rap script is still running
- gonna create a notebook to assess the output to see if certain groups have finished
  - so group 1 is finished
  - it took 17 hours for group 1 to finish ... this might be close since we currently 10 british pounds over-budget
    - the rap seems to be running far slower than normal :/
  - checked the group 1 results ... looks like this filter keeps about 88% of the variants, so we should have about 23_000_000 variants at the end of the procedure

## 2023 01 12
- so I backed up the repo to the depreciated folder, will pursue heavy refactoring as I figure out the policy for a clean RAP install and proceed with it
- lots of cleanup, but I think I am ready for the big run
- gonna start it today & will update the notes with the progress
- put it on the same type of instance (estimated cost is 200 pounds)
  - start time: 2023-01-12 5:15pm ET
  - pray for my sanity until this job gets finished 🙏

## 2023 01 11
- so the 90 pct cutoff I had seems like it works
  - doesn't eliminate too many variants
  - fast
  - lightweight
- now we just need to come up with a system to batch the results on the RAP as they come in ... like a 1 line bashscript to figure it out would be pretty nice

## 2023 01 10
- so updated code with 90% cutoff ran in:
  ```
  real    259m39.659s 
  user    3778m23.814s
  sys     95m1.616s 
  ```
  - so that's a third of the time ... massive speedup!
  - but now to check whether this speedup makes sense ... 

## 2023 01 09
- started check on 90% cutoffs
- current updated version of code takes:
  - 4m11.777s to finish 360 snps (v1_1)
  - 4m9.669s  to finish 360 snps (v1_2)
    - no difference ... yay!
  - 4m14.174s to finish 360 snps (v1_3)
  - 4m12.146s to finish 360 snps (v1_4)
    - this should be the fastest & handle the high missing cases super fast too
    - only next step would be early term on read depth ... count the number of rd < 10 & break early if it exceeds 10% of the data
  - 5m21.648s to finish 360 snps (v1_5)
  - 4m13.523s to finish 360 snps (v1_6)
    - this time I vectorized instead of early term
- started the runs on the whole data using the 90% cutoff instead

## 2023 01 02
- servers were rebooted
  - ran some checks to verify

## 2022 12 05
- starting up this repo again
- want to understand how a lower quartile read depth will affect the results

## 2022 11 16
- trying the AD & AB process scripts on RAP
  - I selected "mem2_ssd1_v2_x96" to run until midnight costing 32 pounds
  - I have intelligently decided to do the 1st 96 batch files from chromosome 1 as the rap test
    - knowing there was a 6-7 file overlap to make sure results were identical across platforms
  - so the initial runs consisted of many steps
    - all documented in `running_on_rap_notes.txt`
    - 10 pVCF files from chr1 --> first 360 variants
      - took about 5 minutes
    - 96 pVCF files from chr1 --> first 360 variants
      - took about 13 minutes
      - max RAM use < 10GB
      - download of tar_gzipped results --> 656KB happened instantly
    - 96 pVCF files from chr1 --> all variants
      - max RAM use < 205GB
      - started at 11:05 AM
      - estimating it should take between 8-18 hours
      - took ~750 min to analyze just under a tenth of the pVCF files
      - resulting compressed results were ~42 MB
  - total cost was 36.6 pounds
    - needed to increase duration to ensure all pVCF's finished


## 2022 10 27
- So I ran some evaluations with Xiaomeng's GATK and my bcftools approach on read depth & allele balance filtering
  - GATK takes way longer, like 11 hours per file
  - bcftools is much quicker, like 5 hours per file
  - GATK does not do the read depth filtering
    - it also handles the 0 reads case very weirdly compared to my approach
  - when I stick to read depth filter & the allele balance filter
    - bcf approach filters about the same proportion of variants
    - however few variants get mutually removed by bcftools and gatk
    - if I consider the cases where minimum sample read depth is 1, then I hit way more using bcftools, but none of the gatk filtered variants make it
  - I am thinking for this filter, under the hood I will require that the variants have at least 1 read depth in 1st quartile of samples, but I won't say nothing about it
  - all in all this step should eliminate ~25% of the variants using the bcftools approach & ~0.5% of the variants using the gatk approach
  - I think this should still be "fine"

## 2022 10 26
- So last night I downloaded the pVCF for chromosome 21
  - I want to see how to compute the variant level filters on that one

## 2022 10 25
- So we have the 500k exome data, but we do not know the extent of the QC procedures they applied to it
  - We know that they followed the OQFE protocol
  - after that we don't know if they did anything different
- So I checked the missingness from the bgen variants, they did not run the QC procedure from the 2020 ukbb paper
  - they include some variants which are missing from all individuals
- Yanhua pointed me to a QC file which they recommend using.
  - I downloaded it & it seems like they use a different format for the SNP id which is worrying
  - yep just confirmed the 500k release uses a different format for the INDEL variants :/
  - this means that the analysis I currently have running is prolly for naught
- I looked at the file Yanhua sent & it's not good. Only 5 million of the 25 million exome variants are in that list which is way less than the 200k exome release


## 2022 07 27
 - We don't have the 500K exome data
 - We will not get the 500K exome data soon
   - UK Biobank have changed their data access policies
     - [July 22nd Data Access Policy](https://www.ukbiobank.ac.uk/media/najcnoaz/access_064-uk-biobank-exome-release-faq_v11-1_final-002.pdf)
     - ![How do we access these files](./notes/20220727_notes_pic1.png)
     - It will be very expensive to acquire the 500K data now:
       - [Transactional Arrangements & Fees](https://www.ukbiobank.ac.uk/enable-your-research/costs/transitional-arrangements-and-faqs)
     - ![Fee Access Structure](./notes/20220727_notes_pic2.png)
     - I think we can get away with 1500 pounds as I can qualify as student researcher
     - We need Tier 3 access as this is the one that has exome data
 - update: Liz knows about this & has assigned someone to get me the 500K data ASAP

## 2022 07 26
 - started the github
 - began migrating some files from the depths of the drive
 - I have many Questions 😵
   - old_notes:
     - line 22:
       - Am I supposed to run this once per chromosome or file pair?
       - where is the output created?
 - requested the 500k exome data file
   - Yanhua is on it 😎 (will prolly take couple days for the result)
 - went through the old readme, things are making a bit more sense
   - I think I am ready for QC with the 500k exome data now