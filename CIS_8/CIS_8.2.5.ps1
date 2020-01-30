

$Expected = "Expected: <null> " 

## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 

# Check for USB Devices attached to VMs 
Get-VM | Get-USBDevice | select *

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
    # Remove all USB Devices attached to VMs 
    Get-VM | Get-USBDevice | Remove-USBDevice 
    #
}


