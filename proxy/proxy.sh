#!/bin/bash

# setting proxy for Terminal
# refer to http://www.linuxidc.com/Linux/2014-08/105690.htm

# 1.install cntml
sudo dpkg -i cntlm_0.92.3_i386.deb
# 2.configure parameters in /etc/cntlm.conf file, such as username,etc.
sudo cp cntlm.conf /etc/cntlm.conf
# 3.change /etc/profile , add 3 lines
if [ -z "$(grep -rn \"export http_proxy=\" /etc/profile)" ]; then
	sudo echo export http_proxy="http://127.0.0.1:3128" >> /etc/profile
	sudo echo export https_proxy="http://127.0.0.1:3128" >> /etc/profile
	sudo echo export ftp_proxy="http://127.0.0.1:3128" >> /etc/profile
fi
# 4.config apt conf
sudo cp apt.conf /etc/apt/apt.conf
# 5.restart
sudo /etc/init.d/cntlm restart

sudo apt-get install corkscrew
cp ./config ~/.ssh/config






