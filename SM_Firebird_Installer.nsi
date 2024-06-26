; Script generated by the HM NIS Edit Script Wizard.
OutFile "SM_Firebird_Installer_vX.exe"
RequestExecutionLevel admin
InstallDir "$TEMP\FirebirdInstaller"

Section
  ; Extract the Firebird installer and PowerShell script to a temporary directory
  SetOutPath "$TEMP\FirebirdInstaller"
  File "Firebird-4.0.1.exe"
  File "SM_Firebird_Installer.ps1"

  ; Run the PowerShell script
  ExecWait 'powershell.exe -ExecutionPolicy Bypass -File "$TEMP\FirebirdInstaller\SM_Firebird_Installer.ps1"'

  ; Clean up extracted files
  Delete "$TEMP\FirebirdInstaller\Firebird-4.0.1.exe"
  Delete "$TEMP\FirebirdInstaller\SM_Firebird_Installer.ps1"

  ; Close the installer
  Quit
SectionEnd
