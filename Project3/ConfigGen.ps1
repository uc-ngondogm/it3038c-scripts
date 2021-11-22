# Guy-David Ngondo 11/26/2021
#
# Cisco Config script




## Regex for Subnet Mask validation
$regex = '(^(0|128|192|224|240|248|252|254|255)\.0\.0\.0$)|(^255\.(0|128|192|224|240|248|252|254|255)\.0\.0$)|(^255\.255\.(0|128|192|224|240|248|252|254|255)\.0$)|(^255\.255\.255\.(0|128|192|224|240|248|252|254|255)$)'


Write-Host "Enter router model (4300, 4400)"
$router_model = Read-Host

while ($router_model -ne "4300" -and
        $router_model -ne "4400")
        {
            Write-Host "Invalid!" -ForegroundColor Red
            Write-Host "Enter router model (4300, 4400)"
            $router_model = Read-Host
        }


Write-Host "Enter number of LAN IPs (1, 2)"
[System.Int16]$LanIPnum = Read-Host

while ($LanIPnum -ne 1 -and $LanIPnum -ne 2){
               
Write-Host "Invalid!" -ForegroundColor Red
Write-Host "Enter number of LAN IPs (1, 2)"
$LanIPnum = Read-Host


}


Write-Host "enter site name (XXXXX)"
$HostName = Read-Host

Write-Host "enter WAN host IP"
$WANUsableIP = Read-Host

Write-Host "enter WAN Gateway"
$WANGateway = Read-Host


Write-Host "enter WAN Subnet Mask"
$WANSubnet = Read-Host


while ([regex]::Match($WANSubnet, $regex).success -eq $false){  #Validate WAN Mask

    Write-Host "Invalid subnet mask!" -ForegroundColor Red
    Write-Host ""
    Write-Host "reenter WAN Subnet Mask"
    $WANSubnet = Read-Host

}

Write-Host "valid subnet mask" -ForegroundColor Green



Write-Host "enter LAN IP 1"
$LANIP = Read-Host

## Grab last Octet, perform arithmetic, and join.
$IndexDot = $LANIP.LastIndexOf(".") + 1
$lastOct = $LANIP.Substring($IndexDot)
$number1 = [convert]::ToInt32($lastOct, 10) + 1
$number7 = [convert]::ToInt32($lastOct, 10) + 7

$ConcatIP1 = $LANIP[0.. $LANIP.LastIndexOf(".")] + $number1
$ConcatIP7 = $LANIP[0.. $LANIP.LastIndexOf(".")] + $number7

$LANIPplus1 = $ConcatIP1 -join ""
$LANIPplus7 = $ConcatIP7 -join ""




## for 2 LAN IPs
if ($LanIPnum -eq 2){

    Write-Host "enter LAN IP 2"
    $LANIP2 = Read-Host

    ## Grab last Octet, perform arithmetic, and join.
    $IndexDot2 = $LANIP2.LastIndexOf(".") + 1
    $lastOct2 = $LANIP2.Substring($IndexDot2)
    $number12 = [convert]::ToInt32($lastOct2, 10) + 1
    $ConcatIP12 = $LANIP2[0.. $LANIP2.LastIndexOf(".")] + $number12
    $LANIP2plus1 = $ConcatIP12 -join ""
}



Write-Host "enter LAN Subnet 1"
$LANSubnet = Read-Host

while ([regex]::Match($LANSubnet, $regex).success -eq $false){  #Validate LAN Mask

    Write-Host "Invalid subnet mask!" -ForegroundColor Red
    Write-Host ""
    Write-Host "reenter LAN Subnet Mask"
    $LANSubnet = Read-Host

}

Write-Host "valid subnet mask" -ForegroundColor Green
$Lan1Subnet_Split = $LANSubnet.Split(".")
$Lan1WildcardMask = @()
foreach ($now in $Lan1Subnet_Split)
{
    $Lan1WildcardMask += 255 - $now

}
$Lan1WildcardMask = $Lan1WildcardMask -join "."


