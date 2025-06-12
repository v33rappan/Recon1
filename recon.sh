#!/bin/bash

# ---------------------------------------------------------------------
# Bug Bounty recon script with auto-setup, XSS Scan and alerts
# Author: V33rappan S@mmy
# ---------------------------------------------------------------------

source config.conf

DATE=$(date +%F-%H%M)
OUT="$OUTPUT_DIR/$DOMAIN-$DATE"
mkdir -p $OUT

# Orchestrate modules
./modules/subdomain.sh $DOMAIN $OUT
./modules/resolve.sh $OUT
./modules/httprobe.sh $OUT
./modules/screenshot.sh $OUT
./modules/nuclei $OUT
./modules/parammine.sh $OUT
./modules/xss.sh $OUT
./modules/github.sh $DOMAIN $OUT
./modules/portscan.sh $OUT
./modules/s3hunt.sh $OUT
./modules/jssecrets.sh $OUT
./modules/fuzz.sh $OUT
./modules/advanced_vulns.sh $OUT
./modules/cloudmeta.sh $OUT
./modules/wordlistgen.sh $OUT
./modules/vulnsummary.sh $OUT
./modules/notify.sh $OUT
