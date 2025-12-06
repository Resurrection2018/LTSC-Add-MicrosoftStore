# Cleanup Guide for packages-2021 Folder

## Files You Can SAFELY DELETE

### ❌ ZIP Archives (2 files - ~500 MB)
These are source/backup files no longer needed:
```
19044.1147_x86_en-us_multi_1afe6346_convert_virtual.zip
19044.1147_x86_en-us_multi_1afe6346_convert.zip
```
**Why delete:** Already extracted, taking up space

### ❌ Duplicate Store Bundles (2 files - ~50 MB)
You have 3 Store bundles but only need one:
```
Microsoft.WindowsStore_12107.1001.15.70_neutral_~_8wekyb3d8bbwe.EAppxBundle
Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe.Msixbundle
```
**Keep:** `Microsoft.WindowsStore_12107.1001.15.0_neutral_~_8wekyb3d8bbwe.AppxBundle`
**Why delete:** The installer only uses one, and 12107 version is ideal for LTSC 2021

### ❌ BlockMap File (1 file - <1 MB)
```
Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe.BlockMap
```
**Why delete:** Not used by the installer, metadata only

### ❌ Temp Extraction Folder
```
temp_extract\
```
**Why delete:** Temporary files from ZIP extraction, no longer needed

---

## Total Space to Recover: ~550 MB

---

## Files You Must KEEP (16 files)

### ✅ Required Core Files (8 files)
```
Microsoft.WindowsStore_12107.1001.15.0_neutral_~_8wekyb3d8bbwe.AppxBundle
Microsoft.WindowsStore_8wekyb3d8bbwe.xml
Microsoft.VCLibs.140.00_14.0.33519.0_x64__8wekyb3d8bbwe.Appx
Microsoft.VCLibs.140.00_14.0.33519.0_x86__8wekyb3d8bbwe.Appx
Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe.Appx
Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x86__8wekyb3d8bbwe.Appx
Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe.Appx
Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x86__8wekyb3d8bbwe.Appx
```

### ✅ Optional Components (6 files)
```
Microsoft.DesktopAppInstaller_2025.926.104.0_neutral_~_8wekyb3d8bbwe.Msixbundle
Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml
Microsoft.StorePurchaseApp_22510.1401.1.0_neutral_~_8wekyb3d8bbwe.AppxBundle
Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml
Microsoft.XboxIdentityProvider_2017.523.613.1070_neutral_~_8wekyb3d8bbwe.EAppxBundle
Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml
```

### ✅ Bonus Dependency (1 file)
```
Microsoft.UI.Xaml.2.8_8.2501.31001.0_x86__8wekyb3d8bbwe.Appx
```
**Keep:** Might be needed for some apps

---

## Cleanup Commands

### Option 1: Manual Delete (Safest)
Open File Explorer and delete these files/folders:
1. `19044.1147_x86_en-us_multi_1afe6346_convert_virtual.zip`
2. `19044.1147_x86_en-us_multi_1afe6346_convert.zip`
3. `Microsoft.WindowsStore_12107.1001.15.70_neutral_~_8wekyb3d8bbwe.EAppxBundle`
4. `Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe.Msixbundle`
5. `Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe.BlockMap`
6. `temp_extract` folder

### Option 2: Command Line (Faster)
Open Command Prompt as Administrator and run:

```batch
cd C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\packages-2021

REM Delete ZIP archives
del "19044.1147_x86_en-us_multi_1afe6346_convert_virtual.zip"
del "19044.1147_x86_en-us_multi_1afe6346_convert.zip"

REM Delete duplicate Store bundles
del "Microsoft.WindowsStore_12107.1001.15.70_neutral_~_8wekyb3d8bbwe.EAppxBundle"
del "Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe.Msixbundle"

REM Delete BlockMap file
del "Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe.BlockMap"

REM Delete temp folder
rmdir /s /q temp_extract

echo Cleanup complete!
dir
```

---

## After Cleanup - Verify You Still Have Everything

Run this command to count files:
```batch
cd C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\packages-2021
dir *.appx* /b | find /c ".appx"
dir *.xml /b | find /c ".xml"
```

**Expected results:**
- `.appx*` files: Should show at least 15
- `.xml` files: Should show 4

**Or simply count:**
```batch
dir packages-2021 /b | find /c /v ""
```
Should show approximately 16 files (down from ~20+)

---

## Summary

### Before Cleanup:
- ~20+ files
- ~1 GB total size

### After Cleanup:
- 16 essential files
- ~450 MB total size
- ~550 MB saved

### Result:
- ✅ All required packages intact
- ✅ All optional packages intact
- ✅ No duplicate files
- ✅ No temporary files
- ✅ Ready for installation

---

## Safety Note

**DO NOT delete** any files unless listed above. The 16 files listed in "Files You Must KEEP" are all necessary for 100% complete installation.

If you accidentally delete something important:
1. Check your Recycle Bin
2. Or re-download from store.rg-adguard.net
3. Or copy from packages-2019 (for XML files only)

---

**Created:** 2025-12-02  
**Purpose:** Optimize packages-2021 folder before installation