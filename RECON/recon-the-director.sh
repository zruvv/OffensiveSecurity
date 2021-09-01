#!/bin/bash
read -p "Enter in the IP Address of the target Domain Controller: " dc_ip
read -p  "Would you like to perform User Enumeration using Kerbrute? (y/n): " answer
read -p "Enter one of the following options on username format: john.doe, j.doe, jdoe, johndoe, custom: " list
echo ""
if [ "$list" = "custom" ]; then
	read -p "Enter wordlist file location " wordlist 
fi
#Collect DC domain (domain.local)
string="domain:"
echo -e "\e[1;32mRunning CrackMapExec\e[0m"
crackmapexec smb $dc_ip
domain=$(crackmapexec smb $dc_ip | awk '{print $12}' | sed 's/.*(\(.*\))/\1/' | sed -e "s/^$string//")

#Check for Anonymous SMB Share access
echo -e "\n\e[1;32mChecking for Anonymous SMB Share Access & listing open shares\e[0m"
smbclient -L \\\\$dc_ip -N

#Dumping RPC data using Impacket's rpcdump.py
echo -e "\n\e[1;32mDumping RPC data using rpcdump.py, see rpc_dump_results.txt\e[0m"
rpcdump.py -p 135 $dc_ip > rpc_dump_results.txt

#Checking for RPC Anonymouse Access
echo -e "\n\e[1;32mChecking for Anonymous RPC Access using rpcclient, see rpcclient_results.txt"
echo -e "\n\e[1;36mEnumerating Privleges\e[0m"
rpcclient 10.10.10.248 -c enumprivs  -U '' -N > rpcclient_results.txt
echo -e "\e[1;36mQuerying Display Info\e[0m" 
rpcclient 10.10.10.248 -c querydispinfo  -U '' -N >> rpcclient_results.txt
echo -e "\e[1;36mQuerying Domain Info\e[0m" 
rpcclient 10.10.10.248 -c querydominfo  -U '' -N >> rpcclient_results.txt
echo -e "\e[1;36mEnumerating Domain Users\e[0m"
rpcclient 10.10.10.248 -c enumdomusers -U '' -N >> rpcclient_results.txt
echo -e "\e[1;36mEnumerating Domain Groups\e[0m"
rpcclient 10.10.10.248 -c enumdomgroups  -U '' -N >> rpcclient_results.txt
echo -e "\e[1;36mEnumerating Domain Password Info\e[0m"
rpcclient 10.10.10.248 -c getdompwinfo -U '' -N >> rpcclient_results.txt

#Collecting Domain Naming Contexts
echo -e "\n\e[1;32mldapsearch to query DC namingcontexts\e[0m"
ldapsearch -x -h $dc_ip -s base namingcontexts | grep "namingcontexts:"

#Identifying Usernames that exist in Kerberos Active Directory, finds kerbrute.py if it exists on the attck system.
kerpath=$(locate kerbrute.py)

if [[ "$answer" = "y" && "$kerpath" = *"kerbrute.py"* ]]; then
	echo -e "\n\e[1;33mkerbrute.py was found: $kerpath \e[0m"
	case $list in
		john.doe)
			echo -n "john.doe wordlist selected "
			wordlist="/usr/share/wordlists/custom/usernames/john.doe.txt"
			;;
		j.doe)
			echo -n "j.doe wordlist selected "
			wordlist="/usr/share/wordlists/custom/usernames/j.doe.txt"
			;;
		jdoe)
			echo -n "jdoe wordlist selected "
			wordlist="/usr/share/wordlists/custom/usernames/jdoe.txt"
			;;
		johndoe)
			echo -n "johndoe wordlist selected "
			wordlist="/usr/share/wordlists/custom/usernames/johndoe.txt"
			;;
		custom)
			echo -n "custom selected"
			;;
            	*)		
			echo -n "Error: unkown selection"
			;;		
	    esac
        echo -e "\nkerbrute is starting, if you need to stop the search press CTRL +C twice"
		python3 $kerpath -domain $domain -users $wordlist -dc-ip $dc_ip -outputusers kerbrute_users.txt
		echo -e "\nkerbrute has completed, see kerbrute_users.txt"
else
        echo -e "\n\e[1;33mkerbrute.py was NOT found or input did not equal y, exiting kerbrute loop \e[0m"
fi