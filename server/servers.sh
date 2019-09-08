
start() {
    cd pppoe; ./pppoe.init start; cd -
    cd pptp; ./pptp.init start; cd -
    cd l2tp; ./l2tp.init start; cd -
    cd dhcp; ./dhcp.init start; cd -
    cd dns; ./dns.init start; cd -
}

stopAll() {
    ./dhcp/dhcp.init stop
    ./dns/dns.init stop
    ./pppoe/pppoe.init stop
    ./pptp/pptp.init stop
    ./l2tp/l2tp.init stop
}

if [ "$1" = "start" -o "$1" = "restart" ];then
    stopAll >/dev/null 2>&1
    start
elif [ "$1" = "stop" ];then
    stopAll >/dev/null 2>&1
else
    echo "errro"
fi

