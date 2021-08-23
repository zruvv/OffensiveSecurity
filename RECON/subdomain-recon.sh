#!/bin/bash
echo "Enter in target domain: "
read domain
var_domain=.$domain
echo $var_domain
sublist3r -d $domain -n -o subdomain_raw.txt
amass enum --passive -d $domain >> subdomain_raw.txt

sort subdomain_raw.txt | uniq > subdomains.txt
rm subdomain_raw.txt
