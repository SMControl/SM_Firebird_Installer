# Part 1 - Installation of Firebird with scripted parameters
Start-Process -FilePath ".\Firebird-4.0.1.exe" -ArgumentList "/LANG=en", "/NORESTART", "/SILENT", "/MERGETASKS=UseClassicServerTask,UseServiceTask,CopyFbClientAsGds32Task" -Wait

# Part 2 - Modify firebird.conf
Add-Content -Path "C:\Program Files (x86)\Firebird\Firebird_4_0\firebird.conf" -Value "DataTypeCompatibility = 3.0"

# Part 3 - Adjusting permissions
icacls "C:\Program Files (x86)\Firebird" /grant "*S-1-1-0:(OI)(CI)F" /T /C

# Part 4 - Start Firebird service
Start-Service -Name "FirebirdServerDefaultInstance"
