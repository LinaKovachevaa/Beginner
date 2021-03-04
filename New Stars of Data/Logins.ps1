## Logins ##

$Instance1 = 'DESKTOP-O9D8065\TESTINSTANCE01'
$Instance2 = 'DESKTOP-O9D8065\TESTINSTANCE02'

# Gets all the logins from Instance1 using NT authentication and returns the SMO login objects
Get-DbaLogin -SqlInstance $Instance1 | Format-Table

# New SQL Server login 
New-DbaLogin -SqlInstance $Instance1 -Login Lina1

# Gets the users for AdventureWorks2019 database
Get-DbaDbUser -SqlInstance $Instance1 -Database AdventureWorks2019 | Format-Table

# New sql user with login named Lina1 in AdventureWorks2019
New-DbaDbUser -SqlInstance $Instance1 -Database AdventureWorks2019 -Login Lina1

# Returns all members roles of AdventureWorks2019 on Instance1
Get-DbaDbRoleMember -SqlInstance $Instance1 -Database AdventureWorks2019 | Format-Table

# Adds Lina1 to the roles db_datareader and db_datawriter in the database AdventureWorks2019
Add-DbaDbRoleMember -SqlInstance $Instance1 -Database AdventureWorks2019 -Role db_datareader, db_datawriter  -User Lina1

# Change password to login Lina1 

$SecurePassword = ConvertTo-SecureString "Lina1234" -AsPlainText -Force
Set-DbaLogin -SqlInstance $Instance1 -Login Lina1 -SecurePassword $SecurePassword

#Remove the login and user we created
Remove-DbaLogin -SqlInstance $Instance1 -Login Lina1
Remove-DbaDbUser -SqlInstance $Instance1 -Database AdventureWorks2019 -User Lina1