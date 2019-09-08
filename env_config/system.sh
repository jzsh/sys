#!/bin/sh

DIR=$(cd "$(dirname "$0")"; pwd)
__OS="centos"

source $DIR/log.sh

# 系统更新
system_update() {
	log_info "system upgrade ..."
	if [ ${__OS} = "debian" ];then
		apt-get update
		apt-get upgrade
	elif [ ${__OS} = "centos" ];then
		yum -y makecache
		yum -y update
	fi
}

# 安装软件和工具
tool_install() {
	yum -y install git.x86_64
	yum -y install tig
	yum -y install ctags-5.8-13.el7.x86_64
	yum -y groupinstall "Development Tools"
	yum -y install cmake
}

# 配置ld.so.conf.d
HOMELOCAL_CONF="/etc/ld.so.conf.d/homelocal.conf"
echo "/home/guojz/local/lib64" > $HOMELOCAL_CONF
echo "/home/guojz/local/lib" >> $HOMELOCAL_CONF

sysVersion=`cat /etc/redhat-release`
log_info "system version: $sysVersion"

system_update
tool_install




