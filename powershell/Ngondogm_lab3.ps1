function getIP{ 

    (get-netipaddress).ipv4address | Select-String "192*" 
} 

$IP = getIP
$USER = $env:USERNAME
$NAME = $env:computername
$VERSION = Get-Host | Select-Object Version
$DAY = Get-Date -DisplayHint Date
$BODY = "This machine's IP is $IP, user is $USER, Hostname is $NAME, PowerShell version is $VERSION, Today's date is $DATE"

Write-Host($BODY)

Send-MailMessage -To "botheaj@ucmail.uc.edu" -From "guydavidngondo@gmail.com" -Subject "IT3038C Windows SysInfo" -Body $BODY -SmtpServer smtp.gmail.com -port 587 -UseSSL -Credential (Get-Credential)