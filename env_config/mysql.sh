#!/bin/sh

DIR=$(cd "$(dirname $0)"; pwd)
rpmName="mysql-community-release-el7-5.noarch.rpm"
. $DIR/log.sh

if [ -f "$DIR/$rpmName" ]; then
	log_info "${rpmName} 已存在"
else
	wget http://dev.mysql.com/get/$rpmName
fi

if [ -n "$(rpm -qa | grep "mysql-community")" ];then
	log_info "已安装mysql"
	service mysqld restart
	exit 0
fi

rpm -ivh $rpmName
# 安装mysql
yum -y install mysql-community-server

# 安装开发包
yum -y install mysql-community-devel.x86_64

service mysqld start


