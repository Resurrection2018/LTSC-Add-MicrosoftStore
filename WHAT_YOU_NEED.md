# What You Still Need for Windows 11 LTSC 2024

## ✅ What You Have
- Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe(1).Msixbundle

## ❌ What's Still Missing

### 1. REQUIRED: Windows Store License File
Download from https://store.rg-adguard.net/
- ProductId: `9WZDNCRFJBMP`
- Download: `Microsoft.WindowsStore_8wekyb3d8bbwe.xml`
- Place in: `packages-2024\`

### 2. REQUIRED: Dependency Files (from Windows 11 ISO)

**Option A: Run Extract-From-Win11-24H2.cmd (Recommended)**
- Right-click → Run as Administrator
- It will extract all these files automatically

**Option B: Manual extraction from your ISO**
You need these exact files from the Windows 11 ISO:

```
Microsoft.UI.Xaml.2.8*x64*.appx
Microsoft.UI.Xaml.2.8*x86*.appx
Microsoft.VCLibs.140.00*x64*.appx
Microsoft.VCLibs.140.00*x86*.appx
Microsoft.NET.Native.Framework.2.2*x64*.appx
Microsoft.NET.Native.Framework.2.2*x86*.appx
Microsoft.NET.Native.Runtime.2.2*x64*.appx
Microsoft.NET.Native.Runtime.2.2*x86*.appx
```

### 3. OPTIONAL: Additional Apps

**Desktop App Installer (WinGet):**
- ProductId: `9NBLGGH4NNS1`
- Download: .msixbundle + .xml

**Store Purchase App:**
- ProductId: `9NBLGGH4TS44`
- Download: .appxbundle + .xml

**Xbox Identity:**
- ProductId: `9WZDNCRD1HKW`
- Download: .appxbundle + .xml

## 🚀 Quick Setup Steps

1. **Get the Store XML license:**
   - Go to https://store.rg-adguard.net/
   - Select "ProductId"
   - Enter: `9WZDNCRFJBMP`
   - Download `Microsoft.WindowsStore_8wekyb3d8bbwe.xml`
   - Save to `packages-2024\`

2. **Extract dependencies:**
   - Right-click `Extract-From-Win11-24H2.cmd`
   - Run as Administrator
   - Wait for it to finish

3. **Run the installer:**
   - Right-click `Add-Store.cmd`
   - Run as Administrator
   - Follow prompts

## 📁 Minimum Required Files

At minimum, you need these in `packages-2024\`:

```
Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe(1).Msixbundle ✅ (you have this)
Microsoft.WindowsStore_8wekyb3d8bbwe.xml ❌ (need to download)
Microsoft.UI.Xaml.2.8_x64__8wekyb3d8bbwe.appx ❌ (extract from ISO)
Microsoft.UI.Xaml.2.8_x86__8wekyb3d8bbwe.appx ❌ (extract from ISO)
Microsoft.VCLibs.140.00_x64__8wekyb3d8bbwe.appx ❌ (extract from ISO)
Microsoft.VCLibs.140.00_x86__8wekyb3d8bbwe.appx ❌ (extract from ISO)
Microsoft.NET.Native.Framework.2.2_x64__8wekyb3d8bbwe.appx ❌ (extract from ISO)
Microsoft.NET.Native.Framework.2.2_x86__8wekyb3d8bbwe.appx ❌ (extract from ISO)
Microsoft.NET.Native.Runtime.2.2_x64__8wekyb3d8bbwe.appx ❌ (extract from ISO)
Microsoft.NET.Native.Runtime.2.2_x86__8wekyb3d8bbwe.appx ❌ (extract from ISO)
```

Total: 10 files minimum (1 you have, 9 more needed)

## ⚡ Fastest Method

1. Run `Extract-From-Win11-24H2.cmd` as Admin (gets 8 dependency files)
2. Download Store XML from store.rg-adguard.net (gets 1 license file)
3. Run `Add-Store.cmd` as Admin
4. Done!