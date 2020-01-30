# Set the value for the NTP servers
$NTPServers = "172.16.14.105", "172.16.14.110", "10.101.0.101", "10.101.0.102"

# List the NTP Settings for all hosts
Write-host ("expected NTP servers: " + $NTPServers) -ForegroundColor Yellow 

Get-VMHost | Select Name, @{N="NTPSetting";E={$_ | Get-VMHostNtpServer}}    

Write-host "Would you like remediate?" -ForegroundColor Yellow 
    $Readhost = Read-Host " ( y / n ) " 
    Switch ($ReadHost) 
    { 
        Y { Write-host "Yes, performing remediation"; $Remediate=$true }
        N { Write-Host "No, Skipping"; $Remediate=$false } 
        Default {Write-Host "Default, Skipping"; $Remediate=$false } 
    } 

If($Remediate) {
    # Set the NTP settings for all hosts
    Get-VMHost | Add-VMHostNtpServer $NTPServers
}
