# Download Windows 11 LTSC 2024 Dependencies

Since the packages aren't in the ISO, download them directly from Microsoft using store.rg-adguard.net.

## 🎯 Quick Download Guide

Visit: **https://store.rg-adguard.net/**

For each package below:
1. Select **"ProductId"** in the dropdown
2. Paste the ProductId
3. Click search (✓)
4. Download the **latest version** for the specified architecture

---

## 📦 Required Downloads

### 1. Microsoft.VCLibs.140.00

**ProductId:** `9P8B7VKKC051`

Download files:
- `Microsoft.VCLibs.140.00_*_x64__8wekyb3d8bbwe.appx`
- `Microsoft.VCLibs.140.00_*_x86__8wekyb3d8bbwe.appx`

*Look for version 14.0.33xxx.0 or newer*

---

### 2. Microsoft.UI.Xaml.2.8

**ProductId:** `9NBLGGH5VG65`

Download files:
- `Microsoft.UI.Xaml.2.8_*_x64__8wekyb3d8bbwe.appx`
- `Microsoft.UI.Xaml.2.8_*_x86__8wekyb3d8bbwe.appx`

*Look for version 8.xxx.xxxxx.0 or newer*

---

### 3. Microsoft.NET.Native.Framework.2.2

**ProductId:** `9P2MBKS1Q8V3`

Download files:
- `Microsoft.NET.Native.Framework.2.2_*_x64__8wekyb3d8bbwe.appx`
- `Microsoft.NET.Native.Framework.2.2_*_x86__8wekyb3d8bbwe.appx`

*Look for version 2.2.29xxx.0 or newer*

---

### 4. Microsoft.NET.Native.Runtime.2.2

**ProductId:** `9NXQXXM31F77`

Download files:
- `Microsoft.NET.Native.Runtime.2.2_*_x64__8wekyb3d8bbwe.appx`
- `Microsoft.NET.Native.Runtime.2.2_*_x86__8wekyb3d8bbwe.appx`

*Look for version 2.2.28xxx.0 or newer*

---

### 5. Microsoft.WindowsStore (Main App)

**ProductId:** `9WZDNCRFJBMP`

Download files:
- `Microsoft.WindowsStore_*_neutral_~_8wekyb3d8bbwe.msixbundle` ✅ You already have this!
- `Microsoft.WindowsStore_8wekyb3d8bbwe.xml` ⬅️ **Download this XML license**

---

## 🎁 Optional (Recommended)

### Microsoft.DesktopAppInstaller (WinGet)

**ProductId:** `9NBLGGH4NNS1`

Download files:
- `Microsoft.DesktopAppInstaller_*_neutral_~_8wekyb3d8bbwe.msixbundle`
- `Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml`

---

### Microsoft.StorePurchaseApp

**ProductId:** `9NBLGGH4TS44`

Download files:
- `Microsoft.StorePurchaseApp_*_neutral_~_8wekyb3d8bbwe.appxbundle`
- `Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml`

---

### Microsoft.XboxIdentityProvider

**ProductId:** `9WZDNCRD1HKW`

Download files:
- `Microsoft.XboxIdentityProvider_*_neutral_~_8wekyb3d8bbwe.appxbundle`
- `Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml`

---

## 📋 Complete Checklist

Place all downloaded files in: `packages-2024\`

**Minimum Required (10 files):**
- [ ] Microsoft.VCLibs.140.00_x64__8wekyb3d8bbwe.appx
- [ ] Microsoft.VCLibs.140.00_x86__8wekyb3d8bbwe.appx
- [ ] Microsoft.UI.Xaml.2.8_x64__8wekyb3d8bbwe.appx
- [ ] Microsoft.UI.Xaml.2.8_x86__8wekyb3d8bbwe.appx
- [ ] Microsoft.NET.Native.Framework.2.2_x64__8wekyb3d8bbwe.appx
- [ ] Microsoft.NET.Native.Framework.2.2_x86__8wekyb3d8bbwe.appx
- [ ] Microsoft.NET.Native.Runtime.2.2_x64__8wekyb3d8bbwe.appx
- [ ] Microsoft.NET.Native.Runtime.2.2_x86__8wekyb3d8bbwe.appx
- [ ] Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe.msixbundle ✅
- [ ] Microsoft.WindowsStore_8wekyb3d8bbwe.xml

**Optional but Recommended (+6 files):**
- [ ] Microsoft.DesktopAppInstaller_neutral_~_8wekyb3d8bbwe.msixbundle
- [ ] Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml
- [ ] Microsoft.StorePurchaseApp_neutral_~_8wekyb3d8bbwe.appxbundle
- [ ] Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml
- [ ] Microsoft.XboxIdentityProvider_neutral_~_8wekyb3d8bbwe.appxbundle
- [ ] Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml

---

## 💡 Tips

1. **Select the RIGHT architecture files** - Both x64 AND x86 are required
2. **Download the LATEST versions** available on store.rg-adguard.net
3. **Don't download BlockMap files** - You only need .appx, .msixbundle, and .xml files
4. **Version numbers may vary** - That's okay, get the latest available

---

## ⚡ After Downloading

1. Place all files in `packages-2024\`
2. Run `Add-Store.cmd` as Administrator
3. Reboot after installation

---

## 🔍 Troubleshooting

**Can't find a package on store.rg-adguard.net?**
- Try searching with "URL (link)" instead of ProductId
- Use the full Store URL like: https://www.microsoft.com/store/productId/9P8B7VKKC051

**Wrong file types showing up?**
- Make sure you select the Windows 11 compatible versions
- x64 and x86 architecture files, NOT arm/arm64
- .appx or .msix formats (not .cab or .msi)

**Site is slow or timing out?**
- Try again later
- The site can be slow during peak hours
- Refresh the page and try searching again