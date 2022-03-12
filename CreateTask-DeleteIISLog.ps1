# This script creates the DeleteIISLog.ps1 file and sets it to run automatically once a week via Task Scheduler.
# This script is intended for the automation of this maintenance item by Cloud Operations
# WARNING: This script creates an automation that is destructive. Ensure all backups are in place. 

#$Path is where the generated file will live. 
	$Path = ''
	$FileName = 'DelIISLogFiles.ps1'
	$FullPath = $Path + $FileName
	$DeleteIISLog = '$start = (get-date).AddDays(-180) Get-ChildItem -Path c:\inetpub\logs\logfiles\w3svc1\*.log | where {$PSItem.LastWriteTime -lt $start} | Remove-Item'
	$DeleteIISLog | Out-File $FullPath
	
	$action = New-ScheduledTaskAction -Execute $FullPath
	$Principal = New-ScheduledTaskPrincipal -GroupID "BUILTIN\Administrators" -RunLevel Highest
	$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 6AM
	$Settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Hours 2)
	$task = New-ScheduledTask -Action $action -Principal $Principal -Trigger $Trigger -Settings $Settings
	Register-ScheduledTask DeleteIISLogFiles -InputObject $task