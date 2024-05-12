################################
# Part 1 - Pre Install Check
################################
# Check if running as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Please run this script as an administrator."
    exit 1
}

# Check if the directory exists
if (!(Test-Path "C:\Program Files (x86)\Firebird")) {
    Write-Output "The directory 'C:\Program Files (x86)\Firebird' does NOT exist. Proceeding with the installation..."

################################
# Part 2 - Installation of Firebird with scripted parameters
################################
Start-Process -FilePath ".\Firebird-4.0.1.exe" -ArgumentList "/LANG=en", "/NORESTART", "/SILENT", "/MERGETASKS=UseClassicServerTask,UseServiceTask,CopyFbClientAsGds32Task" -Wait

################################
# Part 3 - Modify firebird.conf
################################
(Get-Content "C:\Program Files (x86)\Firebird\Firebird_4_0\firebird.conf") -replace '#DataTypeCompatibility.*', 'DataTypeCompatibility = 3.0' | Set-Content "C:\Program Files (x86)\Firebird\Firebird_4_0\firebird.conf"

################################
# Part 4 - Adjusting permissions
################################
icacls "C:\Program Files (x86)\Firebird" /grant "*S-1-1-0:(OI)(CI)F" /T /C > $null

################################
# Part 5 - Start Firebird service
################################
Start-Service -Name "FirebirdServerDefaultInstance"

} else {
    Write-Output "Firebird is already installed. Exiting script..."
}
