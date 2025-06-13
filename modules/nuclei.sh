#!/bin/bash
OUT=$1
mkdir -p $OUT/nuclei
nuclei -l $OUT/live/live.txt -silent -severity medium,high,critical \
	-o $OUT/nuclei/findings.txt
