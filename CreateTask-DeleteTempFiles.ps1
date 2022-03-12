#This script generates and schedules a powershell script that deletes .tmp, .xls, and .xlsx files generated within the C:\Windows\Temp directory
#This is intended for use in automating Maintenance activity by Cloud Operations personnel. 
#WARNING: This script creates a destructive automation. Ensure proper backups are in place.
  
#$Path is where the generated file will live. Ideally C:\Staging
	$Path = ''
	$FileName = 'DSP_DeleteTempFiles.ps1'
	$FullPath = $Path + $FileName
	$DeleteTemp = "Get-ChildItem -Path 'C:\Windows\Temp\*' -include *.tmp,*xls,*xlsx | foreach { Remove-Item -Path $_.FullName }"
	$DeleteTemp | Out-File $FullPath
	
	$action = New-ScheduledTaskAction -Execute $FullPath
	$Principal = New-ScheduledTaskPrincipal -GroupID "BUILTIN\Administrators" -RunLevel Highest
	$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 6AM
	$Settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Hours 2)
	$task = New-ScheduledTask -Action $action -Principal $Principal -Trigger $Trigger -Settings $Settings
	Register-ScheduledTask DSP_DeleteTempFiles -InputObject $task