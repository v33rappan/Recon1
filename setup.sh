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

gopath_bin="$HOME/go/bin"
rcfiles=()
[ -f "$HOME/.bashrc" ] && rcfiles+=("$HOME/.bashrc")
[ -f "$HOME/.zshrc" ] && rcfiles+=("$HOME/.zshrc")

for rcfile in "${rcfiles[@]}"; do
	if ! grep -Fxq 'export PATH="$HOME/go/bin:$PATH"' "$rcfile"; then
		echo 'export PATH="$HOME/go/bin:$PATH"' >> "$rcfile"
		echo "Added Go bin path to $rcfile"
	else
		echo "$gopath_bin already present in $rcfile"
	fi
done

# Also export to current session
if [[ ":$PATH:" != *":$gopath_bin:"* ]]; then
	export PATH="$gopath_bin:$PATH"
	echo "Updated current session PATH with $gopath_bin"
else
	echo "$gopath_bin is already in your current session PATH"
fi

# Advise user to reload if current session does not have the path
if ! echo "$PATH" | grep -q "$gopath_bin"; then
	echo "Note: You may need to restart your terminal or run:"
	echo "		export PATH=\"$HOME/go/bin:\$PATH\""
fi

# Show go bin status and version for debugging
echo "Go bin directory content (if any):"
ls "$HOME/go/bin" 2>dev/null || echo "		(No Go tools installed yet)"
echo "Go version:"
go version || echo "		(Go not installed or not found)"
	
echo -e "\n Setup complete! All tools are ready to use"
echo "If any tool is not found, try: source $rcfile OR open a new terminal session"
