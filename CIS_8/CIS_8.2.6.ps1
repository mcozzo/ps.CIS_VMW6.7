﻿
$Value = $true
$Setting = 'isolation.device.edit.disable'
$Expected = "Expected: " +$Setting + " = " + $Value + " 
  or no results returned. Because " + $Setting + " is a new value" 

## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 

# List the VMs and their current settings
#Get-VM | Get-AdvancedSetting -Name "tools.setInfo.sizeLimit" | Select Entity, Name, Value | Out-Host

Get-VM | Foreach { 
    Get-AdvancedSetting -Entity $_ -name:$Setting  | select Entity, Name, Value #Format-List -property * # 
}
## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 

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
    #
    # Set Remove UserVars.ESXiShellInteractiveTimeOut to 300 on all hosts 
    Get-VM | New-AdvancedSetting -Name:$Setting -Value:$Value -Confirm:$false
    #
}

