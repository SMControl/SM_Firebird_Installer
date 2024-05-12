################################
# Part 1 - Pre Install Check
################################
Write-Output "Checking if running as administrator..."
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Please run this script as an administrator."
    exit 1
}

Write-Output "Checking if the directory 'C:\Program Files (x86)\Firebird' exists..."
# Check if the directory exists
if (!(Test-Path "C:\Program Files (x86)\Firebird")) {
    Write-Output "The directory 'C:\Program Files (x86)\Firebird' does NOT exist. Proceeding with the installation..."

    ################################
    # Part 2 - Download Firebird Installer
    ################################
    Write-Output "Downloading Firebird Installer..."
    $installerUrl = "https://github.com/SMControl/SM_Firebird_Installer/raw/main/Firebird-4.0.1.exe"
    $installerPath = "$env:TEMP\Firebird-4.0.1.exe"
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

    ################################
    # Display Progress
    ################################
    Write-Output "Download complete."

    ################################
    # Part 3 - Installation of Firebird with scripted parameters
    ################################
    Write-Output "Starting Firebird installation..."
    Start-Process -FilePath $installerPath -ArgumentList "/LANG=en", "/NORESTART", "/SILENT", "/MERGETASKS=UseClassicServerTask,UseServiceTask,CopyFbClientAsGds32Task" -Wait

    ################################
    # Part 4 - Modify firebird.conf
    ################################
    Write-Output "Modifying firebird.conf..."
    (Get-Content "C:\Program Files (x86)\Firebird\Firebird_4_0\firebird.conf") -replace '#DataTypeCompatibility.*', 'DataTypeCompatibility = 3.0' | Set-Content "C:\Program Files (x86)\Firebird\Firebird_4_0\firebird.conf"

    ################################
    # Part 5 - Adjusting permissions
    ################################
    Write-Output "Adjusting 
