#!/bin/sh

set -e

if [ `whoami` = "root" ]; then
	echo "Do not run as root"
	return
fi 

msg () {
	local type="$1"
	shift 1
	local message="$*"
	case $type in
	error)
		echo "\033[31m$message \033[0m"
		;;
	info)
		echo "\033[34m$message \033[0m"
		;;
	*)
		echo "\033[34m$message \033[0m"
		;;
	esac
}

update() {
	msg info "system upgrade ..."
	sudo apt-get update
	sudo apt-get upgrade
}

install() {
	pkgs="
git
vim
expect
openssh-server
build-essential
tig
exuberant-ctags
"
	echo $pkgs
	installed="`dpkg -l | grep ii | awk -F [\ ]+ '{print $2}'`"
	for p in $pkgs; do
		if [ x$(echo "$installed" | grep "^$p$") = x ];then
		echo $p
			sudo apt-get -y install $p
		fi

	done
}

keygen() {
	# create a ssh key
	if [ -e ~/.ssh/id_rsa.pub ]; then
		echo "id_ras key exist"
	else
expect << EOF
spawn ssh-keygen -t rsa -C "guojiangzhe@hotmail.com"
expect "Enter file in which to save the key"
send "\n"
expect "Enter passphrase"
send "\n"
expect "Enter same passphrase again"
send "\n"
expect eof
exit
EOF
	fi
}


clone() {
	rep="sys vim c mat script"
	for r in $rep; do
		[ -e ~/git_home/$r ] || {
			git clone https://guojiangzhe@github.com/guojiangzhe/$r.git ~/git_home/$r
		}
	done
	cd ~/git_home/vim; sh ~/git_home/vim/genln;cd -
	~/git_home/sys/check.sh
}


if [ $# -gt 0 ]; then
	while [ $# -gt 0 ];do
		eval $1
		shift
	done
else
	#update
	install
	keygen
	bash `pwd`/git/gitconfig
	#clone
fi
	





