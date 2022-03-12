#This code deletes .tmp, .xls, and .xlsx files generated within the C:\Windows\Temp directory
#This is intended for use in automating Maintenance activity by Cloud Operations personnel. 
#WARNING: This script is destructive and proper backups should take place before this script is run

Get-ChildItem -Path 'C:\Windows\Temp\*' -include *.tmp,*xls,*xlsx | foreach { Remove-Item -Path $_.FullName }