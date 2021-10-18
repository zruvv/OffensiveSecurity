#!/bin/bash
echo "Enter in target domain: "
read domain

echo "DNS Lookup"
dnsrecon -d $domain > dns_records.txt
echo "Whois Lookup"
whois $domain > whois_records_raw.txt

#Collect publicly available email addresses
echo "Collecting publicly available email addresses using theHarvester"
theHarvester -d $domain -b google > harvester_results.txt
theHarvester -d $domain -b duckduckgo >> harvester_results.txt
theHarvester -d $domain -b yahoo >> harvester_results.txt
theHarvester -d $domain -b bing >> harvester_results.txt
echo "Completed email collection"

#Extract emails addresses into a seperate file
var_domain=@$domain
cat harvester_results.txt | awk -v var="$var_domain"  '$0~var{print}' > email.txt

#Search for Domain Typos
echo "Searching for Domain Typos using URLCrazy"
urlcrazy --format=CSV $domain > domaintypo_results.csv
