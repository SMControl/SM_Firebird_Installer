# SM Firebird Installer

**Please note this is a Public Repository**

Automates the correct SM installation and configuration of Firebird server.

![Firebird Installation Demo](https://github.com/SMControl/SM_Firebird_Installer/blob/main/SM_Firebird_Installer_Example_GIF.gif)

- Fully Automated
- Installs Firebird 4.0.1 32-bit for Windows with SM's required criteria.
- Modifies `firebird.conf` to set `DataTypeCompatibility = 3.0`.
- Sets permissions for `C:\Program Files (x86)\Firebird` folder and its child items.
- Starts the Firebird Service.

## Usage

### Online Install
Copy into Admin Powershell:
```
irm https://raw.githubusercontent.com/SMControl/SM_Firebird_Installer/main/SMFI_Online.ps1 | iex
```

### Offline Installer
Copy onto target machine and run as Admin. See the [Release Page](https://github.com/SMControl/SM_Firebird_Installer/releases).
