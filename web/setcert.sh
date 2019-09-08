#!/usr/bin/expect -f

set bin [exec sh -c {echo `pwd`/gencert.sh}]
set PASSPHRASE 1233456
spawn $bin
 
expect "Enter your domain" { send "cert\n"; }
expect "Enter pass phrase" { send "$PASSPHRASE\n"}
expect "Enter pass phrase" { send "$PASSPHRASE\n"}
expect "Enter pass phrase" { send "$PASSPHRASE\n"}
expect "Enter pass phrase" { send "$PASSPHRASE\n"}

expect eof
exit
