Foreach ($VMHost in Get-VMHost ) {
    $ESXCli = Get-EsxCli -VMHost $VMHost; 
    $ESXCLI.software.vib.list | Select-Object @{N="VMHost";E={$VMHost}}, Name,AcceptanceLevel, CreationDate, ID, InstallDate, Status, Vendor, Version;
}