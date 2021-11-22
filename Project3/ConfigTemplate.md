```bash
hostname ihg-<<Site>>
!
!
username installer privilege 15 secret P@ssw0rd!
enable password P@ssw0rd!
!  
!  
ip ssh time-out 60
crypto key generate rsa general-keys modulus 2048
!
!
bsd-client server url https://cloudsso.cisco.com/as/token.oauth2
clock timezone PST -5
clock summer-time EDT recurring
!
<<ExcludedAddress>>
!
ip dhcp pool LAN1
 network <<Lan1Ip>> <<Lan1SubnetMask>>
 default-router <<Lan1Gateway>>
 dns-server 75.75.75.75 75.75.76.76
 
ip dhcp pool LAN2Range
 network <<Lan2Ip>> <<Lan2SubnetMask>>
 default-router <<Lan2Gateway>>
 dns-server 75.75.75.75 75.75.76.76
!
!
interface GigabitEthernet0/0/0
 description WAN (<<AccountNumber>>) BW_(<<BandWidth>> MB)
 ip address <<Wan1PublicIp>> <<Wan1PublicSubnet>> 
 no cdp enable
 no shut
!
interface GigabitEthernet0/0/1
description LAN
 ip address <<Lan1IpPlus1>> <<Lan1SubnetMask>>
 ip address <<Lan2IpPlus1>> <<Lan2SubnetMask>> secondary 
 no cdp enable
 no shut
!
!
ip route 0.0.0.0 0.0.0.0 <<Wan1PublicGateway>>
!
!
ip access-list extended COPP
 deny ip <<LAN_NET_IP>> <<LAN-NET-WCM>> any 
 permit udp any any eq ntp
 permit ip any any
!
banner login ^
********************************************************************
Warning!
Authorized personnel only. Please log out immediately if you are not 
an authorized administrator
 
******************************************************************** 
Router  : $(hostname) 
Location: $(line-desc) 
^
!
ip ssh version 2 
ip ssh authentication-retries 3
line con 0
 logging synchronous
line vty 0 15
 exec-timeout 10 0
 transport input ssh
!
wr
```
