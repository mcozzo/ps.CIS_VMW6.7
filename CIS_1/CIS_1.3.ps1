# List the system modules and Signature Info for each host 
Foreach ($VMHost in Get-VMHost ) {
    $ESXCli = Get-EsxCli -VMHost $VMHost 
    $ESXCli.system.module.list() | Foreach {
        $ESXCli.system.module.get($_.Name) | Select @{N="VMHost";E={$VMHost}}, Module, License, Modulefile, Version, SignedStatus, SignatureDigest, SignatureFingerPrint
    } 
}