#!/bin/bash
read -p "Enter in the IP Address of the target Domain Controller: " dc_ip
read -p  "Would you like to perform User Enumeration using Kerbrute? (y/n): " answer
read -p "Please choose one of the following options on username format: john.doe, j.doe, johndoe, custom: " list
if [ "$list" = "custom" ]; then
	read -p "please enter wordlist file location " wordlist 
fi
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

kerpath=$(locate kerbrute.py)

if [[ "$answer" = "y" && "$kerpath" = *"kerbrute.py"* ]]; then
	echo -e "kerbrute.py was found: $kerpath"
	echo -e "$wordlist was selected"
	case $list in
		john.doe)
			echo -n "john.doe selected "
			wordlist="/usr/share/wordlists/custom/usernames/john.doe.txt"
			;;
		j.doe)
			echo -n "j.doe selected "
			wordlist="/usr/share/wordlists/custom/usernames/j.doe.txt"
			;;
		jdoe)
			echo -n "jdoe selected "
			wordlist="/usr/share/wordlists/custom/usernames/jdoe.txt"
			;;
		custom)
			echo -n "custom selected"
			;;
            	*)		
			echo -n "Error: unkown selection"
			;;		
	    esac
        python3 $kerpath -domain $domain -users $wordlist -dc-ip $dc_ip -outputusers kerbrute_users.txt
else
        echo -e "kerbrute.py was NOT found or input did not equal y, exiting kerbrute loop"
fi