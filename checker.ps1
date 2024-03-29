cls
$Query = New-Object System.Management.WqlEventQuery "__InstanceCreationEvent", (New-Object TimeSpan 0,0,1), "TargetInstance isa 'Win32_PnPEntity'"
$ProcessWatcher = New-Object System.Management.ManagementEventWatcher $Query
Register-ObjectEvent -InputObject $ProcessWatcher -EventName "EventArrived" -SourceIdentifier DeviceChangeEvent
write-host (get-date -format s) " Beginning script..."
do{
    write-host (get-date -format s) "**********Init Event**********..."
	$getEvent = Wait-Event -SourceIdentifier DeviceChangeEvent   
    $ti = $getEvent.SourceEventArgs.NewEvent.TargetInstance    
    $HardwareID = $ti.HardwareID
    if ($HardwareID -like "*USB\VID_2717&PID_FF4*"){
        start-sleep -seconds 3
		start-process "Z:\sync.bat"
        write-host (get-date -format s) "Correct Connected"
    }else{
        write-host (get-date -format s) "No Correct Device Connected"
    }
	Remove-Event -SourceIdentifier DeviceChangeEvent
    write-host (get-date -format s) "***********End of Event********..."
} while (1-eq1) #Loop until next evente
Unregister-Event -SourceIdentifier DeviceChangeEvent