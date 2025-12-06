# Getting Windows 11 LTSC 2024 Packages

This guide will help you extract the required Microsoft Store packages from a Windows 11 LTSC 2024 ISO.

## Prerequisites

- Windows 11 LTSC 2024 ISO (Build 26100)
- 7-Zip or similar ISO extraction tool
- Administrator privileges

## Required Packages

For Windows 11 LTSC 2024, you need:

### Core Dependencies (Required)
1. **Microsoft.VCLibs.140.00** (x64 and x86)
2. **Microsoft.NET.Native.Framework.2.2** (x64 and x86)
3. **Microsoft.NET.Native.Runtime.2.2** (x64 and x86)
4. **Microsoft.UI.Xaml.2.8** (x64 and x86)

### Main Applications (Required)
1. **Microsoft.WindowsStore** (.AppxBundle + .xml)
2. **Microsoft.StorePurchaseApp** (.AppxBundle + .xml)
3. **Microsoft.DesktopAppInstaller** (.Msixbundle + .xml)
4. **Microsoft.XboxIdentityProvider** (.AppxBundle + .xml)

## Extraction Steps

### Step 1: Mount or Extract the ISO

**Option A: Mount the ISO (Recommended)**
1. Right-click the Windows 11 LTSC 2024 ISO
2. Select "Mount"
3. Note the drive letter (e.g., D:)

**Option B: Extract with 7-Zip**
1. Right-click the ISO
2. Select 7-Zip → Extract to folder
3. Navigate to the extracted folder

### Step 2: Locate the Packages

The packages are located in the ISO at:
```
\sources\install.wim
```

You need to mount this WIM file to access the packages.

### Step 3: Mount the WIM File

1. Open PowerShell as Administrator
2. Create a mount directory:
   ```powershell
   mkdir C:\mount
   ```

3. Mount the WIM file (adjust drive letter):
   ```powershell
   # If ISO is mounted to D:
   dism /Mount-Wim /WimFile:"D:\sources\install.wim" /index:1 /MountDir:C:\mount /ReadOnly
   ```

### Step 4: Extract the Packages

The packages are located at:
```
C:\mount\Windows\servicing\Packages\
```

Copy all files matching these patterns to your `packages-2024\` folder:

```powershell
# Navigate to the project directory
cd "C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\packages-2024"

# Copy VCLibs
copy "C:\mount\Program Files\WindowsApps\Microsoft.VCLibs.140.00*.appx" .

# Copy .NET Native Framework
copy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Framework.2.2*.appx" .

# Copy .NET Native Runtime
copy "C:\mount\Program Files\WindowsApps\Microsoft.NET.Native.Runtime.2.2*.appx" .

# Copy UI.Xaml
copy "C:\mount\Program Files\WindowsApps\Microsoft.UI.Xaml.2.8*.appx" .
```

### Step 5: Download Store Apps from Microsoft

The main Store applications need to be downloaded separately:

1. **Microsoft Store**
   - Visit: https://store.rg-adguard.net/
   - Select "ProductId" and enter: `9WZDNCRFJBMP`
   - Download the latest `.AppxBundle` and `.xml` files

2. **Store Purchase App**
   - ProductId: `9NBLGGH4TS44`
   - Download `.AppxBundle` and `.xml` files

3. **Desktop App Installer (WinGet)**
   - ProductId: `9NBLGGH4NNS1`
   - Download `.Msixbundle` and `.xml` files

4. **Xbox Identity Provider**
   - ProductId: `9WZDNCRD1HKW`
   - Download `.AppxBundle` and `.xml` files

### Step 6: Verify Package Names

Your `packages-2024` folder should contain files like:

```
Microsoft.VCLibs.140.00_14.0.xxxxx.0_x64__8wekyb3d8bbwe.Appx
Microsoft.VCLibs.140.00_14.0.xxxxx.0_x86__8wekyb3d8bbwe.Appx
Microsoft.NET.Native.Framework.2.2_2.2.xxxxx.0_x64__8wekyb3d8bbwe.Appx
Microsoft.NET.Native.Framework.2.2_2.2.xxxxx.0_x86__8wekyb3d8bbwe.Appx
Microsoft.NET.Native.Runtime.2.2_2.2.xxxxx.0_x64__8wekyb3d8bbwe.Appx
Microsoft.NET.Native.Runtime.2.2_2.2.xxxxx.0_x86__8wekyb3d8bbwe.Appx
Microsoft.UI.Xaml.2.8_x.xxxx.xxxxx.0_x64__8wekyb3d8bbwe.Appx
Microsoft.UI.Xaml.2.8_x.xxxx.xxxxx.0_x86__8wekyb3d8bbwe.Appx
Microsoft.WindowsStore_xxxxx.xxxx.xx.0_neutral_~_8wekyb3d8bbwe.AppxBundle
Microsoft.WindowsStore_8wekyb3d8bbwe.xml
Microsoft.StorePurchaseApp_xxxxx.xxxx.x.0_neutral_~_8wekyb3d8bbwe.AppxBundle
Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml
Microsoft.DesktopAppInstaller_xxxx.xxx.xxx.0_neutral_~_8wekyb3d8bbwe.Msixbundle
Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml
Microsoft.XboxIdentityProvider_xxxx.xxx.xxx.xxxx_neutral_~_8wekyb3d8bbwe.AppxBundle
Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml
```

### Step 7: Unmount the WIM

After copying all packages:

```powershell
dism /Unmount-Wim /MountDir:C:\mount /Discard
rmdir C:\mount
```

## Alternative: UUP Dump Method

You can also download packages from UUP Dump:

1. Visit https://uupdump.net/
2. Search for "Windows 11 Enterprise LTSC 2024"
3. Select build 26100.x
4. Download the UUP files
5. Extract packages from the downloaded files

## Installation

Once all packages are in the `packages-2024\` folder:

1. Run `Add-Store.cmd` as Administrator
2. The script will automatically detect Windows 11 LTSC 2024 (Build 26100)
3. Follow the on-screen instructions

## Troubleshooting

**Issue**: Cannot find packages in mounted WIM
- **Solution**: Try different WIM index (use `/index:2` or `/index:3`)

**Issue**: Missing UI.Xaml package
- **Solution**: Download from Microsoft Store using store.rg-adguard.net

**Issue**: Script fails with dependency errors
- **Solution**: Ensure all dependency files (VCLibs, .NET Native) are present

## Notes

- Windows 11 LTSC 2024 uses newer package versions than Windows 10 LTSC
- Some packages may require internet connection for activation
- Keep the original ISO in case you need to re-extract packages

## See Also

- [EXTRACT_FROM_ISO.md](EXTRACT_FROM_ISO.md) - General ISO extraction guide
- [PACKAGE_GUIDE.md](PACKAGE_GUIDE.md) - Complete package reference
- [README.md](README.md) - Main documentation