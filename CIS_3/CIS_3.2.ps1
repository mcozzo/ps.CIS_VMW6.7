$syslogdir = "[FILESDATA1] /syslog"

## List the var Settings for all hosts
Write-host ("Expected Syslog.global.logDir: " + $syslogdir ) -ForegroundColor Yellow 

# List Syslog.global.logDir for each host
#Get-VMHost | Select Name, @{N="Syslog.global.logDir";E={$_ | Get-AdvancedConfiguration Syslog.global.logDir | Select -ExpandProperty Values}} | Out-Host
Get-VMHost | Foreach { 
    Get-AdvancedSetting -Entity $_ -name Syslog.global.logDir | select Entity, Value #Format-List -property * # 
}

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
    # Set Syslog.global.logDir for each host
#    Get-VMHost | Foreach { Set-AdvancedConfiguration -VMHost $_ -Name Syslog.global.logDir -Value $syslogdir }
    Get-VMHost | Foreach { 
        Write-Host ("Working on: " + $_.Name) -ForegroundColor Yellow 
        Get-AdvancedSetting -Entity $_ -Name Syslog.global.logDir | Set-AdvancedSetting -Value "$syslogdir" -Confirm:$false
        Get-AdvancedSetting -Entity $_ -Name Syslog.global.logDirUnique | Set-AdvancedSetting -Value "true" -Confirm:$false
    }
    Write-Host ("Complete") -ForegroundColor Yellow 

    #
}
