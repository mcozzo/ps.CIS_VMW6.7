﻿$DcuiTimeOut = "600"

## List the var Settings for all hosts
Write-host ("Expected Security.AccountUnlockTime = " + $DcuiTimeOut ) -ForegroundColor Yellow 

# List Syslog.global.logHost for each host
Get-VMHost | Foreach { 
    Get-AdvancedSetting -Entity $_ -Name UserVars.DcuiTimeOut | select Entity, Value #Format-List -property * # 
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
    # Set Syslog.global.logHost for each host
    Get-VMHost | Foreach { 
        Write-Host ("Working on: " + $_.Name) -ForegroundColor Yellow 
        Get-AdvancedSetting -Entity $_ -Name UserVars.DcuiTimeOut | Set-AdvancedSetting -Value $DcuiTimeOut -Confirm:$false
    }
    Write-Host ("Complete") -ForegroundColor Yellow 
    #s
}
