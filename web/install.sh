#!/bin/sh

# ref http://www.jb51.net/article/77486.htm
PHP=php-5.5.0
NGINX=nginx-1.6.3
MYSQL=mysql-5.5.56
BUILD_DIR=`pwd`/build
DL=`pwd`/dl

. ./lnmp.conf
mkdir -p $BUILD_DIR
mkdir -p $DL

dl() {
	packageName=$1
	url=$2
	cd $DL
	[ ! -e "$packageName" ] && wget $url
	cd - 
}


php() {
	dl libiconv-1.13.1.tar.gz http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.13.1.tar.gz
	dl $PHP.tar.gz http://cn2.php.net/distributions/$PHP.tar.gz
	sudo yum -y install libxml2-devel.x86_64
	sudo yum -y install bzip2-devel.x86_64
	sudo yum -y install libcurl-devel.x86_64
	sudo yum -y install libjpeg-turbo-devel.x86_64
	sudo yum -y install libpng-devel.x86_64
	sudo yum -y install libmcrypt-devel.x86_64
	tar -zxf $DL/$PHP.tar.gz -C $BUILD_DIR
	tar -zxf $DL/libiconv-1.13.1.tar.gz -C $BUILD_DIR
	cd $BUILD_DIR/libiconv-1.13.1; ./configure && make && sudo make install; cd -

	test -e /usr/local/php || {
		cd $BUILD_DIR/$PHP
		./configure \
			--prefix=/usr/local/php \
			--enable-fpm \
			--with-mcrypt \
			--enable-mbstring \
			--disable-pdo \
			--with-curl \
			--disable-debug \
			--disable-rpath \
			--enable-inline-optimization \
			--with-bz2 \
			--with-zlib \
			--enable-sockets \
			--enable-sysvsem \
			--enable-sysvshm \
			--enable-pcntl \
			--enable-mbregex \
			--with-mhash \
			--enable-zip \
			--with-pcre-regex \
			--with-mysql \
			--with-mysqli \
			--with-gd \
			--with-iconv=/usr/local/libiconv \
			--with-jpeg-dir
		make && sudo make install
		cd -
	}
}

php_config() {
	sudo cp $BUILD_DIR/$PHP/php.ini-production /usr/local/lib/php.init
	sudo cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
	sudo cp $BUILD_DIR/$PHP/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
	sudo chmod +x /etc/init.d/php-fpm
	sudo /usr/sbin/update-rc.d -f php-fpm defaults 98
	sudo cp php-fpm.conf /usr/local/php/etc/php-fpm.conf
}

install_preq() {
	sudo apt-get install libxml2-dev
	sudo apt-get install libjpeg-dev
	sudo apt-get install libpng-dev
	sudo apt-get install libmcrypt-dev
	tar -zxvf $DL/bzip2-1.0.6.tar.gz -C $BUILD_DIR; cd $BUILD_DIR/bzip2-1.0.6;make && sudo make install; cd -
	tar -zxvf $DL/curl-7.53.1.tar.gz -C $BUILD_DIR; cd $BUILD_DIR/curl-7.53.1;./configure; make && sudo make install; cd -
}

install_preq_centos() {
	sudo yum -y install libxml2-devel.x86_64 
}

#$PHP.tar.gz http://cn2.php.net/distributions/$PHP.tar.gz
#$NGINX.tar.gz http://nginx.org/download/$NGINX.tar.gz
#"
#download() {
#	cd $DL
#}

