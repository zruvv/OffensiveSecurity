#!/bin/bash
echo "Enter file path to internalscope.txt file (exclude the trailing /: "
echo "Ex: /home/iv4user/Desktop/pentest/client/internal/scope"
read path

echo "Enter in name of internal scope file: "
echo "Ex: internalscope.txt"
read scope

sudo nmap -n -sP -iL $path/$scope -oA $path/hostdiscovery
cat $path/hostdiscovery.gnmap | awk '/Up$/{print $2}' >> $path/activehosts.txt
sudo nmap -n -sS -iL $path/activehosts.txt -oA $path/tcpscan
sudo nmap -n -sU -iL $path/activehosts.txt -p 53,67-68,88,110-111,161-162,414,500-501 --reason -oA $path/udpscan
