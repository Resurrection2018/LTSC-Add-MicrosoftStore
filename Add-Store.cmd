@echo off
:: Detect Windows build number for version-specific package selection
:: Method 1: Try using wmic (most reliable)
for /f "tokens=2 delims==" %%i in ('wmic os get BuildNumber /value 2^>nul') do set "build=%%i"

:: Method 2: If wmic failed, try registry
if not defined build (
    for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber 2^>nul ^| findstr CurrentBuildNumber') do set "build=%%i"
)

:: Method 3: If registry failed, try ver command parsing
if not defined build (
    for /f "tokens=3" %%i in ('ver ^| findstr /i "Version"') do set "fullver=%%i"
    set "fullver=%fullver:~0,-1%"
    for /f "tokens=3 delims=." %%j in ("%fullver%") do set "build=%%j"
)

:: Determine Windows version and set package directory
if "%build%"=="17763" (
    set "pkgdir=packages-2019"
    set "winver=LTSC 2019"
) else if "%build%"=="19044" (
    set "pkgdir=packages-2021"
    set "winver=LTSC 2021"
) else if "%build%"=="19045" (
    set "pkgdir=packages-2021"
    set "winver=LTSC 2021"
) else if "%build%"=="26100" (
    set "pkgdir=packages-2024"
    set "winver=LTSC 2024"
) else (
    set "pkgdir=."
    set "winver=Unknown"
)

:: Minimum version check (Windows 10 1709 / Build 16299)
for /f "tokens=6 delims=[]. " %%G in ('ver') do if %%G lss 16299 goto :version
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || goto :uac
setlocal enableextensions
if /i "%PROCESSOR_ARCHITECTURE%" equ "AMD64" (set "arch=x64") else (set "arch=x86")
cd /d "%~dp0"

echo.
echo ============================================================
echo Windows Build: %build% (%winver%)
echo Package Directory: %pkgdir%
echo Architecture: %arch%
echo ============================================================
echo.

:: Check if running from package directory or need to look in subdirectory
if exist "%pkgdir%\*WindowsStore*.msixbundle" (
    set "pkgpath=%pkgdir%\"
) else if exist "%pkgdir%\*WindowsStore*.appxbundle" (
    set "pkgpath=%pkgdir%\"
) else if exist "*WindowsStore*.msixbundle" (
    set "pkgpath="
) else if exist "*WindowsStore*.appxbundle" (
    set "pkgpath="
) else (
    goto :nofiles
)

if not exist "%pkgpath%*WindowsStore*.msixbundle" if not exist "%pkgpath%*WindowsStore*.appxbundle" goto :nofiles
if not exist "%pkgpath%*WindowsStore*.xml" goto :nofiles

for /f %%i in ('dir /b "%pkgpath%*WindowsStore*.msixbundle" 2^>nul') do set "Store=%pkgpath%%%i"
if not defined Store for /f %%i in ('dir /b "%pkgpath%*WindowsStore*.appxbundle" 2^>nul') do set "Store=%pkgpath%%%i"
for /f %%i in ('dir /b "%pkgpath%*NET.Native.Framework*.appx" 2^>nul ^| find /i "x64"') do set "Framework6X64=%pkgpath%%%i"
for /f %%i in ('dir /b "%pkgpath%*NET.Native.Framework*.appx" 2^>nul ^| find /i "x86"') do set "Framework6X86=%pkgpath%%%i"
for /f %%i in ('dir /b "%pkgpath%*NET.Native.Runtime*.appx" 2^>nul ^| find /i "x64"') do set "Runtime6X64=%pkgpath%%%i"
for /f %%i in ('dir /b "%pkgpath%*NET.Native.Runtime*.appx" 2^>nul ^| find /i "x86"') do set "Runtime6X86=%pkgpath%%%i"
for /f %%i in ('dir /b "%pkgpath%*VCLibs*140*.appx" 2^>nul ^| find /i "x64"') do set "VCLibsX64=%pkgpath%%%i"
for /f %%i in ('dir /b "%pkgpath%*VCLibs*140*.appx" 2^>nul ^| find /i "x86"') do set "VCLibsX86=%pkgpath%%%i"

