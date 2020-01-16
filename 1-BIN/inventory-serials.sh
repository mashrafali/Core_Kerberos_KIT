#! /bin/bash
#! /bin/sh

# DB BUILD AND BURN
######################################## MOHAMED ASHRAF #############################
## you see my logic, you see me!
clear
echo
echo
echo "          #################### Network Serials DataBase #################### "
echo
echo

filename="2-TEMP/serial-ip-list"                      #Define source file for serial-ip-list
grep -v '^$' 2-TEMP/serial-ip-list > 2-TEMP/serial-ip-list.temp
rm 2-TEMP/serial-ip-list; mv 2-TEMP/serial-ip-list.temp 2-TEMP/serial-ip-list

## Calling for data input:
echo
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

                              ###################### CONFIRMATION PHASE ########################
clear
echo
echo
sleep 1
echo
echo "Building Serial DB for the following devices:"
echo "---------------------------------------------"
echo
i=1
while read -r line
do
     echo -en "    "; echo -en $i; echo -en ") "; cat 1-BIN/device-ID | grep -iw $line                   ##Mapping ip to device ID
     i=$(( i + 1 ))
done < "$filename"

echo
echo
echo "    -> Hit Enter to Continue.."
echo "    -> ctrl-c to Cancel"
read
clear
echo
