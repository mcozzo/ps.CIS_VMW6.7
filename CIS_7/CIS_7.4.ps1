$VAR = 3600
$Setting = 'UserVars.ESXiShellTimeOut'
$Expected = "Checking for CIS_7.4 - 7.6
Expected: 
  VLanID != 1              (7.4)
  VLanID != 1001-1024,4094 (7.5)
  VLanID != 3968-4047,4094 (7.5)
  VLanID != 4095           (7.6)
"

## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 

# List all vSwitches, their Portgroups and VLAN IDs 
Get-VirtualPortGroup -Standard | Select VMHostID, virtualSwitch, Name, VlanID

## List the var Settings for all hosts
Write-host ( $Expected ) -ForegroundColor Yellow 
