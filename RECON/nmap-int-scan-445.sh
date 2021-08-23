#!/bin/bash

echo -e "Run as sudo...\n *This script is suitable for small - mid size internal scopes* \n"
echo "Enter file path to hosts_445.txt file (exclude the trailing /): "
echo "Ex: /home/user/Desktop/pentest/client/internal/scope"
read path

nmap -sU -sS -Pn -n -iL $path/hosts_445.txt --script smb-vuln-ms17-010,smb-os-discovery,smb-protocols,smb-enum-shares -p T:445,T:139,U:137 --open -oN smb_details.nmap

smbhosts=$(cat $path/hosts_445.txt)

#Checks for null session access, SMB shares + permissions
for ip in $smbhosts
do
	echo -e "\n\e[1;32mSMB results for $ip\e[0m" 
	rpcclient -U "" $ip
	# smbclient -L \\\\$ip -N
	smbmap -H $ip
	# enum4linux $ip
done
