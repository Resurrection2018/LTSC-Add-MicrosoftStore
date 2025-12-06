@echo off
:: Remove Microsoft Store and Related Packages from Windows 10 LTSC
:: This script removes all packages installed by Add-Store.cmd

%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || goto :uac
setlocal enableextensions

echo.
echo ============================================================
echo Remove Microsoft Store from Windows 10 LTSC
echo ============================================================
echo.
echo WARNING: This will remove:
echo - Microsoft Store
echo - Desktop App Installer (winget)
echo - Store Purchase App
echo - Xbox Identity Provider
echo.
echo Press Ctrl+C to cancel, or
pause

set "PScommand=PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass"

echo.
echo ============================================================
echo Removing Microsoft Store Packages...
echo ============================================================
echo.

:: Remove Microsoft Store
echo Removing Microsoft Store...
%PScommand% Get-AppxPackage *WindowsStore* | Remove-AppxPackage
%PScommand% Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like "*WindowsStore*"} | Remove-AppxProvisionedPackage -Online

:: Remove Desktop App Installer (winget)
echo Removing Desktop App Installer (winget)...
%PScommand% Get-AppxPackage *DesktopAppInstaller* | Remove-AppxPackage
%PScommand% Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like "*DesktopAppInstaller*"} | Remove-AppxProvisionedPackage -Online

:: Remove Store Purchase App
echo Removing Store Purchase App...
%PScommand% Get-AppxPackage *StorePurchaseApp* | Remove-AppxPackage
%PScommand% Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like "*StorePurchaseApp*"} | Remove-AppxProvisionedPackage -Online

:: Remove Xbox Identity Provider
echo Removing Xbox Identity Provider...
%PScommand% Get-AppxPackage *XboxIdentityProvider* | Remove-AppxPackage
%PScommand% Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like "*XboxIdentityProvider*"} | Remove-AppxProvisionedPackage -Online

echo.
echo ============================================================
echo Removal Complete!
echo ============================================================
echo.
echo Note: Dependencies (VCLibs, .NET Native) are shared with
echo other apps and have NOT been removed for system stability.
echo.
echo A system reboot is recommended.
echo.
pause
goto :eof

:uac
echo.
echo ============================================================
echo Error: Run this script as Administrator
echo ============================================================
echo.
pause
exit

:eof