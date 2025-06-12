#!/bin/bash

set -e

echo "-------------------------------------------------"
echo "---------- RECON1 TOOLS SETUP -------------------"
echo "-------------------------------------------------"

# List of system required tools
SYSTEM_TOOLS=(
	go python3 jq curl git nmap
)

# List of Go Tools
GO_TOOLS=(
	"subfinder|github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
	"amass|github.com/owasp-amass/amass/v3/...@latest"
	"assetfinder|github.com/tomnomnom/assetfinder@latest"
	"dnsx|github.com/projectdiscovery/dnsx/cmd/dnsx@latest"
	"httpx|github.com/projectdiscovery/httpx/cmd/httpx@latest"
	"nuclei|github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest"
	"gowitness|github.com/sensepost/gowitness@latest"
	"gau|github.com/lc/gau/v2/cmd/gau@latest"
	"waybackurls|github.com/tomnomnom/waybackurls@latest"
	"qsreplace|github.com/tomnomnom/qsreplace@latest"
	"dalfox|github.com/hahwul/dalfox/v2@latest"
	"notify|github.com/projectdiscovery/notify/cmd/notify@latest"
	"naabu|github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
	"ffuf|github.com/ffuf/ffuf/v2@latest"
	"gitdorks|github.com/damit5/gitdorks_go@latest"
)

# List of python pip tools ( format: "command|pip-install-name")
PYTHON_TOOLS=(
	"arjun|arjun"
	"trufflehog|trufflehog"
)

# Helper: Check if a tools is available
is_installed() {
	command -v "$1" >/dev/null 2>&1
}

echo -e "\n[1/3] Checking system dependencies..."
for tool in "${SYSTEM_TOOLS[@]}"; do
	if is_installed "$tool"; then
		echo "$tool found"
	else
		echo "$tool not found. Please install it using your package manager:"
		echo "      sudo apt install $tool # or brew install $tool"
		exit 1
	fi
done

echo -e "\n[2/3] Installing go dependecies..."
for entry in "${GO_TOOLS[@]}"; do
	IFS='|' read -r cmd repo <<< "$entry"
	if is_installed "$cmd"; then
		echo "$cmd is already installed"
	else
		echo "Installing $cmd from $repo..."
		go install -v "$repo"
		echo "$cmd installed successfully"
	fi
done

echo -e "\n[3/3] Checking python dependencies..."
for entry in "${PYTHON_TOOLS[@]}"; do
	IFS='|' read -r cmd pipname <<< "$entry"
	if is_installed "$cmd"; then
		echo "$cmd already installed"
	else
		echo "Installing $cmd via pip..."
		pipx install "$pipname"
		echo "$cmd installed successfully"
	fi
done

if [[ ":$PATH:" != *":$HOME/go/bin:"* ]]; then
	export PATH="$HOME/go/bin:$PATH"
	if ! grep -q 'export PATH="$HOME/go/bin:$PATH"' ~/.bashrc; then
		echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.bashrc
	fi
	echo "Added \$HOME/go/bin to your PATH. Please restart your terminal or run:"
	echo "     export PATH=\"\$HOME/go/bin:\$PATH\""
fi

echo -e "\n Setup complete! All tools are ready to use"
