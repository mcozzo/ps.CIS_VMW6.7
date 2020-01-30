


## List the var Settings for all hosts
#Write-host ("expected Net.DVFilterBindIpAddress = ''") -ForegroundColor Yellow 

# Confirm the host profile is using vSphere Authentication proxy to add the host to the domain
Get-VMHost | Select Name, ` @{N="HostProfile";E={$_ | Get-VMHostProfile}}, ` @{N="JoinADEnabled";E={($_ | Get-VmHostProfile).ExtensionData.Config.ApplyProfile.Authentication.ActiveDirectory.Enabled}}, ` @{N="JoinDomainMethod";E={(($_ | Get-VMHostProfile).ExtensionData.Config.ApplyProfile.Authentication.ActiveDirectory | Select -ExpandProperty Policy | Where {$_.Id -eq "JoinDomainMethodPolicy"}).Policyoption.Id}}

# Check each host and their domain membership status
Get-VMHost | Get-VMHostAuthentication | Select VmHost, Domain, DomainMembershipStatus

#Write-host "Would you like remediate?" -ForegroundColor Yellow 
#    $Readhost = Read-Host " ( y / n ) " 
#    Switch ($ReadHost) 
#    { 
#        Y { Write-host "Yes, performing remediation"; $Remediate=$true }
#        N { Write-Host "No, Skipping"; $Remediate=$false } 
#        Default {Write-Host "Default, Skipping"; $Remediate=$false } 
#    } 

If($Remediate) {
    # Set the NTP settings for all hosts
    #
    # Set Net.DVFilterBindIpAddress to null on all hosts
    #
}
