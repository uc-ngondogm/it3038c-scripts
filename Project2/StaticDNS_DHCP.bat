@echo off 
echo ==This Scripts will configure the Ethernet port with static and DNS IPs or DHCP addresses==
echo Choose: 
echo [1] Set Static and DNS IPs 
echo [2] Set DHCP 
echo. 
:choice 
SET /P C=[1,2]? 
for %%? in (1) do if /I "%C%"=="%%?" goto 1 
for %%? in (2) do if /I "%C%"=="%%?" goto 2 
goto choice 
:1 
@echo off 
echo "Setting static and DNS IPs on the Ethernet port..." 
netsh interface ip set address "Ethernet" static 192.168.0.51
netsh in ip add address "Ethernet" 192.168.1.100 255.255.255.0
netsh in ip add address "Ethernet" 192.168.15.10 255.255.255.0

netsh interface ipv4 add dnsserver "Ethernet" address=8.8.8.8 index=1
netsh interface ipv4 add dnsserver "Ethernet" address=4.2.2.2 index=2


echo Completed
pause 
goto end

:2 
@ECHO OFF 
ECHO Resetting IP Address and Subnet Mask For DHCP 
netsh interface ip set address "Ethernet" DHCP
netsh interface ipv4 set dns name="Ethernet" DHCP



echo Completed
pause 
goto end 
:end

Script END!