print_status() {
	local msg="$1"
	echo -ne "\033[1;34m[+]\033[0m $msg... \033[1;33m-\033[0m"
}

print_done() {
	echo -e "\033[1;32m[DONE]\033[0m"
}

spinner() {
	local pid=$1
	local spin='-\|/'
	local i=0
	while kill -0 $pid 2>/dev/null; do
		i=$(( (i+1) %4 ))
		printf "\b\033[1;33m%s\033[0m" "${spin:$i:1}"
		sleep .2
	done
	printf "\b \b"
}
