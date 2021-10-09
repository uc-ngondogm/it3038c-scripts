$Machines = 'DESKTOP-4GSKKBP'
$Logfile = "C:\logs\cpu.log" 
clear-content $Logfile

Foreach ($machine in $Machines)  
{ 
    $RCounters = Get-Counter -ListSet * -ComputerName $machine 
    “There are {0} counters on {1}” -f $RCounters.count, ($machine)
    
    #$pt = (Get-Counter -Counter "\Processor(_Total)\% Processor Time").CounterSamples.CookedValue 
    $pt = (Get-Counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 1 -MaxSamples 5).CounterSamples.CookedValue
    #$pt 
    $sample = 1 
    foreach ($p in $pt) {
        $date = Get-Date -Format g
        "{3} - Sample {2}: CPU is at {0}% on {1}" -f [int]$p, $machine, $sample, $date | Out-File -Append $Logfile 
        $sample++
    }
} 
