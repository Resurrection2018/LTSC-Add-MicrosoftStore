# How to Get Microsoft Store Packages for LTSC 2021

Your Windows 10 IoT Enterprise LTSC 2021 ISO doesn't include Store packages directly (this is normal). Here's how to get them.

---

## ⚠️ Important Discovery

The LTSC 2021 ISO at `L:\` contains:
- ✅ Windows installation files
- ✅ Store replacement manifest (shows where Store should go)
- ❌ **No actual Store AppX packages**

This is expected - LTSC editions require separate Store package downloads.

---

## 🎯 Best Methods to Get LTSC 2021 Store Packages

### Method 1: UUP Dump (Recommended - Most Reliable)

**Step 1: Find Your Exact Build**
```powershell
# Check the build number in your ISO
DISM /Get-WimInfo /WimFile:L:\sources\install.wim /Index:1
```

Look for the build number (should be 19044.xxxx or 19045.xxxx)

**Step 2: Download from UUP Dump**
1. Go to: https://uupdump.net/
2. In the search box, type: `19044` or `19045`
3. Select the build that matches your ISO
4. Look for "Feature Update" or "Cumulative Update"
5. Download the update package
6. Extract the AppX bundles from the downloaded files

**What you'll find:**
- Microsoft.WindowsStore bundle
- Microsoft.VCLibs (updated version)
- .NET Native Framework & Runtime (version 2.x)
- Optional: DesktopAppInstaller, StorePurchaseApp, XboxIdentityProvider

---

### Method 2: Store.rg-adguard.net (Alternative)

This provides direct links to Microsoft's servers.

**Step 1: Visit the Site**
https://store.rg-adguard.net/

**Step 2: Get Microsoft Store**
1. Select: "ProductId"
2. Enter: `9WZDNCRFJBMP` (Microsoft Store product ID)
3. Select: "Slow" ring
4. Click the search/checkmark button
5. Download the `.appxbundle` file and select your architecture

**Step 3: Get Dependencies**

For VCLibs:
- Search for: `Microsoft.VCLibs.140.00`
- Download both x64 and x86 versions

For .NET Native:
- Search for: `Microsoft.NET.Native.Framework.2.2`
- Search for: `Microsoft.NET.Native.Runtime.2.2`
- Download both x64 and x86 versions of each

**Step 4: Get Optional Components**
- Desktop App Installer: `9NBLGGH4NNS1`
- Purchase App: Search by name
- Xbox Identity: Search by name

---

### Method 3: From Another LTSC 2021 Installation

If you have access to a working LTSC 2021 system with Store installed:

```powershell
# Export installed Store package
Get-AppxPackage *WindowsStore* | Select-Object PackageFullName, InstallLocation

# Navigate to the installation location
cd "C:\Program Files\WindowsApps\Microsoft.WindowsStore_..."

# However, these files are protected and can't be easily copied
# Better to use Methods 1 or 2
```

---

### Method 4: Online Installation (Easiest but requires Windows 11)

If you have a Windows 11 system or newer Windows 10:

```powershell
# Download Store from Microsoft servers
# This only works on certain Windows versions
wsreset -i
```

---

## 📦 What Packages You Need

### Minimum Required (10 files)

**Core:**
1. `Microsoft.WindowsStore_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
2. `Microsoft.WindowsStore_8wekyb3d8bbwe.xml` (license)

**VCLibs 14.0 (newer than LTSC 2019):**
3. `Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe.Appx` (or newer)
4. `Microsoft.VCLibs.140.00_14.0.30704.0_x86__8wekyb3d8bbwe.Appx`

**.NET Native Framework 2.2:**
5. `Microsoft.NET.Native.Framework.2.2_*_x64__8wekyb3d8bbwe.Appx`
6. `Microsoft.NET.Native.Framework.2.2_*_x86__8wekyb3d8bbwe.Appx`

**.NET Native Runtime 2.2:**
7. `Microsoft.NET.Native.Runtime.2.2_*_x64__8wekyb3d8bbwe.Appx`
8. `Microsoft.NET.Native.Runtime.2.2_*_x86__8wekyb3d8bbwe.Appx`

### Recommended Optional

**Desktop App Installer (includes winget):**
- `Microsoft.DesktopAppInstaller_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
- `Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml`

**Store Purchase App:**
- `Microsoft.StorePurchaseApp_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
- `Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml`

**Xbox Identity Provider:**
- `Microsoft.XboxIdentityProvider_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
- `Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml`

---

## 🔧 After Downloading

### Step 1: Create the Folder
```batch
cd C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master
mkdir packages-2021
```

### Step 2: Place All Files
Copy all downloaded `.AppxBundle`, `.Appx`, and `.xml` files to:
```
C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\packages-2021\
```

### Step 3: Verify You Have Everything
```batch
dir packages-2021
```

Should show at least 10 files (8 for minimum, more with optional components).

### Step 4: Run the Installer
```batch
Add-Store.cmd
```

The script will automatically:
- Detect you're on LTSC 2021
- Use packages from `packages-2021\` folder
- Install everything

---

## 💡 Quick Start Commands

### Using UUP Dump (after downloading)
```batch
mkdir packages-2021
xcopy "%USERPROFILE%\Downloads\UUP_extract\*.AppxBundle" packages-2021\ /Y
xcopy "%USERPROFILE%\Downloads\UUP_extract\*.Appx" packages-2021\ /Y
xcopy "%USERPROFILE%\Downloads\UUP_extract\*.xml" packages-2021\ /Y
```

### Using store.rg-adguard.net downloads
```batch
mkdir packages-2021
move %USERPROFILE%\Downloads\Microsoft.WindowsStore*.AppxBundle packages-2021\
move %USERPROFILE%\Downloads\Microsoft.VCLibs*.Appx packages-2021\
move %USERPROFILE%\Downloads\Microsoft.NET*.Appx packages-2021\
```

---

## ❓ FAQ

**Q: Why aren't the packages on the ISO?**
A: LTSC editions (Long-Term Servicing Channel) don't include Store by default. It's optional and requires separate installation.

**Q: Are these methods legal?**
A: Yes, if you have a valid LTSC 2021 license. You're downloading official Microsoft packages.

**Q: Which method is fastest?**
A: store.rg-adguard.net is fastest for individual packages. UUP Dump is best for getting everything at once.

**Q: Do I need all the optional components?**
A: No. Minimum is just Store + dependencies (10 files). But I recommend DesktopAppInstaller for winget.

**Q: What if I can't find a specific package?**
A: The core Store and VCLibs are essential. .NET Native is important. Optional components can be added later.

**Q: Can I use Windows 11 packages on LTSC 2021?**
A: Maybe, but not recommended. Get LTSC 2021-era packages (from 2021-2022) for best compatibility.

---

## 🎯 Recommended Next Steps

1. **Choose Method 1 (UUP Dump)** for easiest complete package set
2. Download all required files
3. Place in `packages-2021\` folder
4. Follow [`WALKTHROUGH.md`](WALKTHROUGH.md:1) from Step 4 onwards
5. Run the installer!

---

## 📞 Need Help?

Stuck on any step? Let me know:
- Which method you're trying
- What you downloaded
- Any error messages

I'll help you get the packages you need!

---

**Last Updated:** 2025-11-30  
**For:** Windows 10 IoT Enterprise LTSC 2021  
**ISO Location:** `C:\Users\Bladez\Desktop\iso\`