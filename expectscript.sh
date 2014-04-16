#!/usr/bin/expect

#echo -e "Typical usage is scriptname [IP] [username] [password]"
set IP [lindex $argv 0]
set uname [lindex $argv 1]
set pass [lindex $argv 2]
set method "ssh"

set timeout 120
spawn ssh -l $uname $IP
expect {
        "(yes/no)?" {
                        send "yes\r"
                        expect "word:" { send "$pass\r" }
                    }
        "word:" { send "$pass\r" }
        }


expect -re "^.*>|^.*\\$|^.*\\%" {}
send "\r"
send_user "\n\n***INFO*** Login Complete\n"
        interact {
                ~~
        }
#send "hostname\r"
