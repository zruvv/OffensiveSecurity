# Penny Testing Tools
A combination of Offensive Security tools for Red Teamers & Penetration Testers.

Table of Contents  
=================
 * [domain-recon](#domain-recon) 
 * [nmap-int-scan](#nmap-int-scan) 
 * [nmap-int-scanalyze](#nmap-int-scanalyze) 
 * [nmap-scanalyze](#nmap-scanalyze) 
 * [subdomain-recon](#subdomain-recon) 

## domain-recon
Tool used to perform reconnaissance from a domain name. Outputs are sent to their respective .txt files in your current working directory.
DNS record lookups, Whois records, Publicly available email addresses, Domain typos

## nmap-int-scan
Nmap commands that take input text file of IP addresses and performs: Nmap Host Discovery scan, TCP Port Scan, UDP Port Scan and sends outputs to the specified file location. 

## nmap-scanalyze
 Utilizes linux formatting commands to produce summarized files showing top hosts + count of open TCP port, top hosts + count of open TCP port, hosts & their corresponding open TCP ports. All sorted by highest count descending. Provides option to move raw files to new subdirectory.

## nmap-int-scanalyze
Combines nmap-int-scan.sh with nmap-scanalyze.sh to scan an internal netowrk (host discovery, TCP, UDP) and summarize output.

## subdomain-recon
Utilizes sublist3r & amass to discover subdomains of a provided domain. Extracts indiviudal unique subdomains to a text file.
