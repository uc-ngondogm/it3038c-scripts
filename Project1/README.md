# Project 1

This batch script will populate a preloaded set of static IPs on the Ethernet NIC card or switch it to DHCP


Now, from the it3038c-scripts directory, run the program using Batch (you can only run this script as an administrator)

```bash
PS C:\it3038c-scripts\Project1> powershell -command "Start-Process staticdhcp.bat -Verb runas" 
```
The script will prompt you to select 1 for static or 2 for DHCP.
Example Output: 
```bash
==This Scripts will configure Ethernet port on static or DHCP==
Choose:
[1] Set Static IP
[2] Set DHCP

[1,2]? 1
"Setting static IPs on the Ethernet port..."


Completed
Press any key to continue . . .

```
In this example we selected 1 to set static IP on the Ethernet port once completed the script will prompt you to press any key to exit.

If there is a duplicate IP or run option 1 again, you will get this out put:
```bash
[1,2]? 1
"Setting static IPs on the Ethernet port..."

The object is already in the list.

The object is already in the list.

Completed
Press any key to continue . . .
```
Now let switch the Ethernet port back to DHCP by entering 2 when prompted.
Example output: 
```bash
==This Scripts will configure static or DHCP addreses on the Ethernet port==
Choose:
[1] Set Static IP
[2] Set DHCP

[1,2]? 2
Resetting IP Address and Subnet Mask For DHCP

Completed
Press any key to continue . . .

```
If you run it again:
```bash
==This Scripts will configure static or DHCP addreses on the Ethernet port==
Choose:
[1] Set Static IP
[2] Set DHCP

[1,2]? 2
Resetting IP Address and Subnet Mask For DHCP
DHCP is already enabled on this interface.

Completed
Press any key to continue . . .
```

