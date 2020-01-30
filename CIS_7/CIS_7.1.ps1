# CIS 7.1-3

$Value = 'root'
$Setting = 'DCUI.Access'
$Expected = "Checking for CIS_7.1 - 7.3
Expected: 
  ForgedTransmits : Reject (7.1)
  MacChanges      : Reject (7.2)
  PromiscuousMode : Reject (7.3)
"

## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 

# List all vSwitches and their Security Settings 
Get-VirtualSwitch -Standard | Select VMHost, Name, `
@{N="ForgedTransmits";E={if ($_.ExtensionData.Spec.Policy.Security.ForgedTransmits) { "Accept" } Else { "Reject"} }}, `
@{N="MacChanges";E={if ($_.ExtensionData.Spec.Policy.Security.MacChanges) { "Accept" } Else { "Reject"} }}, `
@{N="PromiscuousMode";E={if ($_.ExtensionData.Spec.Policy.Security.PromiscuousMode) { "Accept" } Else { "Reject"} }}

Write-host ( $Expected ) -ForegroundColor Yellow 

#Get-VMHost | Select Name, @{N="UserVars.ESXiShellInteractiveTimeOut";E={$_ | Get-AdvancedSetting UserVars.ESXiShellInteractiveTimeOut | Out-Host

#Write-host "Would you like remediate?" -ForegroundColor Yellow 
#    $Readhost = Read-Host " ( y / n ) " 
#    Switch ($ReadHost) 
#    { 
#        Y { Write-host "Yes, performing remediation"; $Remediate=$true }
#        N { Write-Host "No, Skipping"; $Remediate=$false } 
#        Default {Write-Host "Default, Skipping"; $Remediate=$false } 
#    } 

#If($Remediate) {
#    # Set the NTP settings for all hosts
#    #
#    # Set Remove UserVars.ESXiShellInteractiveTimeOut to 300 on all hosts 
#    # Get-VMHost | Get-AdvancedSetting -Name:$Setting | Set-AdvancedSetting -Value:$Value -Confirm:$false
#    #
#}
