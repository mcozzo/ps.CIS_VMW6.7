# In this Example you will need to add the functions from this post: 
# https://blogs.vmware.com/PowerCLI/2012/05/working-with-vm-devices-in-powercli.html
. .\CIS_8\Serial-Parallel.ps1

$Expected = "Expected: <null>
     " 

## List the var Settings for all hosts
Write-host ( "CIS_8.2.3 - 8.2.4"  ) -ForegroundColor Yellow 
Write-host ( $Expected ) -ForegroundColor Yellow 

Write-host ( "Paralell ports - Start (8.2.3)"  ) -ForegroundColor Yellow 
Get-VM | Get-ParallelPort | select * #Parent,IsoPath,ConnectionState
Write-host ( "Paralell ports - End (8.2.3)"  ) -ForegroundColor Yellow 

Write-host ( "===================="  ) 

Write-host ( "Serial ports - Start (8.2.4)"  ) -ForegroundColor Yellow 
Get-VM | Get-SerialPort | select * #Parent,IsoPath,ConnectionState
Write-host ( "Serial ports - End (8.2.4)" ) -ForegroundColor Yellow 

## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 

Write-host "Would you like remediate?
  Removes Serial & Paralell ports" -ForegroundColor Yellow 
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
    # Remove all Parallel Ports attached to VMs
    Get-VM | Get-ParallelPort | Remove-ParallelPort
    Get-VM | Get-SerialPort | Remove-SerialPort
    #
}


