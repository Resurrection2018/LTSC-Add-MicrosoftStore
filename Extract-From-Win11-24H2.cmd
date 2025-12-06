@echo off
:: Extract Windows 11 Store Packages from 24H2 ISO
:: Compatible with Windows 11 LTSC 2024 (Build 26100)
:: Run as Administrator

echo.
echo ============================================================
echo Windows 11 24H2 Store Package Extractor
echo For Windows 11 LTSC 2024 (Build 26100)
echo ============================================================
echo.

:: Check if running as admin
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || goto :uac

:: ISO path
set "ISO_PATH=J:\win10downloads\Win11_24H2_English_x64.iso"
set "DEST=%~dp0packages-2024"

echo ISO: %ISO_PATH%
echo Destination: %DEST%
echo.

:: Check if ISO exists
if not exist "%ISO_PATH%" (
    echo Error: Cannot find ISO at %ISO_PATH%
    echo.
    echo Please verify:
    echo 1. The ISO file exists
    echo 2. The path is correct
    pause
    exit /b 1
)

:: Create destination folder
if not exist "%DEST%" mkdir "%DEST%"

echo.
echo ============================================================
echo Step 1: Mounting Windows 11 24H2 ISO...
echo ============================================================
echo.

:: Mount ISO using PowerShell
for /f "tokens=*" %%D in ('powershell -Command "$mount = Mount-DiskImage -ImagePath '%ISO_PATH%' -PassThru; $mount | Get-Volume | Select-Object -ExpandProperty DriveLetter"') do set "MOUNT_DRIVE=%%D"

if not defined MOUNT_DRIVE (
    echo Error: Failed to mount ISO
    pause
    exit /b 1
)

set "SOURCE=%MOUNT_DRIVE%:"
echo Mounted to: %SOURCE%
timeout /t 2 >nul

echo.
echo ============================================================
echo Step 2: Mounting install.wim (this may take a minute)...
echo ============================================================
echo.

:: Create mount point
if not exist "C:\mount" mkdir "C:\mount"

:: Mount WIM
dism /Mount-Wim /WimFile:"%SOURCE%\sources\install.wim" /index:1 /MountDir:C:\mount /ReadOnly

if errorlevel 1 (
    echo.
    echo Error: Failed to mount WIM file
    powershell -Command "Dismount-DiskImage -ImagePath '%ISO_PATH%'" >nul 2>&1
    rmdir C:\mount 2>nul
    pause
    exit /b 1
)

echo.
echo ============================================================
echo Step 3: Extracting packages to %DEST%...
echo ============================================================
echo.

:: Extract VCLibs
echo [1/4] Extracting VCLibs...
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.VCLibs.140.00*x64*.appx" "%DEST%\" /Y /I 2>nul
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.VCLibs.140.00*x86*.appx" "%DEST%\" /Y /I 2>nul

:: Extract .NET Native Framework
echo [2/4] Extracting .NET Native Framework...
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Framework.2.2*x64*.appx" "%DEST%\" /Y /I 2>nul
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Framework.2.2*x86*.appx" "%DEST%\" /Y /I 2>nul

:: Extract .NET Native Runtime
echo [3/4] Extracting .NET Native Runtime...
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Runtime.2.2*x64*.appx" "%DEST%\" /Y /I 2>nul
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Runtime.2.2*x86*.appx" "%DEST%\" /Y /I 2>nul

:: Extract UI.Xaml (Windows 11 specific)
echo [4/4] Extracting UI.Xaml...
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.UI.Xaml.2.8*x64*.appx" "%DEST%\" /Y /I 2>nul
xcopy "C:\mount\Program Files\WindowsApps\Microsoft.UI.Xaml.2.8*x86*.appx" "%DEST%\" /Y /I 2>nul

echo.
echo ============================================================
echo Step 4: Cleanup...
echo ============================================================
echo.

echo Unmounting WIM file...
dism /Unmount-Wim /MountDir:C:\mount /Discard
rmdir C:\mount

echo Dismounting ISO...
powershell -Command "Dismount-DiskImage -ImagePath '%ISO_PATH%'" >nul 2>&1
timeout /t 2 >nul

echo.
echo ============================================================
echo Extraction Complete!
echo ============================================================
echo.
echo Dependencies extracted to: %DEST%
echo.

:: List extracted files
echo Extracted files:
dir /b "%DEST%\*.appx" 2>nul | find /c /v "" > nul
if errorlevel 1 (
    echo WARNING: No .appx files found!
    echo Check if extraction was successful.
) else (
    dir /b "%DEST%\*.appx"
)

echo.
echo ============================================================
echo Next Steps:
echo ============================================================
echo.
echo 1. Download the main Store apps from https://store.rg-adguard.net/
echo    (Select "ProductId" and paste the ID below)
echo.
echo    Required downloads:
echo    - Microsoft.WindowsStore          ProductId: 9WZDNCRFJBMP
echo    - Microsoft.StorePurchaseApp      ProductId: 9NBLGGH4TS44
echo    - Microsoft.DesktopAppInstaller   ProductId: 9NBLGGH4NNS1
echo    - Microsoft.XboxIdentityProvider  ProductId: 9WZDNCRD1HKW
echo.
echo    For each app, download BOTH:
echo    - The .AppxBundle or .Msixbundle file
echo    - The .xml license file
echo.
echo 2. Move downloaded files to: %DEST%\
echo.
echo 3. Run Add-Store.cmd as Administrator on Windows 11 LTSC 2024
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
echo 1. Right-click Extract-From-Win11-24H2.cmd
echo 2. Select "Run as administrator"
echo.
pause
exit /b 1