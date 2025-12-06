# Extracting Microsoft Store Packages from Your ISO Files

You have these ISOs in `C:\Users\Bladez\Desktop\iso\`:
- ✅ Windows 10 IoT Enterprise LTSC 2021
- ✅ Windows 11 IoT Enterprise LTSC 2024

Let's extract the Microsoft Store packages you need!

---

## For Windows 10 LTSC 2021 (The One You Need Now)

### Step 1: Mount the ISO (2 minutes)

1. Navigate to `C:\Users\Bladez\Desktop\iso\`
2. Right-click: `en-us_windows_10_iot_enterprise_ltsc_2021_x64_dvd_257ad90f.iso`
3. Click "Mount"
4. Windows will assign it a drive letter (like D:, E:, etc.)
5. **Note the drive letter:** _____ (you'll need this)

### Step 2: Locate the Packages (5 minutes)

The packages are usually in one of these locations on the mounted ISO:

**Option A: In the sources folder**
```
D:\sources\
```

**Option B: In FOD (Features on Demand) folders**
```
D:\sources\FOD\
D:\LanguagesAndOptionalFeatures\
```

Let me help you find them. Open PowerShell and run:

```powershell
# Replace D: with your actual drive letter
Get-ChildItem -Path D:\ -Recurse -Include "*WindowsStore*.appx*" -ErrorAction SilentlyContinue
```

This will search the entire ISO for Store-related packages.

### Step 3: What You're Looking For

You need these specific files:

**Core Package:**
- `Microsoft.WindowsStore_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
- `Microsoft.WindowsStore_8wekyb3d8bbwe.xml` (license file)

**Dependencies (all x64 AND x86 versions):**
- `Microsoft.VCLibs.140.00_14.0.*_x64__8wekyb3d8bbwe.Appx`
- `Microsoft.VCLibs.140.00_14.0.*_x86__8wekyb3d8bbwe.Appx`
- `Microsoft.NET.Native.Framework.2.*_x64__8wekyb3d8bbwe.Appx`
- `Microsoft.NET.Native.Framework.2.*_x86__8wekyb3d8bbwe.Appx`
- `Microsoft.NET.Native.Runtime.2.*_x64__8wekyb3d8bbwe.Appx`
- `Microsoft.NET.Native.Runtime.2.*_x86__8wekyb3d8bbwe.Appx`

**Optional (but recommended):**
- `Microsoft.DesktopAppInstaller_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
- `Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml`
- `Microsoft.StorePurchaseApp_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
- `Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml`
- `Microsoft.XboxIdentityProvider_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
- `Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml`

### Step 4: Copy the Packages (5 minutes)

#### Option A: Using File Explorer (Easier)

1. Create destination folder:
   - Navigate to `C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\`
   - Create new folder: `packages-2021`

2. Copy the files:
   - Browse the mounted ISO (drive D: or whatever it is)
   - Find the packages (use the PowerShell search from Step 2)
   - Select all the files you need
   - Copy them (Ctrl+C)
   - Navigate to `packages-2021\` folder
   - Paste (Ctrl+V)

#### Option B: Using PowerShell (If You Know the Path)

```powershell
# Replace D: with your drive letter and adjust paths as needed
$isoPath = "D:\sources\"
$destPath = "C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\packages-2021\"

# Create destination if it doesn't exist
New-Item -ItemType Directory -Path $destPath -Force

# Copy Store packages
Copy-Item "$isoPath\*WindowsStore*.appxbundle" -Destination $destPath
Copy-Item "$isoPath\*WindowsStore*.xml" -Destination $destPath

# Copy VCLibs
Copy-Item "$isoPath\*VCLibs*.appx" -Destination $destPath

# Copy .NET Native packages
Copy-Item "$isoPath\*NET.Native*.appx" -Destination $destPath

# Copy optional packages (if available)
Copy-Item "$isoPath\*DesktopAppInstaller*.appx*" -Destination $destPath -ErrorAction SilentlyContinue
Copy-Item "$isoPath\*StorePurchaseApp*.appx*" -Destination $destPath -ErrorAction SilentlyContinue
Copy-Item "$isoPath\*XboxIdentityProvider*.appx*" -Destination $destPath -ErrorAction SilentlyContinue
```

### Step 5: Alternative - Extract from Windows Image (If packages aren't directly accessible)

If you can't find the packages in the sources folder, they might be inside the Windows image file.

```powershell
# This extracts packages from the Windows image
$wimFile = "D:\sources\install.wim"  # or install.esd
$mountPath = "C:\Mount"
$index = 1  # Usually index 1 for LTSC

