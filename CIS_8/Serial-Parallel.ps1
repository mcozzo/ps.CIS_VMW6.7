# This code sourced from: 
# https://blogs.vmware.com/PowerCLI/2012/05/working-with-vm-devices-in-powercli.html

Function Get-SerialPort {
    Param (
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        $VM
    )
    Process {
        Foreach ($VMachine in $VM) {
            Foreach ($Device in $VMachine.ExtensionData.Config.Hardware.Device) {
                If ($Device.gettype().Name -eq "VirtualSerialPort"){
                    $Details = New-Object PsObject
                    $Details | Add-Member Noteproperty VM -Value $VMachine
                    $Details | Add-Member Noteproperty Name -Value $Device.DeviceInfo.Label
                    If ($Device.Backing.FileName) { $Details | Add-Member Noteproperty Filename -Value $Device.Backing.FileName }
                    If ($Device.Backing.Datastore) { $Details | Add-Member Noteproperty Datastore -Value $Device.Backing.Datastore }
                    If ($Device.Backing.DeviceName) { $Details | Add-Member Noteproperty DeviceName -Value $Device.Backing.DeviceName }
                    $Details | Add-Member Noteproperty Connected -Value $Device.Connectable.Connected
                    $Details | Add-Member Noteproperty StartConnected -Value $Device.Connectable.StartConnected
                    $Details
                }
            }
        }
    }
}

Function Remove-SerialPort {
    Param (
        [Parameter(Mandatory=$True,ValueFromPipelinebyPropertyName=$True)]
        $VM,
        [Parameter(Mandatory=$True,ValueFromPipelinebyPropertyName=$True)]
        $Name
    )
    Process {
        $VMSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
        $VMSpec.deviceChange = New-Object VMware.Vim.VirtualDeviceConfigSpec
        $VMSpec.deviceChange[0] = New-Object VMware.Vim.VirtualDeviceConfigSpec
        $VMSpec.deviceChange[0].operation = "remove"
        $Device = $VM.ExtensionData.Config.Hardware.Device | Foreach {
            $_ | Where {$_.gettype().Name -eq "VirtualSerialPort"} | Where { $_.DeviceInfo.Label -eq $Name }
        }
        $VMSpec.deviceChange[0].device = $Device
        $VM.ExtensionData.ReconfigVM_Task($VMSpec)
    }
}

Function Get-ParallelPort {
    Param (
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelinebyPropertyName=$True)]
        $VM
    )
    Process {
        Foreach ($VMachine in $VM) {
            Foreach ($Device in $VMachine.ExtensionData.Config.Hardware.Device) {
                If ($Device.gettype().Name -eq "VirtualParallelPort"){
                    $Details = New-Object PsObject
                    $Details | Add-Member Noteproperty VM -Value $VMachine
                    $Details | Add-Member Noteproperty Name -Value $Device.DeviceInfo.Label
                    If ($Device.Backing.FileName) { $Details | Add-Member Noteproperty Filename -Value $Device.Backing.FileName }
                    If ($Device.Backing.Datastore) { $Details | Add-Member Noteproperty Datastore -Value $Device.Backing.Datastore }
                    If ($Device.Backing.DeviceName) { $Details | Add-Member Noteproperty DeviceName -Value $Device.Backing.DeviceName }
                    $Details | Add-Member Noteproperty Connected -Value $Device.Connectable.Connected
                    $Details | Add-Member Noteproperty StartConnected -Value $Device.Connectable.StartConnected
                    $Details
                }
            }
        }
    }
}

Function Remove-ParallelPort {
    Param (
        [Parameter(Mandatory=$True,ValueFromPipelinebyPropertyName=$True)]
        $VM,
        [Parameter(Mandatory=$True,ValueFromPipelinebyPropertyName=$True)]
        $Name
    )
    Process {
        $VMSpec = New-Object VMware.Vim.VirtualMachineConfigSpec
        $VMSpec.deviceChange = New-Object VMware.Vim.VirtualDeviceConfigSpec
        $VMSpec.deviceChange[0] = New-Object VMware.Vim.VirtualDeviceConfigSpec
        $VMSpec.deviceChange[0].operation = "remove"
        $Device = $VM.ExtensionData.Config.Hardware.Device | Foreach {
            $_ | Where {$_.gettype().Name -eq "VirtualParallelPort"} | Where { $_.DeviceInfo.Label -eq $Name }
        }
        $VMSpec.deviceChange[0].device = $Device
        $VM.ExtensionData.ReconfigVM_Task($VMSpec)
    }
}