#!/usr/bin/env bash
# run the read_depth & allelic balance filters in parallel on rap (should be run from home dir)

parallel --link . /opt/notebooks/UKB_500K_exome_QC/code/read_depth_and_allele_balance/batch_process.sh --file={1} --out={2} :::: /opt/notebooks/UKB_500K_exome_QC/code/rap_specific/vcf.list /opt/notebooks/UKB_500K_exome_QC/code/rap_specific/out.list