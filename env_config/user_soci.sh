#!/bin/sh

INSTALL_PREFIX="~/local"
DIR=`pwd`
GIT="$DIR/build_library/soci.git"

if [ -d "$GIT" ];then
	cd $GIT
	git pull
else
	git clone git://github.com/SOCI/soci.git $GIT
fi

cd $GIT
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
