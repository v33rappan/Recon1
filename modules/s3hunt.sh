#!/bin/bash
OUT=$1
mkdir -p $OUT/s3
cat $OUT/subdomains/all.txt | sed 's/^/http:\/\//' | python3 -m S3Scanner.s3scanner --include-closed > $OUT/s3/results.txt
