# Penny Testing Tools
A combination of Offensive Security tools and scripts for Red Teamers & Penetration Testers.

Table of Contents  
=================
 * [domain-recon](#domain-recon) 
 * [dns-transfer](#dns-transfer)
 * [int-scan-445](#int-scan-445) 
 * [int-scan](#int-scan) 
 * [int-scanalyze](#int-scanalyze)
 * [recon-the-director](#recon-the-director) 
 * [scanalyze](#scanalyze) 
 * [subdomain-recon](#subdomain-recon) 
 * [xtract-teams-chat-history](#xtract-teams-chat-history)
 * [xtract_win](#xtract_win) 

##RECON
### domain-recon
tree/main/RECON

Tool used to perform reconnaissance from a domain name. Outputs are sent to their respective .txt files in your current working directory.
DNS record lookups, Whois records, Publicly available email addresses, Domain typos

## dns-transfer
tree/main/EXPLOIT

Attempts a DNS Zone Transfer against target domain.

## int-scan-445
tree/main/RECON

Nmap commands that runs service discovery scan on hosts with port 445 open, NSE scripts (vulnerability checks, OS-discovery, enumsmb-shares), checks for null session access, SMB shares & their permissions.

## int-scan
tree/main/RECON

Nmap commands that take input text file of IP addresses and performs: Nmap Host Discovery scan, TCP Port Scan, UDP Port Scan and sends outputs to the specified file location. 

## scanalyze
tree/main/RECON

Utilizes linux formatting commands to produce summarized files showing top hosts + count of open TCP port, top hosts + count of open TCP port, hosts & their corresponding open TCP ports. All sorted by highest count descending. Provides option to move raw files to new subdirectory.

## int-scanalyze
tree/main/RECON

Combines nmap-int-scan.sh, nmap-int-scan-445, and nmap-scanalyze.sh to scan an internal netowrk (host discovery, TCP, UDP), SMB enumeration (null sessions, OS, shares, vulnerabilities) and summarizes output.

## recon-the-director
tree/main/RECON

Uses unauthenticated (null) access to query a domain controller through SMB, RPC, Kerberos, and LDAP. Identifies open SMB shares, domain data through RPC and LDAP, verifies if accounts exists through Kerberos responses

## subdomain-recon
tree/main/RECON

Utilizes sublist3r & amass to discover subdomains of a provided domain. Extracts indiviudal unique subdomains to a text file.

## xtract-teams-chat-history
tree/main/EXPLOIT

Extract Microsoft Teams chat history under the context of the current user executing the script.

## xtract_win
tree/main/POST-EXPLOIT

Utilizes PowerShell to extract passwords from common Windows objects and files without needing to download additional password dump tools.
