#!/bin/sh

set -x

DIR="$(cd "$(dirname "$0")" && pwd )"
sudo cp $(DIR)/sunny /usr/local/bin/sunny
sudo cp $(DIR)/sunny.init /etc/init.d/sunny
sudo chmod +x /etc/init.d/sunny
sudo /usr/sbin/update-rc.d -f sunny defaults 99
sudo /etc/init.d/sunny stop
sudo /etc/init.d/sunny start

ps -A | grep sunny
