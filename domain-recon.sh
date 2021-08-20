#!/bin/bash
echo "Enter in target domain: "
read domain

dnsrecon -d $domain > dns_records.txt
whois $domain > whois_records_raw.txt

#Collect publicly available email addresses
theHarvester -d $domain -b google > harvester_results.txt
theHarvester -d $domain -b duckduckgo >> harvester_results.txt
theHarvester -d $domain -b yahoo >> harvester_results.txt
theHarvester -d $domain -b bing >> harvester_results.txt

#Extract emails addresses into a seperate file
var_domain=@$domain
cat harvester_results.txt | awk -v var="$var_domain"  '$0~var{print}' > email.txt

#Search for Domain Typos
urlcrazy --format=CSV $domain > domaintypo_results.csv
