$DcuiTimeOut = "600"

## List the var Settings for all hosts
Write-host ("Expected policy = 'off'" ) -ForegroundColor Yellow 

# List DCUI settings for all hosts
Get-VMHost | Get-VMHostService | Where { $_.key -eq "DCUI" }

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
    # Set DCUI to start manually rather than automatically for all hosts 
    Get-VMHost | Get-VMHostService | Where { $_.key -eq "DCUI" } | Set-VMHostService -Policy off
#    Get-VMHost | Foreach { 
#        Write-Host ("Working on: " + $_.Name) -ForegroundColor Yellow 
#        Get-AdvancedSetting -Entity $_ -Name UserVars.DcuiTimeOut | Set-AdvancedSetting -Value $DcuiTimeOut -Confirm:$false
#    }
    Write-Host ("Complete") -ForegroundColor Yellow 
    #s
}
