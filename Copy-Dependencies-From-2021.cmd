@echo off
:: Copy compatible dependencies from packages-2021 to packages-2024
:: Windows 11 LTSC 2024 can use the same .NET Native and VCLibs as Windows 10 LTSC 2021

echo.
echo ============================================================
echo Copy Dependencies from LTSC 2021 to LTSC 2024
echo ============================================================
echo.

cd /d "%~dp0"

:: Check if packages-2021 exists
if not exist "packages-2021\" (
    echo Error: packages-2021 folder not found!
    echo.
    echo This script copies compatible dependencies from your
    echo working Windows 10 LTSC 2021 packages to packages-2024.
    echo.
    pause
    exit /b 1
)

:: Create packages-2024 if it doesn't exist
if not exist "packages-2024\" mkdir packages-2024

echo Copying .NET Native Framework 2.2...
copy /Y "packages-2021\Microsoft.NET.Native.Framework.2.2*x64*.Appx" "packages-2024\" 2>nul
copy /Y "packages-2021\Microsoft.NET.Native.Framework.2.2*x86*.Appx" "packages-2024\" 2>nul

echo Copying .NET Native Runtime 2.2...
copy /Y "packages-2021\Microsoft.NET.Native.Runtime.2.2*x64*.Appx" "packages-2024\" 2>nul
copy /Y "packages-2021\Microsoft.NET.Native.Runtime.2.2*x86*.Appx" "packages-2024\" 2>nul

echo Copying VCLibs 14.0...
copy /Y "packages-2021\Microsoft.VCLibs.140.00*x64*.Appx" "packages-2024\" 2>nul
copy /Y "packages-2021\Microsoft.VCLibs.140.00*x86*.Appx" "packages-2024\" 2>nul

echo.
echo ============================================================
echo Copy Complete!
echo ============================================================
echo.

:: Check what was copied
dir /b "packages-2024\*.Appx" 2>nul | find /c /v "" > nul
if errorlevel 1 (
    echo WARNING: No .Appx files found in packages-2024!
    echo Check if files exist in packages-2021.
) else (
    echo Files successfully copied to packages-2024:
    dir /b "packages-2024\*.Appx"
)

echo.
echo ============================================================
echo What You Still Need:
echo ============================================================
echo.
echo 1. UI.Xaml 2.8 (Windows 11 specific dependency)
echo    Download from: https://github.com/microsoft/microsoft-ui-xaml/releases
echo    Get both: x64 and x86 .appx files
echo.
echo 2. Store XML License
echo    Visit: https://store.rg-adguard.net/
echo    ProductId: 9WZDNCRFJBMP
echo    Download: Microsoft.WindowsStore_8wekyb3d8bbwe.xml
echo.
echo 3. Place both UI.Xaml files and the XML in packages-2024\
echo.
echo 4. Run Add-Store.cmd as Administrator
echo.
echo See ALTERNATIVE_DOWNLOADS.md for detailed download instructions.
echo.
echo ============================================================
pause