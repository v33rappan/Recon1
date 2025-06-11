#!/bin/bash

# ---------------------------------------------------------------------
# Bug Bounty recon script with auto-setup, XSS Scan and alerts
# Author: V33rappan S@mmy
# ---------------------------------------------------------------------
#
REQUIRED_TOOLS=(
	subfinder amass assetfinder dnsx httpx nuclei gowitness
	gau waybackurls qsreplace dalfox notify
)

# Color output
green () { echo -e "\033[0;32m$1\033[0m"; }
red () { echo -e "\033[0;31m$1\033[0m"; }

# Check if tools are installed
check_tools () {
	green "[*] Checking required tools..."
	for tool in "${REQUIRED_TOOLS[@]}"; do
		if !command -v "$tool" >/dev/null 2>&1; then
			red "Please install $tool"
		fi
	done

	# Export updated $GOPATH
	if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
		export PATH="$HOME/go/bin:$PATH"
		echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.bashrc
		green "Updated PATH to include GO binaries"
	fi
}

# Parse -d flag
while getopts ":d:" opt; do
	case ${opt} in
		d ) DOMAIN=$OPTARG ;;
		\? ) red "Invalid option: -$OPTARG" >&2; exit 1 ;;
		: ) red "Option -$OPTARG requires an argument" >&2; exit 1 ;;
	esac
done

if [ -z "$DOMAIN" ]; then
	red "Usage: $0 -d <domain>"
	exit 1
fi

check_tools

DATE=$(date +%F-%H%M)
OUT="$DOMAIN-recon-$DATE"
mkdir -p $OUT/{subdomains,resolved,live,nuclei,screenshots,params,xss}

green "[1/8] Subdomain enumeration..."
subfinder -d $DOMAIN -silent -o $OUT/subdomains/subfinder.txt
amass enum -passive -d $DOMAIN -o $OUT/subdomains/amass.txt
assetfinder --subs-only $DOMAIN >> $OUT/subdomains/assetfinder.txt
cat $OUT/subdomains/*.txt | sort -u > $OUT/subdomains/all.txt

green "[2/8] DNS resolutions..."
dnsx -silent -a -l $OUT/subdomains/all.txt -o $OUT/resolved/resolved.txt

green "[3/8] Live host probing..."
httpx -silent -title -tech-detect -status-code -threads 100 \
	< $OUT/resolved/resolved.txt > $OUT/live/live.txt

green "[4/8] Screenshots (gowitness)..."
gowitness file -f $OUT/live/live.txt -P $OUT/screenshots/ --resolution 1280,800

green "[5/8] Nuclei scanning..."
nuclei -l $OUT/live/live.txt -silent -severity medium,high,critical \
	-o $OUT/nuclei/findings.txt

green "[6/8] Param mining with gau + waybackurls ..."
cat $OUT/subdomains/all.txt | gau >> $OUT/params/gau.txt
cat $OUT/subdomains/all.txt | waybackurls >> $OUT/params/wayback.txt
cat $OUT/params/*.txt | sort -u | tee $OUT/params/all-urls.txt

grep "=" $OUT/params/all-urls.txt | qsreplace '"><script>alert(1)</script>' \
	> $OUT/params/payloaded-xss.txt

green "[7/8] Auto-XSS testing with Dalfox..."
dalfox file $OUT/params/payloaded-xss.txt --deep-detect --silence \
	--output $OUT/xss/dalfox.txt

green "[8/8] Sending optional notification..."
if [ -f "$HOME/.recon_notify.conf" ]; then
	notify -silent -data $OUT/nuclei/findings.txt
fi

green "Recon Complete! All results saved in: $OUT"
