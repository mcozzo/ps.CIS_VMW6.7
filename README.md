# CIS VMware 6.7 settings
CIS V1.0.0 <br>
Just L1 audit / remediate powershell stuff

## Running
It's assumed that you run scripts from the current drectory. E.G.
```powershell
Connect-VIServer -Server <Server>
.\CIS_1\CIS_1.1.ps1
.\CIS_1\CIS_1.2.ps1
# etc...
```

## ToDo
* Build a script to launch all checks from the root dir instead of running each individually

## Contributors 
Based on the CIS documentation for vSphere 6.7
* https://www.cisecurity.org/
** Powershell started from CIS doc, updated to actually work 
