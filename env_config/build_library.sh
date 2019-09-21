#!/bin/sh

INSTALL_PREFIX="/home/guojz/local"

BUILD_PATH="`pwd`/build_library"
mkdir -p $BUILD_PATH

soci()
{
	prepare "git://github.com/SOCI/soci.git" "soci.git"
	cd soci.git
	mkdir -p build
	cd build
	rm -rf *
	cmake -G "Unix Makefiles" \
		-DWITH_BOOST=OFF \
		-DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
		-DSOCI_EMPTY=OFF \
		-DWITH_MYSQL=ON \
		-DWITH_ODBC=OFF \
		..
	make
	make install
}

# in build_library path
prepare()
{
	cd $BUILD_PATH
	local git_url=$1
	local git_name=$2
	local commidId=${3:-"HEAD"}

	if [ -d "$git_name" ];then
		cd $git_name
		git pull
	else
		git clone $git_url $git_name
	fi
	git reset --hard $commidId
}

libev()
{
	prepare "git://github.com/enki/libev.git" "libev.git"
	cd libev.git
	./configure --prefix=$INSTALL_PREFIX
	make
	make install
}

soci
libev

