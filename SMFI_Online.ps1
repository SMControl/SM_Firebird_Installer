################################
# Part 1 - Pre Install Check
################################
# Check if running as admin
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
    Write-Output ("`n" * 10)
    Write-Output "Downloading Firebird Installer..."
    $installerUrl = "https://github.com/SMControl/SM_Firebird_Installer/raw/main/Firebird-4.0.1.exe"
    $installerPath = "$env:TEMP\Firebird-4.0.1.exe"
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

    ################################
    # Part 3 - Installation of Firebird with scripted parameters
    ################################
    Write-Output "Installing Firebird..."
    Start-Process -FilePath $installerPath -ArgumentList "/LANG=en", "/NORESTART", "/VERYSILENT", "/MERGETASKS=UseClassicServerTask,UseServiceTask,CopyFbClientAsGds32Task" -Wait

    ################################
    # Part 4 - Modify firebird.conf
    ################################
    Write-Output "Modifying firebird.conf..."
    (Get-Content "C:\Program Files (x86)\Firebird\Firebird_4_0\firebird.conf") -replace '#DataTypeCompatibility.*', 'DataTypeCompatibility = 3.0' | Set-Content "C:\Program Files (x86)\Firebird\Firebird_4_0\firebird.conf"

    ################################
    # Part 5 - Adjusting permissions
    ################################
    icacls "C:\Program Files (x86)\Firebird" /grant "*S-1-1-0:(OI)(CI)F" /T /C | Out-Null
    Write-Output "Adjusting permissions..."
    icacls "C:\Program Files (x86)\Firebird" /grant "*S-1-1-0:(OI)(CI)F" /T /C >$null

    ################################
    # Part 6 - Start Firebird service
    ################################
    Write-Output "Starting Firebird service..."
    Start-Service -Name "FirebirdServerDefaultInstance"

    ################################
    # Part 7 - Cleanup
    ################################
    Write-Output "Cleaning up temporary files..."
    Remove-Item $installerPath

    ################################
    # Part 8 - Installation Successful
    ################################
    Write-Output "Firebird installation completed successfully."
    ################################
    # Part 9 - Summary
    ################################
    Write-Output "Installation Summary:"
    Write-Output "- Firebird installed at 'C:\Program Files (x86)\Firebird'"
    Write-Output "- firebird.conf modified"
    Write-Output "- Permissions adjusted"
    Write-Output "- Firebird service started"
    Write-Output "- Temporary installer file removed"
} else {
    Write-Output "Firebird is already installed. Exiting script..."
}
# Wait for user input to close the script
Write-Output "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
