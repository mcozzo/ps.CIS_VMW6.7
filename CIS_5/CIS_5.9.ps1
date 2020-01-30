$VAR = 3600
$Setting = 'UserVars.ESXiShellTimeOut'

## List the var Settings for all hosts
Write-host ("expected " + $Setting + "=" + $VAR ) -ForegroundColor Yellow 

# List UserVars.ESXiShellInteractiveTimeOut for each host
#Get-VMHost | Select Name, @{N="Syslog.global.logHost";E={$_ | Get-AdvancedSetting Syslog.global.logHost}} | Out-Host
Get-VMHost | Foreach { 
    Get-AdvancedSetting -Entity $_ -name:$Setting  | select Entity, Value #Format-List -property * # 
}


#Get-VMHost | Select Name, @{N="UserVars.ESXiShellInteractiveTimeOut";E={$_ | Get-AdvancedSetting UserVars.ESXiShellInteractiveTimeOut | Out-Host

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
    # Set Remove UserVars.ESXiShellInteractiveTimeOut to 300 on all hosts 
    Get-VMHost | Get-AdvancedSetting -Name:$Setting | Set-AdvancedSetting -Value:$VAR -Confirm:$false
    #
}
