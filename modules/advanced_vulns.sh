#!/bin/bash
OUT=$1
mkdir -p $OUT/advanced

# SSRF and open redirect param hunting
cat $OUT/params/all-urls.txt | grep -Ei 'url=|redirect=|next=|dest=' | sort -u > $OUT/advanced/redirect-ssrf-params.txt

# Optional test with interactsh domain for SSRF
# interactsh-client -o $OUT/advanced/interactsh.txt
