# This is a powershell script to delete IIS log files on the application server. 
# This is intended to be run manually or automated by Cloud Operations for Maintenance activities
# WARNING: This is a destructive script. Please ensure all server backups are in place before running. 

$start = (get-date).AddDays(-180) 
Get-ChildItem -Path c:\inetpub\logs\logfiles\w3svc1\*.log | where {$PSItem.LastWriteTime -lt $start} | Remove-Item