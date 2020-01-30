$Value = 3600
$Setting = 'UserVars.ESXiShellTimeOut'
$Expected = "Checking for CIS_7.4 - 7.6
Expected: 
  Block           : True
  TrafficShaping  : False
  Security        : False
  Vlan            : False
  UplinkTeaming   : False (Except iSCSI. LACP considerations)
  ResetPortConfig : True
  "

## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 

Get-VDPortgroup | Get-VDPortgroupOverridePolicy #| select *

#Get-VMHost | Select Name, @{N="UserVars.ESXiShellInteractiveTimeOut";E={$_ | Get-AdvancedSetting UserVars.ESXiShellInteractiveTimeOut | Out-Host

## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 
