# Migration Guide - Organizing Existing Packages

This guide helps you organize your existing LTSC 2019 packages into the new dual-version structure.

## Current Setup

Your existing files (LTSC 2019 packages) are in the root directory:
```
LTSC-Add-MicrosoftStore-master/
├── Add-Store.cmd
├── Microsoft.WindowsStore_11809.1001.713.0_neutral_~_8wekyb3d8bbwe.AppxBundle
├── Microsoft.WindowsStore_8wekyb3d8bbwe.xml
├── Microsoft.VCLibs.140.00_14.0.26706.0_x64__8wekyb3d8bbwe.Appx
├── Microsoft.VCLibs.140.00_14.0.26706.0_x86__8wekyb3d8bbwe.Appx
├── Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x64__8wekyb3d8bbwe.Appx
├── Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x86__8wekyb3d8bbwe.Appx
├── Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x64__8wekyb3d8bbwe.Appx
├── Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x86__8wekyb3d8bbwe.Appx
├── Microsoft.DesktopAppInstaller_1.6.29000.1000_neutral_~_8wekyb3d8bbwe.AppxBundle
├── Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml
├── Microsoft.StorePurchaseApp_11808.1001.413.0_neutral_~_8wekyb3d8bbwe.AppxBundle
├── Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml
├── Microsoft.XboxIdentityProvider_12.45.6001.0_neutral_~_8wekyb3d8bbwe.AppxBundle
├── Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml
└── README.md
```

## Option 1: Keep Existing Structure (Recommended for LTSC 2019 Only)

**If you only use LTSC 2019**, you can keep files in the root directory. The updated script still supports this for backward compatibility.

**Action Required:** None - your setup will continue to work as-is.

## Option 2: Organize into New Structure (Recommended for Both Versions)

**If you plan to support both LTSC 2019 and LTSC 2021**, organize packages into separate folders.

### Step-by-Step Instructions

#### 1. Create Package Directories

Open Command Prompt or PowerShell in your project directory:
```batch
mkdir packages-2019
mkdir packages-2021
```

#### 2. Move LTSC 2019 Packages

**Option A: Using File Explorer**
1. Select all `.AppxBundle` and `.Appx` files
2. Select all `.xml` files
3. Cut (Ctrl+X) and paste into `packages-2019\` folder

**Option B: Using Command Line**
```batch
move *.AppxBundle packages-2019\
move *.Appx packages-2019\
move *.xml packages-2021\
```

**Option C: Using PowerShell**
```powershell
Get-ChildItem -Path . -Include *.AppxBundle,*.Appx,*.xml -File | Move-Item -Destination .\packages-2019\
```

#### 3. Verify Organization

Check that your structure now looks like:
```
LTSC-Add-MicrosoftStore-master/
├── Add-Store.cmd
├── README.md
├── UPGRADE_PLAN.md
├── PACKAGE_GUIDE.md
├── TESTING_CHECKLIST.md
├── MIGRATION_GUIDE.md
│
└── packages-2019/
    ├── Microsoft.WindowsStore_11809.1001.713.0_neutral_~_8wekyb3d8bbwe.AppxBundle
    ├── Microsoft.WindowsStore_8wekyb3d8bbwe.xml
    ├── Microsoft.VCLibs.140.00_14.0.26706.0_x64__8wekyb3d8bbwe.Appx
    ├── Microsoft.VCLibs.140.00_14.0.26706.0_x86__8wekyb3d8bbwe.Appx
    ├── Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x64__8wekyb3d8bbwe.Appx
    ├── Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x86__8wekyb3d8bbwe.Appx
    ├── Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x64__8wekyb3d8bbwe.Appx
    ├── Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x86__8wekyb3d8bbwe.Appx
    ├── Microsoft.DesktopAppInstaller_1.6.29000.1000_neutral_~_8wekyb3d8bbwe.AppxBundle
    ├── Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml
    ├── Microsoft.StorePurchaseApp_11808.1001.413.0_neutral_~_8wekyb3d8bbwe.AppxBundle
    ├── Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml
    ├── Microsoft.XboxIdentityProvider_12.45.6001.0_neutral_~_8wekyb3d8bbwe.AppxBundle
    └── Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml
