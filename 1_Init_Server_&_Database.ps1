$Server = Read-Host -Prompt 'Enter your server name'
$Database = Read-Host -Prompt 'Enter your database name'

(Get-Content conf\flyway.conf).replace('<server>', $Server).replace('<database>', $Database) | Set-Content conf\flyway.conf
(Get-Content 'Backup Dev to After.ps1').replace('<database>', $Database) | Set-Content 'Backup Dev to After.ps1'
(Get-Content 'Backup Dev to Before.ps1').replace('<database>', $Database) | Set-Content 'Backup Dev to Before.ps1'
(Get-Content 'Create Compare from before.ps1').replace('<database>', $Database) | Set-Content 'Create Compare from before.ps1'
(Get-Content 'Restore Dev from after.ps1').replace('<database>', $Database) | Set-Content 'Restore Dev from after.ps1'
(Get-Content 'Restore Dev from before.ps1').replace('<database>', $Database) | Set-Content 'Restore Dev from before.ps1'