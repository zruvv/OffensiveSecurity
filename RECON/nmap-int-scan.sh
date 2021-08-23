#!/bin/bash
echo -e "Run as sudo...\n *This script is suitable for small - mid size internal scopes* \n"
echo "Enter file path to internalscope.txt file (exclude the trailing /): "
echo "Ex: /home/iv4user/Desktop/pentest/client/internal/scope"
read path

echo -e "\nEnter in name of internal scope file: "
echo "Ex: internalscope.txt"
read scope

echo -e "\n\e[1;32mStarting Host Discovery Scan \e[0m"
nmap -n -sn -T4 -iL $path/$scope -oA $path/hostdiscovery

echo -e "\n\e[1;33mCreating activehosts.txt file \e[0m"
cat $path/hostdiscovery.gnmap | awk '/Up$/{print $2}' > $path/activehosts.txt

echo -e "\n\e[1;32mStarting TCP Scan \e[0m"
nmap -n -sS -Pn -T4 -iL $path/activehosts.txt -oA $path/tcpscan

echo -e "\n\e[1;32mStarting UDP Scan \e[0m"
nmap -n -sU -Pn -iL $path/activehosts.txt -p 53,67-68,88,110-111,161-162,414,500-501 --reason -oA $path/udpscan

echo -e "\e[1;33mScans have completed, output files are located in $path\e[0m"
