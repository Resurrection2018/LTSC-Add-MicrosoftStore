# Package Acquisition Guide

This guide explains how to obtain the required AppX packages for installing Microsoft Store on Windows 10 LTSC editions.

## Legal Notice

⚠️ **Important:** Only download and use packages that match your licensed Windows installation. These instructions are for personal backup and installation purposes only.

## Package Sources

### Method 1: Extract from Windows ISO (Recommended)

1. **Download Windows 10 ISO** from Microsoft Volume Licensing Service Center (VLSC) or MSDN
   - For LTSC 2019: Windows 10 Enterprise LTSC 2019 ISO
   - For LTSC 2021: Windows 10 Enterprise LTSC 2021 ISO

2. **Mount the ISO** 
   - Right-click ISO file → Mount

3. **Extract Feature on Demand (FOD) packages**
   - Navigate to `sources\` folder in mounted ISO
   - Look for FOD ISO or CAB files
   - Extract required AppX bundles

### Method 2: UUP Dump

UUP Dump allows downloading official Microsoft update files.

1. Visit: https://uupdump.net/
2. Search for your Windows version:
   - LTSC 2019: Search "17763"
   - LTSC 2021: Search "19044" or "19045"
3. Select the appropriate build
4. Download the cumulative update or feature updates
5. Extract AppX bundles from the downloaded files

### Method 3: MDL Forums

The My Digital Life forums have community-shared package links.

1. Visit: https://forums.mydigitallife.net/
2. Search for "LTSC Add Store" threads
3. Look for verified community members' posts
4. Download from shared links (verify checksums)

### Method 4: Store.rg-adguard.net

This service provides direct links to Microsoft's servers.

1. Visit: https://store.rg-adguard.net/
2. Select "ProductId" type
3. Enter package ID (for specific packages)
4. Select "Slow" ring for most stable versions
5. Download required files

## Required Package List

### For LTSC 2019 (Build 17763)

#### Core Components (Required)
- **Microsoft.WindowsStore**
  - `Microsoft.WindowsStore_11809.1001.713.0_neutral_~_8wekyb3d8bbwe.AppxBundle`
  - `Microsoft.WindowsStore_8wekyb3d8bbwe.xml`

#### Dependencies (Required)
- **VCLibs 14.0**
  - `Microsoft.VCLibs.140.00_14.0.26706.0_x64__8wekyb3d8bbwe.Appx`
  - `Microsoft.VCLibs.140.00_14.0.26706.0_x86__8wekyb3d8bbwe.Appx`

- **.NET Native Framework 1.6**
  - `Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x64__8wekyb3d8bbwe.Appx`
  - `Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x86__8wekyb3d8bbwe.Appx`

- **.NET Native Runtime 1.6**
  - `Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x64__8wekyb3d8bbwe.Appx`
  - `Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x86__8wekyb3d8bbwe.Appx`

#### Optional Components
- **Desktop App Installer** (includes winget)
  - `Microsoft.DesktopAppInstaller_1.6.29000.1000_neutral_~_8wekyb3d8bbwe.AppxBundle`
  - `Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml`

- **Store Purchase App**
  - `Microsoft.StorePurchaseApp_11808.1001.413.0_neutral_~_8wekyb3d8bbwe.AppxBundle`
  - `Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml`

- **Xbox Identity Provider**
  - `Microsoft.XboxIdentityProvider_12.45.6001.0_neutral_~_8wekyb3d8bbwe.AppxBundle`
  - `Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml`

### For LTSC 2021 (Build 19044/19045)

#### Core Components (Required)
- **Microsoft.WindowsStore** (newer version)
  - `Microsoft.WindowsStore_12xxxxx.x.x.x_neutral_~_8wekyb3d8bbwe.AppxBundle`
  - `Microsoft.WindowsStore_8wekyb3d8bbwe.xml`

#### Dependencies (Required - Updated Versions)
- **VCLibs 14.0** (newer)
  - `Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe.Appx` (or newer)
  - `Microsoft.VCLibs.140.00_14.0.30704.0_x86__8wekyb3d8bbwe.Appx` (or newer)

- **.NET Native Framework 2.2** (or newer)
  - `Microsoft.NET.Native.Framework.2.2_2.2.xxxxx.0_x64__8wekyb3d8bbwe.Appx`
  - `Microsoft.NET.Native.Framework.2.2_2.2.xxxxx.0_x86__8wekyb3d8bbwe.Appx`

- **.NET Native Runtime 2.2** (or newer)
  - `Microsoft.NET.Native.Runtime.2.2_2.2.xxxxx.0_x64__8wekyb3d8bbwe.Appx`
  - `Microsoft.NET.Native.Runtime.2.2_2.2.xxxxx.0_x86__8wekyb3d8bbwe.Appx`

#### Optional Components (Latest Versions)
- **Desktop App Installer** (with winget)
  - Latest version from Windows 11 or Windows 10 22H2
  
- **Store Purchase App**
  - Latest compatible version

- **Xbox Identity Provider**
  - Latest compatible version

## Package Verification

### Verify Package Integrity

1. **Check file sizes** - Compare with known good packages
2. **Verify digital signatures**
   ```powershell
   Get-AuthenticodeSignature "path\to\package.appxbundle"
   ```
   - Should show "Valid" status
   - Signed by "Microsoft Corporation"

3. **Check package information**
   ```powershell
   Get-AppxPackageManifest -Package "path\to\package.appxbundle"
   ```

### Version Compatibility

- LTSC 2019 packages may work on LTSC 2021, but not guaranteed
- LTSC 2021 packages likely won't work on LTSC 2019
- Always use packages from same Windows version when possible

## Directory Structure

After downloading, organize files as follows:

```
LTSC-Add-MicrosoftStore-master/
│
├── Add-Store.cmd
├── README.md
├── UPGRADE_PLAN.md
├── PACKAGE_GUIDE.md
│
├── packages-2019/              # LTSC 2019 packages
│   ├── Microsoft.WindowsStore_*.appxbundle
│   ├── Microsoft.WindowsStore_*.xml
│   ├── Microsoft.VCLibs.140.00_*_x64_*.Appx
│   ├── Microsoft.VCLibs.140.00_*_x86_*.Appx
│   ├── Microsoft.NET.Native.Framework.1.6_*_x64_*.Appx
│   ├── Microsoft.NET.Native.Framework.1.6_*_x86_*.Appx
│   ├── Microsoft.NET.Native.Runtime.1.6_*_x64_*.Appx
│   ├── Microsoft.NET.Native.Runtime.1.6_*_x86_*.Appx
│   ├── Microsoft.DesktopAppInstaller_*.appxbundle (optional)
│   ├── Microsoft.DesktopAppInstaller_*.xml (optional)
│   ├── Microsoft.StorePurchaseApp_*.appxbundle (optional)
│   ├── Microsoft.StorePurchaseApp_*.xml (optional)
│   ├── Microsoft.XboxIdentityProvider_*.appxbundle (optional)
│   └── Microsoft.XboxIdentityProvider_*.xml (optional)
│
└── packages-2021/              # LTSC 2021 packages
    ├── Microsoft.WindowsStore_*.appxbundle
    ├── Microsoft.WindowsStore_*.xml
    ├── Microsoft.VCLibs.140.00_*_x64_*.Appx (newer)
    ├── Microsoft.VCLibs.140.00_*_x86_*.Appx (newer)
    ├── Microsoft.NET.Native.Framework.2.2_*_x64_*.Appx
    ├── Microsoft.NET.Native.Framework.2.2_*_x86_*.Appx
    ├── Microsoft.NET.Native.Runtime.2.2_*_x64_*.Appx
    ├── Microsoft.NET.Native.Runtime.2.2_*_x86_*.Appx
    ├── Microsoft.DesktopAppInstaller_*.appxbundle (optional)
    ├── Microsoft.DesktopAppInstaller_*.xml (optional)
    ├── Microsoft.StorePurchaseApp_*.appxbundle (optional)
    ├── Microsoft.StorePurchaseApp_*.xml (optional)
    ├── Microsoft.XboxIdentityProvider_*.appxbundle (optional)
    └── Microsoft.XboxIdentityProvider_*.xml (optional)
