#!/bin/bash
echo "Enter in the IP Address of the target Domain Controller: "
read dc_ip

#Collect DC domain (domain.local)
string="domain:"
domain=$(crackmapexec smb $dc_ip | awk '{print $12}' | sed 's/.*(\(.*\))/\1/' | sed -e "s/^$string//")

#Check for Anonymous SMB Share access
echo -e "Checking for Anonymous SMB Share Access"
smbclient -L \\\\$dc_ip -N

#Dumping RPC data using Impacket's rpcdump.py
echo -e "Dumping RPC data using rpcdump.py"
rpcdump.py -p 135 $dc_ip

#Checking for RPC Anonymouse Access
echo -e "Checking for Anonymous RPC Access"
echo -e " run enumdomains, enumdomusers, enumdomgroups, enumalsgroups, enumdata, exit"
#rpcclient $dc_ip -U '' -N


echo -e "Would you like to start User Enumeration using Kerbrute? (y/n)"
#read answer


if [ "$answer" = "y" ]; then
    kerpath=$(find / -name kerbrut.py 2>/dev/null);
    if [ $kerpath == *"kerbrute.py"* ]; then
        echo -e "kerbrute.py was found: $kerpath"
        python3 $kerpath -domain $domain -users /home/iv4user/Desktop/pentest/tools/resources/wordlists/usernames_john.doe.txt -dc-ip $dc_ip -outputusers kerbrute_users.txt;
    else
        echo -e "kerbrute.py was NOT found, exiting kerbrute loop";
else
    echo -e "Input did not equal y, exiting kerbrute loop";
fi