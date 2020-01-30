
## List the var Settings for all hosts
#Write-host ("expected NTP servers: " + $VAR ) -ForegroundColor Yellow 

# May need "| Out-Host" on the end of the checks. 
# PUT CODE HERE
#

Write-host "Would you like remediate?" -ForegroundColor Yellow 
    $Readhost = Read-Host " ( y / n ) " 
    Switch ($ReadHost) 
    { 
        Y { Write-host "Yes, performing remediation"; $Remediate=$true }
        N { Write-Host "No, Skipping"; $Remediate=$false } 
        Default {Write-Host "Default, Skipping"; $Remediate=$false } 
    } 

If($Remediate) {
    
    # May need "-Confirm:$false"
    #
    # PUT CODE HERE
    #
}