```

**Alternative:** You can also place LTSC 2019 packages directly in the root directory (backward compatible with original setup).

## Troubleshooting Package Issues

### Package Won't Install
- Verify digital signature
- Check Windows version compatibility
- Ensure all dependencies are present
- Try running DISM health check:
  ```
  DISM /Online /Cleanup-Image /RestoreHealth
  ```

### Wrong Package Version
- Use packages from your exact Windows build when possible
- Check package version info:
  ```powershell
  Get-AppxPackage -Path "package.appxbundle" | Select Name, Version
  ```

### Missing Dependencies
- The script will show which files are missing
- Download missing dependencies from same source
- Ensure both x64 and x86 versions for dependencies

## Quick Reference

### Package Version Matrix

| Component | LTSC 2019 | LTSC 2021 | Notes |
|-----------|-----------|-----------|-------|
| Store | 11809.1001.x | 12xxx or later | Core component |
| VCLibs | 14.0.26706.0 | 14.0.30704.0+ | Both architectures |
| .NET Framework | 1.6.24903.0 | 2.2.x | Both architectures |
| .NET Runtime | 1.6.24903.0 | 2.2.x | Both architectures |
| App Installer | 1.6.29000.x | Latest | Optional, includes winget |

### Minimum Required Files (No Optional Components)

**LTSC 2019:** 10 files (1 bundle + 1 XML + 8 dependency .appx)  
**LTSC 2021:** 10 files (1 bundle + 1 XML + 8 dependency .appx)

---

**Last Updated:** 2025-11-30  
**For:** Personal use with licensed Windows installations