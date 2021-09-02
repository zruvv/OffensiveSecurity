# Penny Testing Tools
A combination of Offensive Security tools and scripts for Red Teamers & Penetration Testers.

Table of Contents  
=================
 * [domain-recon](#domain-recon) 
 * [dns-transfer](#dns-transfer)
 * [int-scan-445](#int-scan-445) 
 * [int-scan](#int-scan) 
 * [int-scanalyze](#int-scanalyze)
 * [exploit-the-director](#exploit-the-director) 
 * [recon-the-director-null](#recon-the-director-null) 
 * [scanalyze](#scanalyze) 
 * [subdomain-recon](#subdomain-recon) 
 * [xtract-pdf-meta](#xtract-pdf-meta) 
 * [xtract-teams-chat-history](#xtract-teams-chat-history)
 * [xtract_win](#xtract_win) 


## RECON
#### domain-recon

Tool used to perform reconnaissance from a domain name. Outputs are sent to their respective .txt files in your current working directory.
DNS record lookups, Whois records, Publicly available email addresses, Domain typos

#### int-scan-445

Nmap commands that runs service discovery scan on hosts with port 445 open, NSE scripts (vulnerability checks, OS-discovery, enumsmb-shares), checks for null session access, SMB shares & their permissions.

#### int-scan

Nmap commands that take input text file of IP addresses and performs: Nmap Host Discovery scan, TCP Port Scan, UDP Port Scan and sends outputs to the specified file location. 

#### scanalyze

Utilizes linux formatting commands to produce summarized files showing top hosts + count of open TCP port, top hosts + count of open TCP port, hosts & their corresponding open TCP ports. All sorted by highest count descending. Provides option to move raw files to new subdirectory.

#### int-scanalyze

Combines nmap-int-scan.sh, nmap-int-scan-445, and nmap-scanalyze.sh to scan an internal netowrk (host discovery, TCP, UDP), SMB enumeration (null sessions, OS, shares, vulnerabilities) and summarizes output.

#### recon-the-director-null

Uses unauthenticated (null) access to query a domain controller through SMB, RPC, Kerberos, and LDAP. Identifies open SMB shares, domain data through RPC and LDAP, verifies if accounts exists through Kerberos responses

#### subdomain-recon

Utilizes sublist3r & amass to discover subdomains of a provided domain. Extracts indiviudal unique subdomains to a text file.

#### xtract-pdf-meta

Utilizes python's pdfminer module to dump the metadata of a directory full of PDFs.

## EXPLOIT
#### dns-transfer

Attempts a DNS Zone Transfer against target domain.

#### exploit-the-director

Uses verified credentials to query a domain controller through SMB, RPC, Kerberos, and LDAP. Identifies open SMB shares, domain data through LDAP & SMB, dumps domain & local accounts and groups, get's user SPNs, attempt to dump SAM, LSA, NTDS. Attempts to load mimikatz and dump hashes as well through cme.

## POST-EXPLOITATION
#### xtract-teams-chat-history

Extract Microsoft Teams chat history under the context of the current user executing the script.

#### xtract_win

Utilizes PowerShell to extract passwords from common Windows objects and files without needing to download additional password dump tools.
