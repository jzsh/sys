#!/bin/sh

dir="sys mat c vim script"
pull()
{
	git pull
}
push()
{
	git add -A
	git commit -m "auto sync"
	git push
}
for d in $dir; do
	echo "Entering $d":
	cd ~/git_home/$d
	git st; 
done
