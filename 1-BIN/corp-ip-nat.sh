#! /bin/bash

clear
echo
echo
echo "          #################### Corporate IP NAT Translations #################### "
echo
echo

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

logname=Dumb-Space
device=217.139.253.22


## Adjusting Parameters
logging=2-TEMP/$logname.log

                                  ###################### CONFIRMATION PHASE ########################
clear
echo
echo
echo
echo
echo "   Device  : MVPN [217.139.253.22]"
echo "   Command : show ip nat translations vrf corporate"
echo
echo
echo "    -> Hit Enter to Continue.."
echo "    -> ctrl-c to Cancel"
read

####
for i in {1..5}
do
echo -en "Please Hold...         -" \\r
sleep 0.25
echo -en "Please Hold...         /" \\r
sleep 0.25
echo -en "Please Hold...         |" \\r
sleep 0.25
echo -en 'Please Hold...         \' \\r
sleep 0.25
done

                          ############################# STARTING OPERATION #############################


while true
do
cd /root/Core-Kerberos-KIT/
./1-BIN/worker2.sh $device $myidentity $myprecious > 2-TEMP/$logname.raw

tail -n +44 2-TEMP/$logname.raw > 2-TEMP/$logname.brew

head -n -2 2-TEMP/$logname.brew > 2-TEMP/$logname.cooking

tr -d '\b\r' < 2-TEMP/$logname.cooking > 2-TEMP/$logname.boiling

sed -e "s/ --More--         //g" 2-TEMP/$logname.boiling > 2-TEMP/$logname.dressing

cat 2-TEMP/$logname.dressing | tr -s ' ' | cut -d ' ' -f 3 > 2-TEMP/$logname.steaming

grep -v '^$' 2-TEMP/$logname.steaming > 2-TEMP/$logname.salting

awk -F ":" '{print $1}' 2-TEMP/$logname.salting > 2-TEMP/$logname.oiling

cat 2-TEMP/$logname.oiling | tr ' ' '\n' | sort | uniq -c > 2-TEMP/$logname.serving

clear
echo > 2-TEMP/$logname.eating
tail -1 2-TEMP/$logname.boiling >> 2-TEMP/$logname.eating
echo >> 2-TEMP/$logname.eating
echo " Trans | Ip-Address                    I am Active and will refresh every few Seconds" >> 2-TEMP/$logname.eating
echo "-------|---------------------          Spam Ctrl-C to Stop me" >> 2-TEMP/$logname.eating
sort -k1,1nr -k2,2 2-TEMP/$logname.serving >> 2-TEMP/$logname.eating

rm 2-TEMP/$logname.raw
rm 2-TEMP/$logname.brew
rm 2-TEMP/$logname.cooking
rm 2-TEMP/$logname.boiling
rm 2-TEMP/$logname.dressing
rm 2-TEMP/$logname.steaming
rm 2-TEMP/$logname.salting
rm 2-TEMP/$logname.oiling
rm 2-TEMP/$logname.serving
head -35 2-TEMP/$logname.eating

#cat 2-TEMP/Dumb-Space.init | awk '{print $3 }'
done
