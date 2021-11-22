# Project 3

## This Powershell script will generate a cisco router configuration using a template and export the configiguration file to a directory 

-[Project3](/Config_Template(4300&4400 Cisco Routers).txt)

This script will automatically setup the Ethernet NIC with three static IP addresses, including the primary and backup DNS IP addresses.

These are IPs used for this script: 
- 192.168.0.51 255.255.255.0
- 192.168.1.100 255.255.255.0
- 192.168.15.10 255.255.255.0
- Primary DNS: 8.8.8.8
- Secondary DNS: 4.2.2.2

From the batch file directory, run the program as administrator (you can only run and execute this script as an administrator).

```bash
PS C:\it3038c-scripts\Project1> powershell -command "Start-Process staticDNS_dhcp.bat -Verb runas" 
```



```bash

```

```bash

```
Example output: 
 

Example output:

```bash

```


