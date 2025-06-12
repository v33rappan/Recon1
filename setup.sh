#!/bin/bash

REQUIRED_TOOLS=(
	subfinder amass assetfinder dnsx httpx nuclei gowitness
	gau waybackurls qsreplace dalfox notify gitdorks trufflehog
)

echo "[*] Checking dependencies..."
for tool in "${REQUIRED_TOOLS[@]}"; do
	if ! command -v $tool &>/dev/null; then
		echo "[*] Installing $tool..."
		# Installation logic
	fi
done

if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
	export PATH="$HOME/go/bin:$PATH"
	echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.bashrc
fi

echo "[*] All tools are installed, you are ready to go..."
