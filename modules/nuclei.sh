#!/bin/bash

source "$(dirname "$0")/../loader.sh"

OUT=$1
mkdir -p $OUT/nuclei

print_status "Using nuclei for recon..."
nuclei -l $OUT/live/live.txt -severity medium,high,critical \
	-o $OUT/nuclei/findings.txt
print_done
