#!/bin/sh
packagesName="
git
expect.x86_64
cmake.x86_64
lrzsz
"
yum -y groupinstall "Development Tools"


for p in $packagesName; do
	yum -y install $p
done

