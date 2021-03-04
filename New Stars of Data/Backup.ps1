## Backups ##

$Instance1 = 'DESKTOP-O9D8065\TESTINSTANCE01'
$Instance2 = 'DESKTOP-O9D8065\TESTINSTANCE02'

#Database information for each database on Instance1
Get-DbaDatabase -SqlInstance $Instance1 -ExcludeAllSystemDb | Format-Table

#Perform a full database backup on Instance1 to C:\temp\Backup directory.
Backup-DbaDatabase -SqlInstance $Instance1 -Database AdventureWorks2019 -Path C:\temp\Backup -Type Full

# Whats our Backup ThroughPut ? How quickly SQL Server is backing up databases?
Measure-DbaBackupThroughput -SqlInstance $Instance1 | ft

#Backup history details for Instance1
Get-DbaDbBackupHistory -SqlInstance $Instance1 | Sort-Object Start

# Check databases on Instance2
Get-DbaDatabase -SqlInstance $Instance2 | Format-Table

# Check that we have enough space on the destination 
$Databases = (Get-DbaDatabase -SqlInstance $Instance1 -ExcludeAllSystemDb -ExcludeDatabase WideWorldImporters).Name
$measurement = $Databases.ForEach{
    Measure-DbaDiskSpaceRequirement -Source $Instance1 -Destination $Instance2 -Database $PSItem
}
$measurement.DifferenceSize | Measure-Object -Property Megabyte -Sum

# Disk information for Instance2
Get-DbaDiskSpace -ComputerName $Instance2

# Calculate the space needed to copy and replace AdventureWorks2019 from Instance1 to Instance2.
Measure-DbaDiskSpaceRequirement -Source $Instance1 -Destination $Instance2 -Database AdventureWorks2019

# Restores databases on Instance2 from backup files 
Restore-DbaDatabase -SqlInstance $Instance2 -Path C:\temp\Backup -DatabaseName AdventureWorks2019 -WithReplace

Get-DbaDatabase -SqlInstance $Instance2 | Format-Table

# Test the last set of full backups for Instance2
Test-DbaLastBackup -SqlInstance $Instance2 | Out-GridView



