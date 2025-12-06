# Quick Start Guide

Get Microsoft Store running on your Windows 10 LTSC in minutes!

## For LTSC 2019 Users (Build 17763)

### Option 1: Use Your Existing Setup
Your current files already work! Just run:
1. Right-click [`Add-Store.cmd`](Add-Store.cmd:1)
2. Select "Run as administrator"
3. Done!

### Option 2: Organize for the Future (Recommended)
```batch
mkdir packages-2019
move *.AppxBundle packages-2019\
move *.Appx packages-2019\
move *.xml packages-2019\
```
Then run [`Add-Store.cmd`](Add-Store.cmd:1) as administrator.

## For LTSC 2021 Users (Build 19044/19045)

### You Need LTSC 2021 Packages First!

1. **Get the packages** - See [`PACKAGE_GUIDE.md`](PACKAGE_GUIDE.md:1) for sources
2. **Create the folder**
   ```batch
   mkdir packages-2021
   ```
3. **Place packages** in `packages-2021\` folder:
   - Microsoft.WindowsStore bundle + XML
   - VCLibs 14.0.30704.0+ (x64 & x86)
   - .NET Framework 2.2+ (x64 & x86)
   - .NET Runtime 2.2+ (x64 & x86)
   - Optional components

4. **Run the installer**
   - Right-click [`Add-Store.cmd`](Add-Store.cmd:1)
   - Select "Run as administrator"

## What the Script Does

1. **Detects your Windows version** automatically
2. **Selects the right packages** for your system
3. **Installs Microsoft Store** and all dependencies
4. **Shows clear status messages** throughout

## After Installation

### If Store Works
🎉 You're done! Open Start Menu → Microsoft Store

### If Store Doesn't Open
Try this (in order):
1. **Reboot your computer**
2. **Clear Store cache:**
   - Press `Win+R`
   - Type: `WSReset.exe`
   - Press Enter
3. **Re-register Store:**
   ```
   PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage Microsoft.WindowsStore).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
   ```
4. **Reboot again**

## Common Questions

**Q: Where do I get the packages?**  
A: See [`PACKAGE_GUIDE.md`](PACKAGE_GUIDE.md:1) for detailed instructions

**Q: Can I skip optional components?**  
A: Yes! Just don't include their files. But keep them if you want:
- Desktop App Installer (includes winget)
- Store Purchase App (for in-app purchases)
- Xbox Identity Provider (for gaming)

**Q: Will this work on both 32-bit and 64-bit?**  
A: Yes! The script automatically detects your architecture

**Q: My version isn't LTSC 2019 or 2021, will it work?**  
A: It requires Windows 10 build 16299 or later. The script will tell you if your version is supported.

## Need More Help?

- **Installation issues?** → [`README.md`](README.md:1) Troubleshooting section
- **Package questions?** → [`PACKAGE_GUIDE.md`](PACKAGE_GUIDE.md:1)
- **Organizing files?** → [`MIGRATION_GUIDE.md`](MIGRATION_GUIDE.md:1)
- **Testing?** → [`TESTING_CHECKLIST.md`](TESTING_CHECKLIST.md:1)

## File Structure Reference

```
Your Project/
├── Add-Store.cmd          ← Run this as admin!
├── QUICKSTART.md          ← You are here
├── README.md              ← Full documentation
│
├── packages-2019/         ← LTSC 2019 packages
│   └── (your .AppxBundle, .Appx, .xml files)
│
└── packages-2021/         ← LTSC 2021 packages
    └── (newer versions of packages)
```

---

**Ready to install?** Right-click [`Add-Store.cmd`](Add-Store.cmd:1) → Run as administrator!