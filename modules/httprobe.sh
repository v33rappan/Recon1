#!/bin/bash
OUT=$1
mkdir -p $OUT/live
httpx -silent -title -tech-detect -status-code -threads 100 \
	< $OUT/resolved/resolved.txt > $OUT/live/live.txt
