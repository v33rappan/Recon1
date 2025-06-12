#!/bin/bash
OUT=$1
REPORT="$OUT/report"
mkdir -p $REPORT

echo "======== Vulnerability Summary =========" > $REPORT/summary.txt

echo -e "\n-------- Nuclei ---------" >> $REPORT/summary.txt
cat $OUT/nuclei/findings.txt | grep -Ei 'critical|high' >> $REPORT/summary.txt

echo -e "\n------- Dalfox ----------" >> $REPORT/summary.txt
cat $OUT/xss/dalfox.txt >> $REPORT/summary.txt

echo -e "\n------- Github ----------" >> $REPORT/summary.txt
cat $OUT/github/gitdorks_go.txt >> $REPORT/summary.txt
cat $OUT/github/trufflehog.json | jq '.results[] | .path, .stringsFound' >> $REPORT/summary.txt

echo -e "\n------- Portscan -------" >> $REPORT/summary.txt
cat $OUT/portscan/naabu.txt >> $REPORT/summary.txt
cat $OUT/portscan/nmap.txt | grep open >> $REPORT/summary.txt

echo -e "\n------- S3/Cloud Buckets -------" >> $REPORT/summary.txt
cat $OUT/s3/results.txt >> $REPORT/summary.txt
