Push-Location; Import-Module sqlps -DisableNameChecking; Pop-Location

$serverPath = "SQLSERVER:\SQL\localhost\Default"
$databaseName = "<database>"
$backupTo = join-path (Get-Location) "$databaseName-before.bak"
Backup-SqlDatabase -Path $serverPath  -Database $databaseName  -BackupFile $backupTo