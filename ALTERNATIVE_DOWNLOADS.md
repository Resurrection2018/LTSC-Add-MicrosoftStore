# Alternative Package Download Methods

The framework dependencies (VCLibs, .NET Native, UI.Xaml) aren't available via store.rg-adguard.net ProductIds. Use these alternative methods:

---

## ✅ Method 1: Download from Microsoft's CDN (Recommended)

### Microsoft.VCLibs.140.00

**Latest versions from Microsoft:**

**x64:**
```
https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx
```

**x86:**
```
https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx
```

Just paste these URLs in your browser - they redirect to the latest versions.

---

### Microsoft.UI.Xaml.2.8

Download from NuGet Gallery:
1. Visit: https://www.nuget.org/packages/Microsoft.UI.Xaml/
2. Download the latest 2.8.x version
3. Rename .nupkg to .zip
4. Extract the .appx files from: `tools\AppX\`

**OR use direct GitHub release:**
- https://github.com/microsoft/microsoft-ui-xaml/releases
- Download Microsoft.UI.Xaml.2.8_x64.appx
- Download Microsoft.UI.Xaml.2.8_x86.appx

---

### Microsoft.NET.Native.Framework.2.2 & Runtime.2.2

**These are harder to find individually. Better options:**

**Option A: Copy from Windows 10 LTSC 2021**
If you have packages-2021 working, these are the SAME versions:
```
Copy from packages-2021\ to packages-2024\:
- Microsoft.NET.Native.Framework.2.2_*_x64__8wekyb3d8bbwe.Appx
- Microsoft.NET.Native.Framework.2.2_*_x86__8wekyb3d8bbwe.Appx
- Microsoft.NET.Native.Runtime.2.2_*_x64__8wekyb3d8bbwe.Appx
- Microsoft.NET.Native.Runtime.2.2_*_x86__8wekyb3d8bbwe.Appx
```

**Option B: Extract from Windows 10 installation**
From any Windows 10 21H2+ system:
```
C:\Program Files\WindowsApps\Microsoft.NET.Native.Framework.2.2_*
C:\Program Files\WindowsApps\Microsoft.NET.Native.Runtime.2.2_*
```

---

## ✅ Method 2: Use Existing Windows 10 LTSC 2021 Packages

**Good news:** Windows 11 LTSC 2024 can use the SAME dependency versions as Windows 10 LTSC 2021!

### Copy from packages-2021 to packages-2024:

```cmd
copy "packages-2021\Microsoft.NET.Native.Framework.2.2_*_x64__8wekyb3d8bbwe.Appx" "packages-2024\"
copy "packages-2021\Microsoft.NET.Native.Framework.2.2_*_x86__8wekyb3d8bbwe.Appx" "packages-2024\"
copy "packages-2021\Microsoft.NET.Native.Runtime.2.2_*_x64__8wekyb3d8bbwe.Appx" "packages-2024\"
copy "packages-2021\Microsoft.NET.Native.Runtime.2.2_*_x86__8wekyb3d8bbwe.Appx" "packages-2024\"
copy "packages-2021\Microsoft.VCLibs.140.00_*_x64__8wekyb3d8bbwe.Appx" "packages-2024\"
copy "packages-2021\Microsoft.VCLibs.140.00_*_x86__8wekyb3d8bbwe.Appx" "packages-2024\"
```

Then you only need to download:
1. **UI.Xaml 2.8** (Windows 11 specific)
2. **Store XML license**

---

## ✅ Method 3: Download UI.Xaml from GitHub

### Microsoft.UI.Xaml.2.8

**Direct links from Microsoft's GitHub:**

Visit: https://github.com/microsoft/microsoft-ui-xaml/releases/tag/v2.8.6

Download:
- `Microsoft.UI.Xaml.2.8_x64.appx`
- `Microsoft.UI.Xaml.2.8_x86.appx`

**OR latest 2.8 version:**
- Browse: https://github.com/microsoft/microsoft-ui-xaml/releases
- Look for v2.8.x releases
- Download x64 and x86 .appx files

---

## 📋 Quick Setup Using Existing packages-2021

If you have working packages-2021 folder:

### Step 1: Copy shared dependencies
```cmd
cd C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master
copy packages-2021\Microsoft.NET.Native.*.Appx packages-2024\
copy packages-2021\Microsoft.VCLibs.*.Appx packages-2024\
```

### Step 2: Download Windows 11 specific packages

**UI.Xaml 2.8:**
- Download from: https://aka.ms/Microsoft.UI.Xaml.2.8.x64
- Download from: https://aka.ms/Microsoft.UI.Xaml.2.8.x86
- (If aka.ms links don't work, use GitHub method above)

**Store XML License:**
- Visit: https://store.rg-adguard.net/
- ProductId: `9WZDNCRFJBMP`
- Download: `Microsoft.WindowsStore_8wekyb3d8bbwe.xml`

### Step 3: Run installer
```cmd
Add-Store.cmd (as Administrator)
```

---

## 🎯 Recommended Approach

**Easiest method if you have packages-2021:**

1. Copy 6 files from packages-2021 to packages-2024 (.NET and VCLibs)
2. Download UI.Xaml 2.8 from GitHub: https://github.com/microsoft/microsoft-ui-xaml/releases
3. Download Store XML from store.rg-adguard.net (ProductId: 9WZDNCRFJBMP)
4. Run Add-Store.cmd

**Total additions needed:** 3 files (2 UI.Xaml + 1 XML)

---

## 📁 Final packages-2024 Structure

```
packages-2024\
├── Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe.Appx  [from 2021]
├── Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x86__8wekyb3d8bbwe.Appx  [from 2021]
├── Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe.Appx    [from 2021]
├── Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x86__8wekyb3d8bbwe.Appx    [from 2021]
├── Microsoft.VCLibs.140.00_14.0.33519.0_x64__8wekyb3d8bbwe.Appx            [from 2021]
├── Microsoft.VCLibs.140.00_14.0.33519.0_x86__8wekyb3d8bbwe.Appx            [from 2021]
├── Microsoft.UI.Xaml.2.8_x64__8wekyb3d8bbwe.appx                           [download]
├── Microsoft.UI.Xaml.2.8_x86__8wekyb3d8bbwe.appx                           [download]
├── Microsoft.WindowsStore_22510.1401.4.0_neutral_~_8wekyb3d8bbwe.msixbundle [have it]
└── Microsoft.WindowsStore_8wekyb3d8bbwe.xml                                [download]
```

**10 files total = Ready to install!**