nginx() {
	dl openssl-1.0.1t.tar.gz https://ftp.openssl.org/source/old/1.0.1/openssl-1.0.1t.tar.gz
	dl pcre-8.10.tar.gz https://ftp.pcre.org/pub/pcre/pcre-8.10.tar.gz
	dl zlib-1.2.11.tar.gz https://nchc.dl.sourceforge.net/project/libpng/zlib/1.2.11/zlib-1.2.11.tar.gz
	dl /$NGINX.tar.gz http://nginx.org/download/$NGINX.tar.gz

	test -e /usr/local/nginx || {
		tar -zxf $DL/$NGINX.tar.gz -C $BUILD_DIR
		tar -zxf $DL/openssl-1.0.1t.tar.gz -C $BUILD_DIR
		tar -zxf $DL/pcre-8.10.tar.gz -C $BUILD_DIR
		tar -zxf $DL/zlib-1.2.11.tar.gz -C $BUILD_DIR
		cd $BUILD_DIR/$NGINX
		./configure \
		    --sbin-path=/usr/local/nginx/nginx \
		    --conf-path=/usr/local/nginx/nginx.conf \
		    --pid-path=/usr/local/nginx/nginx.pid \
		    --with-openssl=../openssl-1.0.1t \
		    --with-http_ssl_module \
		    --with-pcre=../pcre-8.10 \
		    --with-zlib=../zlib-1.2.11; \
		make && sudo make install
		cd -
	}
}

nginx_config() {
	sudo groupadd www
	sudo useradd -g www -s /sbin/nologin www
	sudo cp nginx.conf /usr/local/nginx/nginx.conf
	sudo cp nginx.init /etc/init.d/nginx
	sudo chmod +x /etc/init.d/nginx
	#sudo /usr/sbin/update-rc.d -f nginx defaults 99
}

mysql() {
	tar -zxf $DL/$MYSQL.tar.gz -C $BUILD_DIR
	cd $BUILD_DIR/$MYSQL
    cmake . \
	-DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
	-DSYSCONFDIR=/etc \
	-DWITH_MYISAM_STORAGE_ENGINE=1 \
	-DWITH_INNOBASE_STORAGE_ENGINE=1 \
	-DWITH_PARTITION_STORAGE_ENGINE=1 \
	-DWITH_FEDERATED_STORAGE_ENGINE=1 \
	-DEXTRA_CHARSETS=all \
	-DDEFAULT_CHARSET=utf8mb4 \
	-DDEFAULT_COLLATION=utf8mb4_general_ci \
	-DWITH_READLINE=1 \
	-DWITH_EMBEDDED_SERVER=1 \
	-DENABLED_LOCAL_INFILE=1 \
	${MySQL55MAOpt}
    make && sudo make install
	cd -
}

