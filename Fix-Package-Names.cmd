@echo off
:: Fix duplicate package filenames in packages-2024

echo.
echo ============================================================
echo Cleaning up package filenames in packages-2024
echo ============================================================
echo.

cd /d "%~dp0packages-2024"

:: Rename files with (1) in the name
if exist "Microsoft.UI.Xaml.2.8_8.2501.31001.0_x86__8wekyb3d8bbwe(1).Appx" (
    echo Renaming UI.Xaml x86 file...
    ren "Microsoft.UI.Xaml.2.8_8.2501.31001.0_x86__8wekyb3d8bbwe(1).Appx" "Microsoft.UI.Xaml.2.8_8.2501.31001.0_x86__8wekyb3d8bbwe.Appx"
)

if exist "Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe(1).Msixbundle" (
    echo Renaming WindowsStore file...
    ren "Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe(1).Msixbundle" "Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe.Msixbundle"
)

echo.
echo ============================================================
echo Filenames fixed!
echo ============================================================
echo.
echo Current files in packages-2024:
dir /b *.Appx *.Msixbundle *.xml 2>nul
echo.
echo ============================================================
echo What you still need:
echo ============================================================
echo.
echo REQUIRED: Store XML License
echo   Visit: https://store.rg-adguard.net/
echo   ProductId: 9WZDNCRFJBMP
echo   Download: Microsoft.WindowsStore_8wekyb3d8bbwe.xml
echo   Save to: packages-2024\
echo.
echo After downloading the XML file, you'll have all 10 required files!
echo Then run Add-Store.cmd as Administrator.
echo.
pause