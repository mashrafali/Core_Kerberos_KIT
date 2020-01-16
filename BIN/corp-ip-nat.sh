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
logging=history/$logname.log

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

./BIN/worker2.sh $device $myidentity $myprecious > history/$logname.raw

tail -n +44 history/$logname.raw > history/$logname.brew

head -n -2 history/$logname.brew > history/$logname.cooking

tr -d '\b\r' < history/$logname.cooking > history/$logname.boiling

sed -e "s/ --More--         //g" history/$logname.boiling > history/$logname.dressing

cat history/$logname.dressing | tr -s ' ' | cut -d ' ' -f 3 > history/$logname.steaming

grep -v '^$' history/$logname.steaming > history/$logname.salting

awk -F ":" '{print $1}' history/$logname.salting > history/$logname.oiling

cat history/$logname.oiling | tr ' ' '\n' | sort | uniq -c > history/$logname.serving

clear
echo > history/$logname.eating
tail -1 history/$logname.boiling >> history/$logname.eating
echo >> history/$logname.eating
echo " Trans | Ip-Address                    I am Active and will refresh every few Seconds" >> history/$logname.eating
echo "-------|---------------------          Spam Ctrl-C to Stop me" >> history/$logname.eating
sort -k1,1nr -k2,2 history/$logname.serving >> history/$logname.eating

rm history/$logname.raw
rm history/$logname.brew
rm history/$logname.cooking
rm history/$logname.boiling
rm history/$logname.dressing
rm history/$logname.steaming
rm history/$logname.salting
rm history/$logname.oiling
rm history/$logname.serving
head -35 history/$logname.eating

#cat history/Dumb-Space.init | awk '{print $3 }'
done
