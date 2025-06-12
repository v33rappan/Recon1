#!/bin/bash
OUT=$1
mkdir -p $OUT/report

echo "======== Vulnerability Summary =========" > $OUT/report/summary.txt
cat $OUT/nuclei/findings.txt >> $OUT/report/summary.txt
cat $OUT/xss/dalfox.txt >> $OUT/report/summary.txt
cat $OUT/github/gitdorks.txt >> $OUT/report/summary.txt
