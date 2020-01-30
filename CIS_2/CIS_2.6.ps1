


## List the var Settings for all hosts
Write-host ("expected Net.DVFilterBindIpAddress = ''") -ForegroundColor Yellow 

# List Net.DVFilterBindIpAddress for each host
Get-VMHost | Select Name, @{N="Net.DVFilterBindIpAddress";E={$_ | Get- AdvancedSetting Net.DVFilterBindIpAddress | Select -ExpandProperty Values }} | Out-Host

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
    # Set Net.DVFilterBindIpAddress to null on all hosts
    Get-VMHost HOST1 | Foreach { Set-AdvancedSetting -VMHost $_ -Name Net.DVFilterBindIpAddress -IPValue "" }
    #
}
