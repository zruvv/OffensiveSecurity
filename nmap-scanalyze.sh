#!/bin/bash

##################################
#ANALYZING OUTPUT OF SCAN RESULTS#
##################################

echo "Enter file path to folder storing nmap output files (exclude the trailing /): "
echo "Ex: /home/iv4user/Desktop/pentest/client/internal/scope"
read path
echo "Anlayzing Nmap output"

tcp_file=$path/tcpscan.gnmap
udp_file=$path/udpscan.gnmap
echo -e "\e[1;32mOpen TCP ports\e[0m"
egrep -v "^#|Status: Up" $tcp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk -F, '{split($0,a," "); printf "Host: %-20s TCP Ports Open: %d\n" , a[1], NF}' | sort -k 6 -r | uniq > $path/hosts_tcp_open_top.txt
egrep -v "^#|Status: Up" $tcp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk -F, '{split($0,a," "); printf "Host: %-20s TCP Ports Open: %d\n" , a[1], NF}' | sort -k 6 -r | uniq

echo -e "\n\e[1;32mOpen UDP ports\e[0m"
egrep -v "^#|Status: Up" $udp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk -F, '{split($0,a," "); printf "Host: %-20s UDP Ports Open: %d\n" , a[1], NF}' | sort -k 6 -r | uniq > $path/hosts_udp_open_top.txt
egrep -v "^#|Status: Up" $udp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk -F, '{split($0,a," "); printf "Host: %-20s UDP Ports Open: %d\n" , a[1], NF}' | sort -k 6 -r | uniq

echo -e "\n\e[1;32mAll Active host + TCP ports/service\e[0m"
egrep -v "^#|Status: Up" $tcp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk '{print "Host: " $1 " Ports: " NF-1; $1=""; for(i=2; i<=NF; i++) { a=a" "$i; }; split(a,s,","); for(e in s) { split(s[e],v,"/"); printf "%-8s %s/%-7s %s\n" , v[2], v[3], v[1], v[5]}; a="" }' > $path/hosts_tcp_open.txt
egrep -v "^#|Status: Up" $tcp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk '{print "Host: " $1 " Ports: " NF-1; $1=""; for(i=2; i<=NF; i++) { a=a" "$i; }; split(a,s,","); for(e in s) { split(s[e],v,"/"); printf "%-8s %s/%-7s %s\n" , v[2], v[3], v[1], v[5]}; a="" }'

mkdir $path/hosts_ports
cat $tcp_file | awk '/80\/open/ {print $2}' > hosts_80.txt
cat $tcp_file | awk '/443\/open/ {print $2}' > hosts_443.txt
cat $tcp_file | awk '/8080\/open/ {print $2}' > hosts_8080.txt
cat $tcp_file | awk '/22\/open/ {print $2}' > hosts_22.txt
cat $tcp_file | awk '/445\/open/ {print $2}' > hosts_445.txt
cat $tcp_file | awk '/21\/open/ {print $2}' > hosts_21.txt
cat $tcp_file | awk '/23\/open/ {print $2}' > hosts_23.txt
cat $tcp_file | awk '/25\/open/ {print $2}' > hosts_25.txt
cat $tcp_file | awk '/69\/open/ {print $2}' > hosts_69.txt
cat $tcp_file | awk '/1433\/open/ {print $2}' > hosts_1433.txt
cat $tcp_file | awk '/3389\/open/ {print $2}' > hosts_3389.txt
cat $tcp_file | awk '/3306\/open/ {print $2}' > hosts_3306.txt
find $path -type f -size 0 -delete

echo -e "\n\e[1;33mFull results can be found under $path\e[0m"

echo -e "\nWould you like to move the raw nmap output files to a new sub dir - nmap_raw (y/n): "
read answer
echo $answer
if [ "$answer" = "y" ];
then
	mkdir $path/nmap_raw 2>/dev/null
	mv $path/*discovery.gnmap $path/nmap_raw/ -f 2>/dev/null
	mv $path/*discovery.nmap $path/nmap_raw/ -f 2>/dev/null
	mv $path/*discovery.xml $path/nmap_raw/ -f 2>/dev/null
	mv $path/*pscan.gnmap $path/nmap_raw/ -f 2>/dev/null
	mv $path/*pscan.nmap $path/nmap_raw/ -f 2>/dev/null
	mv $path/*pscan.xml $path/nmap_raw/ -f 2>/dev/null
	echo "Files were moved";
else
	echo "Files were not moved";
fi
