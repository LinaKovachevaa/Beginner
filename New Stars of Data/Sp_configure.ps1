## sp_configure ##

$Instance1 = 'DESKTOP-O9D8065\TESTINSTANCE01'
$Instance2 = 'DESKTOP-O9D8065\TESTINSTANCE02'  


#Get all Configuration properties (Out-GridView)
Get-DbaSpConfigure -SqlInstance $Instance1 | ogv

#Get the value for XPCmdShellEnabled
Get-DbaSpConfigure -SqlInstance $Instance1 -Name XPCmdShellEnabled

#Set the value for XPCmdShellEnabled
Set-DbaSpConfigure -SqlInstance $Instance1 -Name XPCmdShellEnabled -Value 1

#Export the configuration to a .sql file (useful for documentation purposes)
Export-DbaSpConfigure  -SqlInstance $Instance1 -Path C:\temp

#Compare configuuration of two servers 
$SPConfigure_Instance1 = Get-DbaSpConfigure -SqlInstance $Instance1
$SPConfigure_Instance2 = Get-DbaSpConfigure -SqlInstance $Instance2
$propcompare = foreach ($prop in $SPConfigure_Instance1) {
    [pscustomobject]@{
        Config                  = $prop.DisplayName
        'Windows Node1 setting' = $prop.RunningValue
        'Windows Node2 Setting' = $SPConfigure_Instance2 | Where DisplayName -eq $prop.DisplayName | Select -ExpandProperty RunningValue
    }
}
$propcompare | ogv

#Copy configuration from one Instance to the other
Import-DbaSpConfigure -Source $Instance1 -Destination $Instance2

Get-DbaSpConfigure -SqlInstance $Instance2 -Name XPCmdShellEnabled

#Configure multiple Instances simultaneously
$AllInstances = $Instance1 , $Instance2
Get-DbaSpConfigure -SqlInstance $AllInstances -Name XPCmdShellEnabled | ft
Set-DbaSpConfigure -SqlInstance $AllInstances -Name XPCmdShellEnabled -Value 0

