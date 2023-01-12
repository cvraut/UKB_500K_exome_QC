#!/usr/bin/env bash
# run the read_depth & allelic balance filters in parallel

parallel --link ./batch_process.sh --file={1} --out={2} :::: vcf.list out.list