Push-Location; Import-Module sqlps -DisableNameChecking; Pop-Location

$serverPath = "SQLSERVER:\SQL\localhost\Default"
$databaseName = "<database>_compare"
$sourceDatabaseName = "<database>"
$restoreFrom = join-path (Get-Location) "$sourceDatabaseName-before.bak"

$databasePath = join-path $serverPath "Databases\$databaseName"
if(Test-Path $databasePath)
{
        Invoke-SqlCmd "USE [master]; ALTER DATABASE [$databaseName] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE [$databaseName]"
}

$server = Get-Item $serverPath
$dataFilePath = join-path $server.Information.MasterDBPath "$databaseName.mdf"
$logFilePath = join-path $server.Information.MasterDBPath "$($databaseName)_log.ldf"
$files = @()
$files += New-Object 'Microsoft.SqlServer.Management.Smo.RelocateFile, Microsoft.SqlServer.SmoExtended, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' -ArgumentList $sourceDatabaseName, $dataFilePath
$files += New-Object  'Microsoft.SqlServer.Management.Smo.RelocateFile, Microsoft.SqlServer.SmoExtended, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91' -ArgumentList "$($sourceDatabaseName)_log", $logFilePath

Restore-SqlDatabase -Path $serverPath -Database $databaseName -BackupFile $restoreFrom -RelocateFile $files
