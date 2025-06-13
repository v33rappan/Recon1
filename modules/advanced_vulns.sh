#!/bin/bash

source "$(dirname "$0")/../loader.sh"

OUT=$1
mkdir -p $OUT/advanced

# SSRF and open redirect param hunting
print_status "Obtaining redirect SSRF params..."
cat $OUT/params/all-urls.txt | grep -Ei 'url=|redirect=|next=|dest=' | sort -u > $OUT/advanced/redirect-ssrf-params.txt
print_done

# Optional test with interactsh domain for SSRF
# interactsh-client -o $OUT/advanced/interactsh.txt
