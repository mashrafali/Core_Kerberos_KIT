#! /bin/bash
#! /bin/sh

# LOG RELAYER
######################################## MOHAMED ASHRAF #############################
## you see my logic, you see me!
clear
echo
echo
echo "          #################### Cisco Command Injector #################### "
echo
echo

filename="ip-list"                      #Define source file for ip-list
filename2="command-list"                #Define source file for Command-List
grep -v '^$' ip-list > ip-list.temp
grep -v '^$' command-list > command-list.temp
rm ip-list; mv ip-list.temp ip-list
rm command-list; mv command-list.temp command-list
## Calling for data input:
echo
#echo "Yo, gimme da device IP:"
#read device
echo -en "Please Enter your Username: "
read myidentity
echo
prompt="Please Enter your Password: "
unset myprecious
while IFS= read -p "$prompt" -r -s -n 1 char
do
    if [[ $char == $'\0' ]]
    then
        break
    fi
    prompt='*'
    myprecious+="$char"
done
echo
echo
echo -en "Please Enter the log File Name: "
read logwithspace
logname=$(echo "$logwithspace" | tr '[ ]' '-')

## Adjusting Parameters
logging=history/$logname.log

                              ###################### CONFIRMATION PHASE ########################
clear
echo
echo
echo -en ">>>>>>>> Everything i will do for you will be logged in [";echo -en $logging;echo "] file <<<<<<<<"
echo
sleep 1
echo
echo "Configuring for the following devices:"
echo "--------------------------------------"
echo
i=1
while read -r line
do
     echo -en "    "; echo -en $i; echo -en ") "; cat BIN/device-ID | grep -iw $line                   ##Mapping ip to device ID
     i=$(( i + 1 ))
done < "$filename"
echo
echo
echo "    -> Hit Enter to Continue.."
echo "    -> ctrl-c to Cancel"
read

clear
echo
echo "Applying below Commands:"
echo "------------------------"
echo
echo "#START#"
echo
cat command-list
echo
echo "#END#"
echo
echo
echo "    -> Hit Enter to Continue.."
echo "    -> ctrl-c to Cancel"
read

## Lets make you smile, shall we ?
echo -en "I ";sleep 0.1;echo -en "a";sleep 0.1;echo -en "m ";sleep 0.1;echo -en "g";sleep 0.1;echo -en "o";sleep 0.1;echo -en "i";sleep 0.1;echo -en "n";sleep 0.1;echo -en "g ";sleep 0.1;echo -en "i";sleep 0.1;echo -en "n, ";sleep 0.1;echo -en "w";sleep 0.1;echo -en "i";sleep 0.1;echo -en "s";sleep 0.1;echo -en "h ";sleep 0.1;echo -en "m";sleep 0.1;echo -en "e ";sleep 0.1;echo -en "l";sleep 0.1;echo -en "u";sleep 0.1;echo -en "c";sleep 0.1;echo -en "k!";sleep 0.1
sleep 0.2; echo -en "."; sleep 0.2; echo -en "."; sleep 0.2; echo -en "."; sleep 0.2; echo -en "."; sleep 0.2; echo -en "."
sleep 1
echo;echo

           ############################# Importing Commands and building worker file #############################
echo -en > BIN/worker.sh
echo '#!/usr/bin/expect

# Worker File
######################################## MOHAMED ASHRAF #############################
## you see my logic, you see me!


# Recieving data from Log-Relayer
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

#Enough introduction now lets talk buisness' >> BIN/worker.sh
while read -r line
do
     echo -en 'send -- {' >> BIN/worker.sh; echo -en $line >> BIN/worker.sh; echo '}' >> BIN/worker.sh    ## dont mess with BELOW SPACING !!
     echo 'send -- "\r"
expect "#"
send -- "\r"
expect "#"' >> BIN/worker.sh

done < "$filename2"
echo  >> BIN/worker.sh
echo '#Waving goodbye
send -- "exit\r"' >> BIN/worker.sh

#### BULDING LOG-FILE
echo -en ">>>>>>>>>>>>>>>>>>>>>>>>>>> USER: " >> $logging; echo -en $(who am i) >> $logging; echo  " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" >> $logging
echo  "----------------------------------------------------------------------------------------------------------------" >> $logging
echo >> $logging; echo >> $logging; echo >> $logging
                          ############################# STARTING OPERATION #############################
while read -r line
do

     device=$line
     ## Preparing Log file
     echo -en "########################## Configuration for [" >> $logging; echo -en $(cat device-ID | grep -i $device) >> $logging;echo "]" >> $logging
     echo -en "# TIME STAMP: " >> $logging; echo $(date) >> $logging
     echo "########################################################################" >> $logging
     echo >> $logging
     ./BIN/worker.sh $device $myidentity $myprecious >> $logging 2>&1
     echo >> $logging
     echo >> $logging
     cat $logging

done < "$filename"
clear
echo;echo;echo
echo "    -> Command injection is complete!"
echo;echo
echo -en "    -> Kindly Refer to ("; echo -en $logging;echo ") to revise what i have done."
echo;echo
echo "    -> If anything went wrong, kindly notify my developer"
echo;echo
echo "            Have a Great Day!"
echo "                 Bye"
echo;echo;echo
