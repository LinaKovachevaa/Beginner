## Getting Started ##

# Install dbatools 
# Install the module from the PowerShell Gallery (*You have to run PowerShell as administartor)
Install-Module dbatools  

# Install the module only for your user account
Install-Module dbatools -Scope CurrentUser 

# If you don't have internet access you can save the module and copy it to the machine with no internet. More info : dbatools.io/downoad and dbatools.io/offlune

# Update a module from the PowerShell Gallery 
# You have to run PowerShell as administartor
Update-Module dbatools

# List modules currently imported into your session 
Get-Module dbatools

# List module versions that are available
Get-Module dbatools -ListAvailable

# Find available commands
# All commands available within dbatools
Get-Command -Module dbatools

# Number of commands currently within dbatools
(Get-Command -Module dbatools).Count

# Finiding a particular command 
Get-Command *Backup* -Module dbatools
Find-DbaCommand *Backup*
Find-DbaCommand -Tag Backup

# Get help on how to use a command
Get-Help Backup-DbaDatabase
Get-Help Backup-DbaDatabase -ShowWindow
Get-Help Backup-DbaDatabase -Detailed
Get-Help Backup-DbaDatabase -Examples

