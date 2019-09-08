#!/bin/sh

# 配置用户
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

git_config() {
	rm -rf ~/.gitconfig
	git config --global user.name guojiangzhe
	git config --global user.email jiangzhe.guo@hotmail.com
	git config --global core.editor vim
	git config --global core.quotepath false
	git config --global color.ui always
	git config --global alias.st status
}


keygen
git_config
sh user_soci.sh
