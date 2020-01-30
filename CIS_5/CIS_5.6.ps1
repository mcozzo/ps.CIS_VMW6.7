
## List the var Settings for all hosts
#Write-host ("expected NTP servers: " + $VAR ) -ForegroundColor Yellow 

# To check if Lockdown mode is enabled
Get-VMHost | Select Name,@{N="Lockdown";E={$_.Extensiondata.Config.adminDisabled}}

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
    # Enable lockdown mode for each host
    Get-VMHost | Foreach { $_.EnterLockdownMode() }
    #
}
