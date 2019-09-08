
DIR=$(cd "$(dirname "$0")"; pwd)
__OS="centos"

source $DIR/log.sh

set -e

# if [ `whoami` = "root" ]; then
# 	echo "Do not run as root"
# 	return
# fi 


sudo sh -c "bash system.sh"
sh $DIR/user.sh