# Create mount point
New-Item -ItemType Directory -Path $mountPath -Force

# Mount the image (requires admin)
DISM /Mount-Wim /WimFile:$wimFile /Index:$index /MountDir:$mountPath /ReadOnly

# Look for packages
Get-ChildItem -Path "$mountPath\Windows\ServicingPackages" -Filter "*Store*.cab"
Get-ChildItem -Path "$mountPath\Windows\System32\appraiser" -Filter "*.xml"

# Copy what you find, then unmount
DISM /Unmount-Wim /MountDir:$mountPath /Discard
```

### Step 6: Verify What You Got

Check your `packages-2021\` folder should have:

Minimum files (10):
```
✓ 1 WindowsStore .AppxBundle
✓ 1 WindowsStore .xml
✓ 2 VCLibs .Appx files (x64 and x86)
✓ 2 NET.Native.Framework .Appx files (x64 and x86)
✓ 2 NET.Native.Runtime .Appx files (x64 and x86)
```

With optional components (up to 20+ files):
```
✓ DesktopAppInstaller bundle + xml
✓ StorePurchaseApp bundle + xml
✓ XboxIdentityProvider bundle + xml
```

### Step 7: Unmount the ISO

1. Open File Explorer
2. Right-click the mounted ISO drive
3. Click "Eject"

---

## Alternative: If Packages Aren't in the ISO

### Method 1: Use UUP Dump

Since you have the ISO, you can get the exact build number and use UUP Dump:

1. Mount the ISO
2. Check the build: `DISM /Get-WimInfo /WimFile:D:\sources\install.wim /Index:1`
3. Note the build number (should be 19044 or 19045)
4. Go to https://uupdump.net/
5. Search for that exact build
6. Download the cumulative update
7. Extract AppX bundles from the update

### Method 2: Use DISM to Extract from Your ISO

If the Store packages are part of the Windows 10 LTSC 2021 Features on Demand:

```powershell
# Get available features
DISM /Online /Get-Capabilities

# Install Store capability (this downloads from Windows Update)
DISM /Online /Add-Capability /CapabilityName:Microsoft.Windows.Store~~~~0.0.1.0

# Or extract from ISO mounted as D:
DISM /Image:C:\ /Add-Capability /CapabilityName:Microsoft.Windows.Store~~~~0.0.1.0 /Source:D:\sources\FOD /LimitAccess
```

---

## Quick Commands Reference

### Search for Store packages on mounted ISO:
```powershell
Get-ChildItem -Path D:\ -Recurse -Include "*WindowsStore*","*VCLibs*","*NET.Native*" -ErrorAction SilentlyContinue | Select-Object FullName
```

### Create destination folder:
```batch
mkdir C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\packages-2021
```

### Check what you have:
```batch
dir C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\packages-2021
```

---

## After Extraction

Once you have the packages in `packages-2021\`:

1. Follow [`WALKTHROUGH.md`](WALKTHROUGH.md:1) starting at Step 4
2. Or just run [`Add-Store.cmd`](Add-Store.cmd:1) as Administrator
3. The script will auto-detect LTSC 2021 and use the new packages!

---

## Troubleshooting

**Q: I can't find the packages on the ISO**
A: They might be:
- Inside the install.wim file (use DISM to mount)
- In a separate FOD ISO/folder
- Need to be downloaded separately from Windows Update

**Q: The PowerShell search returns nothing**
A: Try these locations manually:
- `D:\sources\`
- `D:\sources\FOD\`
- `D:\LanguagesAndOptionalFeatures\`
- Inside `install.wim` (needs mounting)

**Q: I only found some of the packages**
A: You can mix sources:
- Extract what's available from ISO
- Download missing ones from UUP Dump or store.rg-adguard.net

**Q: Do I need the Windows 11 ISO?**
A: Not for LTSC 2021. Keep it for future reference if you ever upgrade.

---

**Need help extracting?** Just tell me what you found (or didn't find) on the ISO and I'll help you get what you need!

**Last Updated:** 2025-11-30