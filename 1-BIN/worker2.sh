#!/usr/bin/expect -f

# Worker 2 File
######################################## MOHAMED ASHRAF #############################



# Recieving data from corp-nat
set device [lindex $argv 0]
set myidentity [lindex $argv 1]
set myprecious [lindex $argv 2]


# Reaching remote dude
spawn telnet ${device}


#### Starting da AWSOME STUFF:
#Saying hi and handshaking
expect "sername:"
send -- "${myidentity}\r"
expect "assword:"                      #you wont enter without that precious ***Word
send -- "${myprecious}\r"
expect "#"
send -- "\r"
expect "#"                             #Seperating commands so you dont suffer while reading log :)
send -- "\r"
expect "#"

#Enough introduction now lets talk buisness
send -- {show ip nat translations vrf corporate}
send -- "\r"

expect {
-exact    "--More--" {send -- " "; exp_continue}
    "#" {send -- "exit \r"}
}


#send -- {show ip nat translations vrf corporate}
#send -- "\r"
#expect "#"
#send -- "\r"
#expect "#"

#Waving goodbye
send -- "exit\r"
