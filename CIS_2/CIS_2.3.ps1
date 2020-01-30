
## List the var Settings for all hosts
Write-host ("Expect Value=False ") -ForegroundColor Yellow 
# Check for MOB on hosts
Get-VMHost | Get-AdvancedSetting -Name Config.HostAgent.plugins.solo.enableMob

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
    # Note: You cannot disable the MOB while a host is in lockdown mode
    Get-VMHost | Get-AdvancedSetting -Name Config.HostAgent.plugins.solo.enableMob
}

     
   