if exist "%pkgpath%*StorePurchaseApp*.xml" (
for /f %%i in ('dir /b "%pkgpath%*StorePurchaseApp*.appxbundle" 2^>nul') do set "PurchaseApp=%pkgpath%%%i"
if not defined PurchaseApp for /f %%i in ('dir /b "%pkgpath%*StorePurchaseApp*.msixbundle" 2^>nul') do set "PurchaseApp=%pkgpath%%%i"
)
if exist "%pkgpath%*DesktopAppInstaller*.xml" (
for /f %%i in ('dir /b "%pkgpath%*DesktopAppInstaller*.msixbundle" 2^>nul') do set "AppInstaller=%pkgpath%%%i"
if not defined AppInstaller for /f %%i in ('dir /b "%pkgpath%*DesktopAppInstaller*.appxbundle" 2^>nul') do set "AppInstaller=%pkgpath%%%i"
)
if exist "%pkgpath%*XboxIdentityProvider*.xml" (
for /f %%i in ('dir /b "%pkgpath%*XboxIdentityProvider*.appxbundle" 2^>nul') do set "XboxIdentity=%pkgpath%%%i"
if not defined XboxIdentity for /f %%i in ('dir /b "%pkgpath%*XboxIdentityProvider*.eappxbundle" 2^>nul') do set "XboxIdentity=%pkgpath%%%i"
if not defined XboxIdentity for /f %%i in ('dir /b "%pkgpath%*XboxIdentityProvider*.msixbundle" 2^>nul') do set "XboxIdentity=%pkgpath%%%i"
)

if /i %arch%==x64 (
set "DepStore=%VCLibsX64%,%VCLibsX86%,%Framework6X64%,%Framework6X86%,%Runtime6X64%,%Runtime6X86%"
set "DepPurchase=%VCLibsX64%,%VCLibsX86%,%Framework6X64%,%Framework6X86%,%Runtime6X64%,%Runtime6X86%"
set "DepXbox=%VCLibsX64%,%VCLibsX86%,%Framework6X64%,%Framework6X86%,%Runtime6X64%,%Runtime6X86%"
set "DepInstaller=%VCLibsX64%,%VCLibsX86%"
) else (
set "DepStore=%VCLibsX86%,%Framework6X86%,%Runtime6X86%"
set "DepPurchase=%VCLibsX86%,%Framework6X86%,%Runtime6X86%"
set "DepXbox=%VCLibsX86%,%Framework6X86%,%Runtime6X86%"
set "DepInstaller=%VCLibsX86%"
)

for %%i in (%DepStore%) do (
if not exist "%%i" goto :nofiles
)

set "PScommand=PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass"

echo.
echo ============================================================
echo Adding Microsoft Store
echo ============================================================
echo.
1>nul 2>nul %PScommand% Add-AppxProvisionedPackage -Online -PackagePath %Store% -DependencyPackagePath %DepStore% -LicensePath %pkgpath%Microsoft.WindowsStore_8wekyb3d8bbwe.xml
for %%i in (%DepStore%) do (
%PScommand% Add-AppxPackage -Path %%i
)
%PScommand% Add-AppxPackage -Path %Store%

if defined PurchaseApp (
echo.
echo ============================================================
echo Adding Store Purchase App
echo ============================================================
echo.
1>nul 2>nul %PScommand% Add-AppxProvisionedPackage -Online -PackagePath %PurchaseApp% -DependencyPackagePath %DepPurchase% -LicensePath %pkgpath%Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml
%PScommand% Add-AppxPackage -Path %PurchaseApp%
)
if defined AppInstaller (
echo.
echo ============================================================
echo Adding App Installer
echo ============================================================
echo.
1>nul 2>nul %PScommand% Add-AppxProvisionedPackage -Online -PackagePath %AppInstaller% -DependencyPackagePath %DepInstaller% -LicensePath %pkgpath%Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml
%PScommand% Add-AppxPackage -Path %AppInstaller%
)
if defined XboxIdentity (
echo.
echo ============================================================
echo Adding Xbox Identity Provider
echo ============================================================
echo.
1>nul 2>nul %PScommand% Add-AppxProvisionedPackage -Online -PackagePath %XboxIdentity% -DependencyPackagePath %DepXbox% -LicensePath %pkgpath%Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml
%PScommand% Add-AppxPackage -Path %XboxIdentity%
)
goto :fin

:uac
echo.
echo ============================================================
echo Error: Run the script as administrator
echo ============================================================
echo.
echo.
echo Press any key to Exit
pause >nul
exit

:version
echo.
echo ============================================================
echo Error: Unsupported Windows Version
echo This pack requires Windows 10 version 1709 (Build 16299) or later
echo Your build: %build%
echo ============================================================
echo.
echo.
echo Press any key to Exit
pause >nul
exit

:nofiles
echo.
echo ============================================================
echo Error: Required files are missing
echo.
echo Looking for packages in: %pkgpath%
echo Windows version detected: %winver% (Build %build%)
echo.
echo Please ensure the correct packages are in the appropriate directory:
echo - For LTSC 2019: packages-2019\ folder or current directory
echo - For LTSC 2021: packages-2021\ folder or current directory
echo - For LTSC 2024: packages-2024\ folder or current directory
echo ============================================================
echo.
echo.
echo Press any key to Exit
pause >nul
exit

:fin
echo.
echo ============================================================
echo Done
echo ============================================================
echo.
echo Press any Key to Exit.
pause >nul
exit
