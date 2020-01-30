$sysloghost = "udp://172.16.14.181:514"

## List the var Settings for all hosts
Write-host ("Expected Syslog.global.logHost: " + $sysloghost ) -ForegroundColor Yellow 

# List Syslog.global.logHost for each host
Get-VMHost | Select Name, @{N="Syslog.global.logHost";E={$_ | Get-AdvancedSetting Syslog.global.logHost}} | Out-Host

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
    #
    # Set Syslog.global.logHost for each host
    Get-VMHost | Foreach { 
        Write-Host ("Working on: " + $_.Name) -ForegroundColor Yellow 
        Get-AdvancedSetting -Entity $_ -name Syslog.global.logHost | Set-AdvancedSetting -Value $sysloghost -Confirm:$false
    }
    Write-Host ("Complete") -ForegroundColor Yellow 
    #
}
