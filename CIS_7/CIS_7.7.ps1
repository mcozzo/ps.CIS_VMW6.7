$VAR = 3600
$Setting = 'UserVars.ESXiShellTimeOut'

## List the var Settings for all hosts
Write-host ("expected, no results returned" ) -ForegroundColor Yellow 

#Get-VDPortgroup | Select Name, VirtualSwitch, @{Name="NetflowEnabled";Expression={$_.Extensiondata.Config.defaultPortConfig.ipfixEnabled.Value}} | Where-Object {$_.NetflowEnabled -eq "True"} | Out-Host
Get-VDPortgroup | Select Name, VDSwitch, @{Name="NetflowEnabled";Expression={$_.Extensiondata.Config.defaultPortConfig.ipfixEnabled.Value}} | Where-Object {$_.NetflowEnabled -eq "True"} | Out-Host


