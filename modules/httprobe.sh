#!/bin/bash

source "$(dirname "$0")/../loader.sh"

OUT=$1
mkdir -p $OUT/live

print_status "HTTPX ..."
httpx -title -tech-detect -status-code -threads 100 \
	< $OUT/resolved/resolved.txt > $OUT/live/live.txt
print_done
