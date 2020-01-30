# List all services for a host
Get-VMHost | Get-VMHostService
# List the services which are enabled and have rules defined for specific IP ranges to access the service
Get-VMHost | Get-VMHostFirewallException | Where {$_.Enabled -and (-not $_.ExtensionData.AllowedHosts.AllIP)}
# List the services which are enabled and do not have rules defined for specific IP ranges to access the service
Get-VMHost | Get-VMHostFirewallException | Where {$_.Enabled -and ($_.ExtensionData.AllowedHosts.AllIP)}