Check_MySQL_Data_Dir()
{
    if [ -d "${MySQL_Data_Dir}" ]; then
        datetime=$(date +"%Y%m%d%H%M%S")
        mkdir -p /root/mysql-data-dir-backup${datetime}/
        \cp ${MySQL_Data_Dir}/* /root/mysql-data-dir-backup${datetime}/
        rm -rf ${MySQL_Data_Dir}/*
    else
        mkdir -p ${MySQL_Data_Dir}
    fi
}

MySQL_Sec_Setting()
{
    if [ -d "/proc/vz" ];then
        ulimit -s unlimited
    fi

    StartUp mysql
    /etc/init.d/mysql start

    ln -sf /usr/local/mysql/bin/mysql /usr/bin/mysql
    ln -sf /usr/local/mysql/bin/mysqldump /usr/bin/mysqldump
    ln -sf /usr/local/mysql/bin/myisamchk /usr/bin/myisamchk
    ln -sf /usr/local/mysql/bin/mysqld_safe /usr/bin/mysqld_safe
    ln -sf /usr/local/mysql/bin/mysqlcheck /usr/bin/mysqlcheck

    /usr/local/mysql/bin/mysqladmin -u root password "${DB_Root_Password}"
    if [ $? -ne 0 ]; then
        echo "failed, try other way..."
        cat >~/.emptymy.cnf<<EOF
[client]
user=root
password=''
EOF
        if [ "${DBSelect}" = "4" ] || echo "${mysql_version}" | grep -Eqi '^5.7.'; then
            /usr/local/mysql/bin/mysql --defaults-file=~/.emptymy.cnf -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_Root_Password}');"
            [ $? -eq 0 ] && echo "Set password Sucessfully." || echo "Set password failed!"
        else
            /usr/local/mysql/bin/mysql --defaults-file=~/.emptymy.cnf -e "UPDATE mysql.user SET Password=PASSWORD('${DB_Root_Password}') WHERE User='root';"
            [ $? -eq 0 ] && echo "Set password Sucessfully." || echo "Set password failed!"
            /usr/local/mysql/bin/mysql --defaults-file=~/.emptymy.cnf -e "FLUSH PRIVILEGES;"
            [ $? -eq 0 ] && echo "FLUSH PRIVILEGES Sucessfully." || echo "FLUSH PRIVILEGES failed!"
        fi
        rm -f ~/.emptymy.cnf
    fi
    /etc/init.d/mysql restart

    Make_TempMycnf "${DB_Root_Password}"
    Do_Query ""
    if [ $? -eq 0 ]; then
        echo "OK, MySQL root password correct."
    fi
    echo "Update root password..."
    if [ "${DBSelect}" = "4" ] || echo "${mysql_version}" | grep -Eqi '^5.7.'; then
        Do_Query "UPDATE mysql.user SET authentication_string=PASSWORD('${DB_Root_Password}') WHERE User='root';"
    else
        Do_Query "UPDATE mysql.user SET Password=PASSWORD('${DB_Root_Password}') WHERE User='root';"
    fi
    [ $? -eq 0 ] && echo " ... Success." || echo " ... Failed!"
    echo "Remove anonymous users..."
    Do_Query "DELETE FROM mysql.user WHERE User='';"
    Do_Query "DROP USER ''@'%';"
    [ $? -eq 0 ] && echo " ... Success." || echo " ... Failed!"
    echo "Disallow root login remotely..."
    Do_Query "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    [ $? -eq 0 ] && echo " ... Success." || echo " ... Failed!"
    echo "Remove test database..."
    Do_Query "DROP DATABASE test;"
    [ $? -eq 0 ] && echo " ... Success." || echo " ... Failed!"
    echo "Reload privilege tables..."
    Do_Query "FLUSH PRIVILEGES;"
    [ $? -eq 0 ] && echo " ... Success." || echo " ... Failed!"

    /etc/init.d/mysql restart
    /etc/init.d/mysql stop
}

mysql_config() {
    groupadd mysql
    useradd -s /sbin/nologin -M -g mysql mysql
	
	# config file
	rm -rf /etc/my.cnf
    Check_MySQL_Data_Dir
    chown -R mysql:mysql ${MySQL_Data_Dir}
    /usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=${MySQL_Data_Dir}
    #chgrp -R mysql /usr/local/mysql/.

    cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
    chmod 755 /etc/init.d/mysql
	sudo /usr/sbin/update-rc.d -f mysql defaults 99
	service mysql start

    cat > /etc/ld.so.conf.d/mysql.conf<<EOF
    /usr/local/mysql/lib/mysql
    /usr/local/lib
EOF
    ldconfig

    ln -sf /usr/local/mysql/lib/mysql /usr/lib/mysql
    ln -sf /usr/local/mysql/include/mysql /usr/include/mysql

    #MySQL_Sec_Setting
}

dk() {
	sudo cp nginx.conf.doku /usr/local/nginx/nginx.conf
	sudo cp php-fpm.conf /usr/local/php/etc/php-fpm.conf
	sudo ln -sf ~/git_home/sys/dk/dokuwiki/ /
	sudo chown -RH www:www /dokuwiki
	/usr/bin/expect $(pwd)/setcert.sh
	sudo mv cert* /usr/local/nginx/
}

start_serv() {
	sudo killall -9 nginx php-fpm
	sudo /usr/local/nginx/nginx
	sudo /etc/init.d/php-fpm start
}

if [ "$1" = "all" ];then
	download
	php
	php_config
	nginx
	nginx_config
	dk
	start_serv
elif [ -n "$1" ]; then
	eval "$1"
else
echo "
	download
	php
	php_config
	nginx
	nginx_config
	dk
	start_serv
	"
fi