```

#### 4. Test Installation

Run [`Add-Store.cmd`](Add-Store.cmd:1) as Administrator to verify the new structure works:
- It should detect your Windows version
- Show "Package Directory: packages-2019"
- Install successfully

## Adding LTSC 2021 Support

### 1. Acquire LTSC 2021 Packages

Follow the [`PACKAGE_GUIDE.md`](PACKAGE_GUIDE.md:1) to obtain:
- Newer Microsoft Store bundle
- VCLibs 14.0.30704.0 or newer
- .NET Native Framework 2.2+
- .NET Native Runtime 2.2+
- Updated optional components

### 2. Place in packages-2021 Folder

Copy all LTSC 2021 packages to `packages-2021\`:
```
packages-2021/
├── Microsoft.WindowsStore_<newer_version>.AppxBundle
├── Microsoft.WindowsStore_8wekyb3d8bbwe.xml
├── Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe.Appx
├── Microsoft.VCLibs.140.00_14.0.30704.0_x86__8wekyb3d8bbwe.Appx
├── Microsoft.NET.Native.Framework.2.2_<version>_x64__8wekyb3d8bbwe.Appx
├── Microsoft.NET.Native.Framework.2.2_<version>_x86__8wekyb3d8bbwe.Appx
├── Microsoft.NET.Native.Runtime.2.2_<version>_x64__8wekyb3d8bbwe.Appx
├── Microsoft.NET.Native.Runtime.2.2_<version>_x86__8wekyb3d8bbwe.Appx
└── ... (optional components)
```

### 3. Test on LTSC 2021

If you have access to an LTSC 2021 system:
- Run [`Add-Store.cmd`](Add-Store.cmd:1) as Administrator
- Verify it detects "LTSC 2021"
- Verify it uses "packages-2021" directory
- Confirm successful installation

## Rollback Plan

If you encounter issues with the new structure:

### Revert to Original Layout
```batch
move packages-2019\* .
rmdir packages-2019
rmdir packages-2021
```

The script will still work with packages in the root directory for LTSC 2019.

## Quick Copy-Paste Commands

### Create Directories
```batch
mkdir packages-2019
mkdir packages-2021
```

### Move All Packages to 2019 Folder
```batch
move Microsoft.WindowsStore_*.* packages-2019\
move Microsoft.VCLibs.*.* packages-2019\
move Microsoft.NET.*.* packages-2019\
move Microsoft.DesktopAppInstaller*.* packages-2019\
move Microsoft.StorePurchaseApp*.* packages-2019\
move Microsoft.XboxIdentityProvider*.* packages-2019\
```

### Verify Move
```batch
dir packages-2019\
```

Should show 14 files (if all optional components included).

## Verification Checklist

After migration:
- [ ] `packages-2019` folder exists
- [ ] All `.AppxBundle` files moved
- [ ] All `.Appx` files moved
- [ ] All `.xml` files moved
- [ ] Root directory only has script and docs
- [ ] Test installation runs successfully
- [ ] Store installs and functions correctly

## Next Steps

1. ✅ Organize existing LTSC 2019 packages
2. ⏳ Acquire LTSC 2021 packages (when needed)
3. ⏳ Place LTSC 2021 packages in `packages-2021\`
4. ⏳ Test on both versions (if available)
5. ✅ Keep documentation updated

## Support

For issues during migration:
- Check [`README.md`](README.md:1) for basic troubleshooting
- Review [`TESTING_CHECKLIST.md`](TESTING_CHECKLIST.md:1) for verification steps
- Consult [`PACKAGE_GUIDE.md`](PACKAGE_GUIDE.md:1) for package details

---

**Migration Version:** 1.0  
**Last Updated:** 2025-11-30  
**Target:** Personal LTSC installations