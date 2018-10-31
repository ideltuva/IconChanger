

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\Desktop\My Computer.lnk")
$Shortcut.TargetPath = "%windir%\explorer.exe/root,,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
# $Shortcut.TargetPath = "%windir%\explorer.exe" ::{20D04FE0-3AEA-1069-A2D8-08002B30309D}" #
$Shortcut.TargetPath.Trim('"')
$shortcut.IconLocation="$Home\Desktop\Icon Project\emoji.ico"
$Shortcut.Save()

Write-Host "Done"