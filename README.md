# SM Firebird Installer

**This is a Public Repository**

The SM Firebird Installer automates the installation process for Firebird 4.0.1 32 bit on Windows with specific criteria required by SM.

It includes scripted configuration settings and requires no user interaction.

Features:
- Installs Firebird 4.0.1 32-bit for Windows with SM's rquired criteria.
- Modifies `firebird.conf` to set `DataTypeCompatibility = 3.0`.
- Sets permissions for `C:\Program Files (x86)\Firebird` folder and its child items.
- Starts the Firebird service automatically.

## Usage

### Download and Run

You can download the installer from the [release page](https://github.com/SMControl/SM_Firebird_Installer/releases).

### Run via PowerShell

You can also run the installer directly on the target machine using the following PowerShell command.
This command will determine which is the latest release version, download and install it.

```powershell
Invoke-RestMethod -Uri "https://api.github.com/repos/SMControl/SM_Firebird_Installer/releases/latest" | 
    Select-Object -ExpandProperty assets | 
    Select-Object -First 1 -ExpandProperty browser_download_url | 
    ForEach-Object { 
        Invoke-WebRequest -Uri $_ -OutFile "$env:TEMP\SM_Firebird_Installer.exe" 
    }; 
Start-Process -FilePath "$env:TEMP\SM_Firebird_Installer.exe" -Wait