## for 2 LAN IPs
if ($LanIPnum -eq 2){

    Write-Host "enter LAN Subnet 2"
    $LANSubnet2 = Read-Host


    while ([regex]::Match($LANSubnet2, $regex).success -eq $false){  #Validate LAN Mask

        Write-Host "Invalid subnet mask!" -ForegroundColor Red
        Write-Host ""
        Write-Host "reenter LAN Subnet Mask"
        $LANSubnet2 = Read-Host

    }

    Write-Host "valid subnet mask" -ForegroundColor Green
    $Lan2Subnet_Split = $LANSubnet2.Split(".")
    $Lan2WildcardMask = @()
    foreach ($now in $Lan2Subnet_Split)
    {
        $Lan2WildcardMask += 255 - $now
    
    }
    $Lan2WildcardMask = $Lan2WildcardMask -join "."

}



Write-Host "enter Bandwidth (50)"
$bandwidth = Read-Host


Write-Host ("Hit Enter to create Router#$HostName.txt")
$go = Read-Host


if ($LanIPnum -eq 1 -and ($router_model -eq "4300" -or $router_model -eq "4400"))
{
    Write-Host "Config_Template(4300&4400 Cisco Routers).txt"
   $Gold = Get-Content "C:\Configs\Config_Template(4300&4400 Cisco Routers).txt"
}


if ($LanIPnum -eq 2 -and ($router_model -eq "4300" -or $router_model -eq "4400"))
{
    Write-Host "Config_Template(4300&4400 Cisco Routers).txt"
    $Gold = Get-Content "C:\Configs\Config_Template(4300&4400 Cisco Routers).txt"
}

$pathOut = "C:\Configs\Router#$HostName.txt"
#"C:\Scripting\Router#" + $HostName + ".txt"



if ($LANSubnet -eq "255.255.255.248"){ ##REMOVES "ip dhcp excluded-address" IF LAN SUBNET MASK IS 225.255.255.248
    
    $Gold = $Gold -replace [Regex]::Escape("<<ExcludedAddress>>"), "!"

}

else {

    $Gold = $Gold -replace [Regex]::Escape("<<ExcludedAddress>>"), "ip dhcp excluded-address $LANIPplus1 $LANIPplus7"
}


$Gold = $Gold -replace [Regex]::Escape("<<Site>>"), $HostName
$Gold = $Gold -replace [Regex]::Escape("<<Lan1Ip>>"), $LANIP
$Gold = $Gold -replace [Regex]::Escape("<<Lan1SubnetMask>>"), $LANSubnet
$Gold = $Gold -replace [Regex]::Escape("<<Lan1Gateway>>"), $LANIPplus1
$Gold = $Gold -replace [Regex]::Escape("<<AccountNumber>>"), $ACCT
$Gold = $Gold -replace [Regex]::Escape("<<BandWidth>>"), $bandwidth
$Gold = $Gold -replace [Regex]::Escape("<<Wan1PublicIp>>"), $WANUsableIP
$Gold = $Gold -replace [Regex]::Escape("<<Wan1PublicSubnet>>"), $WANSubnet
$Gold = $Gold -replace [Regex]::Escape("<<Lan1IpPlus1>>"), $LANIPplus1
$Gold = $Gold -replace [Regex]::Escape("<<Wan1PublicGateway>>"), $WANGateway
$Gold = $Gold -replace [Regex]::Escape("<<Lan2Ip>>"), $LANIP2
$Gold = $Gold -replace [Regex]::Escape("<<Lan2SubnetMask>>"), $LANSubnet2
$Gold = $Gold -replace [Regex]::Escape("<<Lan2Gateway>>"), $LANIP2plus1
$Gold = $Gold -replace [Regex]::Escape("<<Lan2IpPlus1>>"), $LANIP2plus1
$Gold = $Gold -replace [Regex]::Escape("<<LAN1_NET_IP>>"), $LANIP
$Gold = $Gold -replace [Regex]::Escape("<<LAN_NET_IP>>"), $LANIP
$Gold = $Gold -replace [Regex]::Escape("<<LAN2_NET_IP>>"), $LANIP2
$Gold = $Gold -replace [Regex]::Escape("<<LAN-NET-WCM>>"), $Lan1WildcardMask
$Gold = $Gold -replace [Regex]::Escape("<<LAN1-NET-WCM>>"), $Lan1WildcardMask
$Gold = $Gold -replace [Regex]::Escape("<<LAN2-NET-WCM>>"), $Lan2WildcardMask


$Gold | Out-File -FilePath $pathOut
"" | Out-File -FilePath  ("C:\Configs\Router-$HostName.txt")
