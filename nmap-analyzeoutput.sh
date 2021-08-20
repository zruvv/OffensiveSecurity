#!/bin/bash
echo "Enter path to nmap output files (exclude the trailing /): "
read path
echo "Anlayzing Nmap output"

tcp_file=$path/tcpscan.gnmap
udp_file=$path/udpscan.gnmap
echo -e "\e[1;32mOpen TCP ports\e[0m"
egrep -v "^#|Status: Up" $tcp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk -F, '{split($0,a," "); printf "Host: %-20s TCP Ports Open: %d\n" , a[1], NF}' | sort -k 6 -r | uniq > tcp_hosts_top_open.txt
egrep -v "^#|Status: Up" $tcp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk -F, '{split($0,a," "); printf "Host: %-20s TCP Ports Open: %d\n" , a[1], NF}' | sort -k 6 -r | uniq

echo -e "\n\e[1;32mOpen UDP ports\e[0m"
egrep -v "^#|Status: Up" $udp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk -F, '{split($0,a," "); printf "Host: %-20s UDP Ports Open: %d\n" , a[1], NF}' | sort -k 6 -r | uniq > udp_hosts_top_open.txt
egrep -v "^#|Status: Up" $udp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk -F, '{split($0,a," "); printf "Host: %-20s UDP Ports Open: %d\n" , a[1], NF}' | sort -k 6 -r | uniq

echo -e "\n\e[1;32mAll Active host + TCP ports/service\e[0m"
egrep -v "^#|Status: Up" $tcp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk '{print "Host: " $1 " Ports: " NF-1; $1=""; for(i=2; i<=NF; i++) { a=a" "$i; }; split(a,s,","); for(e in s) { split(s[e],v,"/"); printf "%-8s %s/%-7s %s\n" , v[2], v[3], v[1], v[5]}; a="" }' > hosts_open_tcp.txt
egrep -v "^#|Status: Up" $tcp_file | cut -d' ' -f2,4- | sed -n -e 's/Ignored.*//p' | awk '{print "Host: " $1 " Ports: " NF-1; $1=""; for(i=2; i<=NF; i++) { a=a" "$i; }; split(a,s,","); for(e in s) { split(s[e],v,"/"); printf "%-8s %s/%-7s %s\n" , v[2], v[3], v[1], v[5]}; a="" }'

echo -e "\n\e[1;33mFull results can be found under $path/xxx_hosts_top_open.txt\e[0m"

echo -e "\nWould you like to move the raw nmap output files to a new sub dir - nmap_raw (y/n): "
read answer
echo $answer
if [ "$answer" = "y" ];
then
	mkdir $path/nmap_raw 2>/dev/null
	mv *discovery.gnmap $path/nmap_raw -f 2>/dev/null
	mv *discovery.nmap $path/nmap_raw -f 2>/dev/null
	mv *discovery.xml $path/nmap_raw -f 2>/dev/null
	mv *pscan.gnmap $path/nmap_raw -f 2>/dev/null
	mv *pscan.nmap $path/nmap_raw -f 2>/dev/null
	mv *pscan.xml $path/nmap_raw -f 2>/dev/null
	echo "Files were moved";
else
	echo "Files were not moved";
fi
