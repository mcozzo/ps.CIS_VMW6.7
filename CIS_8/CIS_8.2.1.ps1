

$Expected = "Expected: Floppy drive 1 NotConnected, GuestControl, NoStartConnected" 

## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 

# Check for Floppy Devices attached to VMs
Get-VM | Get-FloppyDrive | Select Parent, Name, ConnectionState

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
    # Set the NTP settings for all hosts
    #
    # Remove all Floppy drives attached to VMs 
    Get-VM | Get-FloppyDrive | Remove-FloppyDrive
    #
}


