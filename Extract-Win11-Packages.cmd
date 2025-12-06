@echo off
:: Extract Windows 11 LTSC 2024 Store Packages
:: Run as Administrator

echo.
echo ============================================================
echo Windows 11 LTSC 2024 Store Package Extractor
echo ============================================================
echo.

:: Check if running as admin
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || goto :uac

:: Set source drive - Using LTSC 2024 IoT Edition
set "SOURCE=N:"
echo.
echo NOTE: If N: drive is not your Windows 11 LTSC ISO,
echo       edit this script and change line 16 to your correct drive letter
echo.
set "DEST=%~dp0packages-2024"

echo Source ISO: %SOURCE%
echo Destination: %DEST%
echo.

:: Check if source exists
if not exist "%SOURCE%\sources\install.wim" (
    echo Error: Cannot find install.wim on %SOURCE%
    echo Please mount your Windows 11 LTSC 2024 ISO first
    pause
    exit /b 1
)

:: Create destination folder
if not exist "%DEST%" mkdir "%DEST%"

echo Creating mount point...
if not exist "C:\mount" mkdir "C:\mount"

echo.
echo ============================================================
echo Mounting Windows 11 install.wim (this may take a minute)...
echo ============================================================
echo.

dism /Mount-Wim /WimFile:"%SOURCE%\sources\install.wim" /index:1 /MountDir:C:\mount /ReadOnly

if errorlevel 1 (
    echo.
    echo Error: Failed to mount WIM file
    echo Make sure you're running as Administrator
    pause
    rmdir C:\mount 2>nul
    exit /b 1
)

echo.
echo ============================================================
echo Extracting packages to %DEST%...
echo ============================================================
echo.

:: Extract VCLibs
echo Extracting VCLibs...
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.VCLibs.140.00*x64*.appx" "%DEST%\" /Y /I 2>nul
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.VCLibs.140.00*x86*.appx" "%DEST%\" /Y /I 2>nul

:: Extract .NET Native Framework
echo Extracting .NET Native Framework...
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Framework.2.2*x64*.appx" "%DEST%\" /Y /I 2>nul
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Framework.2.2*x86*.appx" "%DEST%\" /Y /I 2>nul

:: Extract .NET Native Runtime
echo Extracting .NET Native Runtime...
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Runtime.2.2*x64*.appx" "%DEST%\" /Y /I 2>nul
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Runtime.2.2*x86*.appx" "%DEST%\" /Y /I 2>nul

:: Extract UI.Xaml (Windows 11 specific)
echo Extracting UI.Xaml...
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.UI.Xaml.2.8*x64*.appx" "%DEST%\" /Y /I 2>nul
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.UI.Xaml.2.8*x86*.appx" "%DEST%\" /Y /I 2>nul

echo.
echo ============================================================
echo Unmounting WIM file...
echo ============================================================
echo.

dism /Unmount-Wim /MountDir:C:\mount /Discard
rmdir C:\mount

echo.
echo ============================================================
echo Extraction Complete!
echo ============================================================
echo.
echo Dependencies extracted to: %DEST%
echo.
echo Next steps:
echo 1. Download the main Store apps from https://store.rg-adguard.net/
echo    - Microsoft.WindowsStore (ProductId: 9WZDNCRFJBMP)
echo    - Microsoft.StorePurchaseApp (ProductId: 9NBLGGH4TS44)
echo    - Microsoft.DesktopAppInstaller (ProductId: 9NBLGGH4NNS1)
echo    - Microsoft.XboxIdentityProvider (ProductId: 9WZDNCRD1HKW)
echo.
echo 2. Place the downloaded .AppxBundle and .xml files in packages-2024\
echo.
echo 3. Run Add-Store.cmd as Administrator
echo.
echo ============================================================
echo.
pause
exit /b 0

:uac
echo.
echo ============================================================
echo Error: Administrator privileges required
echo ============================================================
echo.
echo Please run this script as Administrator:
echo 1. Right-click Extract-Win11-Packages.cmd
echo 2. Select "Run as administrator"
echo.
pause
exit /b 1