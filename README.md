# SM Firebird Installer

**Please note this is a Public Repository**

Automates the SM installation of Firebird.

- Fully Automated
- Installs Firebird 4.0.1 32-bit for Windows with SM's required criteria.
- Modifies `firebird.conf` to set `DataTypeCompatibility = 3.0`.
- Sets SM required permissions for `C:\Program Files (x86)\Firebird` folder and its child items.
- Starts the Firebird Service at the end.

## Usage

### Online Install
Copy into Admin Powershell:
```
irm https://github.com/SMControl/SM_Firebird_Installer/raw/main/SMFI_Online.ps1 | iex
```

### Offline Installer
Copy onto target machine and run as Admin. See the [Release Page](https://github.com/SMControl/SM_Firebird_Installer/releases).
