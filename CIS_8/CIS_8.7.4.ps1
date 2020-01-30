$Value = 1024000
$Setting = 'log.rotateSize'

## List the var Settings for all hosts
Write-host ("expected " + $Setting + " = " + $Value ) -ForegroundColor Yellow 

# List UserVars.ESXiShellInteractiveTimeOut for each host
#Get-VMHost | Select Name, @{N="Syslog.global.logHost";E={$_ | Get-AdvancedSetting Syslog.global.logHost}} | Out-Host
Get-VM | Foreach { 
    Get-AdvancedSetting -Entity $_ -name:$Setting  | select Entity, Value #Format-List -property * # 
}

## List the var Settings for all hosts
Write-host ("expected " + $Setting + " = " + $Value ) -ForegroundColor Yellow 

#Get-VMHost | Select Name, @{N="UserVars.ESXiShellInteractiveTimeOut";E={$_ | Get-AdvancedSetting UserVars.ESXiShellInteractiveTimeOut | Out-Host

Write-host "Would you like remediate?" -ForegroundColor Yellow 
Write-host "Caution remediation not tested!" -ForegroundColor Red 
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
    Get-VM | Get-AdvancedSetting -Name:$Setting | New-AdvancedSetting -Value:$Value -Confirm:$false
    #
}
