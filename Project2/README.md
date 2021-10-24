# Project 2

## This batch script will either assign a set of static and DNS IP addresses to the Ethernet NIC card or enable DHCP.

This script will automatically setup the Ethernet NIC with three static IP addresses, including the primary and backup DNS IP addresses.

These are IPs use for this script: 
- 192.168.0.51 255.255.255.0
- 192.168.1.100 255.255.255.0
- 192.168.15.10 255.255.255.0
- Primary DNS: 8.8.8.8
- Secondary DNS: 4.2.2.2

From the batch file directory, run the program as administrator (you can only run and execute this script as an administrator).

```bash
PS C:\it3038c-scripts\Project1> powershell -command "Start-Process staticDNS_dhcp.bat -Verb runas" 
```
A new cmd administrator window will be opened when you run the command above. Click yes to open.
![](2021-10-24-11-17-08.png)

The script will prompt you to select 1 for static & DNS or 2 for DHCP.
Example Output:

![](2021-10-24-11-46-54.png)

In this example we selected 1 to set static and DNS IPs on the Ethernet port, once completed the script will prompt you to press any key to exit.

You can verify the result on your Ethernet port: Control Panel\Network and Internet\Network Connections

![](2021-10-24-11-50-31.png)
![](2021-10-24-11-51-57.png)


If there is a duplicate IP or if you run option 1 again, you will get this out put:
```bash
[1,2]? 1
"Setting static and DNS 
IPs on the Ethernet port..."

The object is already in the list.

The object is already in the list.

Completed
Press any key to continue . . .
```
"The object is already in the list." Tells you that the static IPs you trying to add is/are already set on the NIC card.

Now, let switch the Ethernet port back to DHCP. Run the script as administrator and type 2 when prompted.
```bash
PS C:\it3038c-scripts\Project1> powershell -command "Start-Process staticdhcp.bat -Verb runas" 
```
Example output: 

![](2021-10-24-11-55-37.png)

Type any key to exit the script. You can verify the result on your Ethernet port: Control Panel\Network and Internet\Network Connections

![](2021-10-24-11-58-00.png)

If you run it again with option 2 you will get "DHCP is already enabled on this interface". 

Example output:

```bash
==This Scripts will configure the Ethernet port with static and DNS IPs or DHCP addresses==
Choose:
[1] Set Static and DNS IPs
[2] Set DHCP

[1,2]? 2
Resetting IP Address and Subnet Mask For DHCP
DHCP is already enabled on this interface.


Completed
Press any key to continue . . .
```


