# GitHub Releases Setup Guide

Complete step-by-step guide to set up GitHub Releases for your LTSC package files.

## Why GitHub Releases is Perfect for This Project

✅ **Free** - No storage costs or quotas  
✅ **Unlimited file size** - No 100 MB limit on release assets  
✅ **Easy for users** - Direct download links  
✅ **Organized by version** - Separate release for each LTSC version  
✅ **Clean repository** - Only scripts and docs in Git  
✅ **No LFS complexity** - Standard Git workflow  

---

## Overview

**What you'll do:**
1. Set up `.gitignore` to exclude package files from Git
2. Remove package files from Git tracking (keep local copies)
3. Create GitHub Releases for each LTSC version
4. Upload package files as release assets
5. Update documentation with download links

**Time required:** 15-30 minutes

---

## Prerequisites

- Git installed
- GitHub account
- Package files locally available
- GitHub CLI (optional, makes uploading easier)

---

## Step 1: Install GitHub CLI (Recommended)

The GitHub CLI makes creating releases much easier.

### Installation

**Option A: Using Winget**
```cmd
winget install GitHub.CLI
```

**Option B: Using Chocolatey**
```cmd
choco install gh
```

**Option C: Manual Download**
Download from https://cli.github.com/

### Authenticate

```cmd
gh auth login
```

Follow the prompts:
1. Choose "GitHub.com"
2. Choose "HTTPS"
3. Authenticate via web browser
4. Complete authentication

### Verify Installation

```cmd
gh --version
```

---

## Step 2: Create .gitignore File

Create a `.gitignore` file to exclude package files from version control.

### Using PowerShell

```powershell
cd C:\Users\Bladez\Documents\GitHub\LTSB-Add-MicrosoftStore

@"
# Windows Package Files
# These files are distributed via GitHub Releases

# All package file extensions
*.appx
*.Appx
*.appxbundle
*.AppxBundle
*.msixbundle
*.Msixbundle
*.eappxbundle
*.EAppxBundle

# Keep XML manifest files (they're small and needed)
!*.xml

# Keep all scripts and documentation
!*.cmd
!*.bat
!*.md
!*.ps1

# Package directories
packages-2019/*.appx
packages-2019/*.Appx
packages-2019/*.appxbundle
packages-2019/*.AppxBundle

packages-2021/*.appx
packages-2021/*.Appx
packages-2021/*.appxbundle
packages-2021/*.AppxBundle
packages-2021/*.msixbundle
packages-2021/*.Msixbundle

packages-2024/*.appx
packages-2024/*.Appx
packages-2024/*.appxbundle
packages-2024/*.AppxBundle
packages-2024/*.msixbundle
packages-2024/*.Msixbundle

# Keep XML files in package directories
!packages-*/*.xml
"@ | Out-File -FilePath .gitignore -Encoding UTF8
```

### Or Create Manually

Create `.gitignore` file with your text editor and paste the content above.

---

## Step 3: Remove Package Files from Git Tracking

Remove package files from Git **WITHOUT** deleting local files.

```cmd
cd C:\Users\Bladez\Documents\GitHub\LTSB-Add-MicrosoftStore

# Remove individual package files from root
git rm --cached *.appx 2>nul
git rm --cached *.Appx 2>nul
git rm --cached *.appxbundle 2>nul
git rm --cached *.AppxBundle 2>nul
git rm --cached *.msixbundle 2>nul
git rm --cached *.Msixbundle 2>nul

# Remove package files from subdirectories
git rm --cached -r packages-2019/*.appx* 2>nul
git rm --cached -r packages-2019/*.Appx* 2>nul
git rm --cached -r packages-2021/*.appx* 2>nul
git rm --cached -r packages-2021/*.Appx* 2>nul
git rm --cached -r packages-2021/*.msix* 2>nul
git rm --cached -r packages-2024/*.appx* 2>nul
git rm --cached -r packages-2024/*.Appx* 2>nul
git rm --cached -r packages-2024/*.msix* 2>nul
git rm --cached -r packages-2024/*.Msix* 2>nul
```

**Note:** Some commands may show "did not match any files" - this is normal if those files weren't tracked.

### Commit the Changes

```cmd
# Add .gitignore
git add .gitignore

# Commit the removal
git commit -m "Remove package files from Git, use GitHub Releases for distribution"

# Push to GitHub
git push origin main
```

---

## Step 4: Create GitHub Releases

Now create releases and upload package files.

### Method A: Using GitHub CLI (Recommended)

#### Release 1: LTSC 2019

```cmd
cd C:\Users\Bladez\Documents\GitHub\LTSB-Add-MicrosoftStore

gh release create v1.0-ltsc2019 ^
  --title "LTSC 2019 Packages" ^
  --notes "Complete package set for Windows 10 Enterprise LTSC 2019 (Build 17763)%0A%0A**Included Packages:**%0A- Microsoft.WindowsStore%0A- Microsoft.VCLibs.140.00 (x64 and x86)%0A- Microsoft.NET.Native.Framework.1.6 (x64 and x86)%0A- Microsoft.NET.Native.Runtime.1.6 (x64 and x86)%0A- Microsoft.StorePurchaseApp (optional)%0A- Microsoft.DesktopAppInstaller (optional)%0A- Microsoft.XboxIdentityProvider (optional)%0A%0A**Installation:**%0A1. Download all files from this release%0A2. Place them in the repository's `packages-2019\` folder%0A3. Run `Add-Store.cmd` as Administrator" ^
  packages-2019\*.appx ^
  packages-2019\*.Appx ^
  packages-2019\*.appxbundle ^
  packages-2019\*.AppxBundle
```

#### Release 2: LTSC 2021

```cmd
gh release create v1.0-ltsc2021 ^
  --title "LTSC 2021 Packages" ^
  --notes "Complete package set for Windows 10 Enterprise LTSC 2021 (Build 19044/19045)%0A%0A**Included Packages:**%0A- Microsoft.WindowsStore (updated version)%0A- Microsoft.VCLibs.140.00 14.0.30704.0+ (x64 and x86)%0A- Microsoft.NET.Native.Framework 2.2+ (x64 and x86)%0A- Microsoft.NET.Native.Runtime 2.2+ (x64 and x86)%0A- Microsoft.UI.Xaml.2.8 (x86)%0A- Microsoft.StorePurchaseApp (optional)%0A- Microsoft.DesktopAppInstaller (optional)%0A- Microsoft.XboxIdentityProvider (optional)%0A%0A**Installation:**%0A1. Download all files from this release%0A2. Place them in the repository's `packages-2021\` folder%0A3. Run `Add-Store.cmd` as Administrator" ^
  packages-2021\*.appx ^
  packages-2021\*.Appx ^
  packages-2021\*.appxbundle ^
  packages-2021\*.AppxBundle ^
  packages-2021\*.msixbundle ^
  packages-2021\*.Msixbundle
```

#### Release 3: LTSC 2024

```cmd
gh release create v1.0-ltsc2024 ^
  --title "LTSC 2024 Packages" ^
  --notes "Complete package set for Windows 11 Enterprise LTSC 2024 (Build 26100)%0A%0A**Included Packages:**%0A- Microsoft.WindowsStore (latest version)%0A- Microsoft.VCLibs.140.00 14.0.33519.0+ (x64 and x86)%0A- Microsoft.NET.Native.Framework 2.2+ (x64 and x86)%0A- Microsoft.NET.Native.Runtime 2.2+ (x64 and x86)%0A- Microsoft.UI.Xaml.2.8 (x64 and x86) - **Required for Windows 11**%0A- Microsoft.StorePurchaseApp (optional)%0A- Microsoft.DesktopAppInstaller (optional)%0A- Microsoft.XboxIdentityProvider (optional)%0A%0A**Installation:**%0A1. Download all files from this release%0A2. Place them in the repository's `packages-2024\` folder%0A3. Run `Add-Store.cmd` as Administrator" ^
  packages-2024\*.appx ^
  packages-2024\*.Appx ^
  packages-2024\*.appxbundle ^
  packages-2024\*.AppxBundle ^
  packages-2024\*.msixbundle ^
  packages-2024\*.Msixbundle
```

### Method B: Using GitHub Web Interface

If you prefer the web interface or GitHub CLI doesn't work:

#### For Each LTSC Version:

1. **Go to your repository on GitHub**
   - Navigate to: `https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore`

2. **Click "Releases"** (right sidebar)

3. **Click "Create a new release"**

4. **Fill in release details:**
   - **Tag:** `v1.0-ltsc2019` (or 2021, 2024)
   - **Release title:** `LTSC 2019 Packages`
   - **Description:** Copy from CLI notes above
   - **Attach files:** Drag and drop all package files from `packages-2019\`

5. **Click "Publish release"**

6. **Repeat for LTSC 2021 and 2024**

---

## Step 5: Verify Releases

Check that releases were created successfully:

### Using GitHub CLI

```cmd
gh release list
```

You should see:
```
v1.0-ltsc2024    LTSC 2024 Packages    Latest
v1.0-ltsc2021    LTSC 2021 Packages    
v1.0-ltsc2019    LTSC 2019 Packages
```

### Using Web Browser

Visit: `https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases`

You should see all three releases with download links.

---

## Step 6: Update README.md

Update the README to point users to releases.

### Option 1: Add Prominent Section at Top

Add this section near the top of README.md (after the supported versions):

```markdown
## 📦 Download Package Files

**Package files are distributed via GitHub Releases.**

### Quick Download:
- **Windows 11 LTSC 2024:** [📥 Download v1.0-ltsc2024](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2024)
- **Windows 10 LTSC 2021:** [📥 Download v1.0-ltsc2021](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2021)
- **Windows 10 LTSC 2019:** [📥 Download v1.0-ltsc2019](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2019)

**Or browse all releases:** [View All Releases](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases)

### After Downloading:
1. Extract downloaded files to the appropriate folder:
   - LTSC 2019 → `packages-2019\`
   - LTSC 2021 → `packages-2021\`
   - LTSC 2024 → `packages-2024\`
2. Run `Add-Store.cmd` as Administrator
```

### Option 2: Update Installation Section

Modify the existing "Quick Start" section:

```markdown
### Quick Start
1. **Download packages:** Get the appropriate package files for your LTSC version from [Releases](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases)
2. **Extract files:** Place them in the correct folder structure:
   - LTSC 2019: In `packages-2019\` folder
   - LTSC 2021: In `packages-2021\` folder
   - LTSC 2024: In `packages-2024\` folder
3. **Install:** Run `Add-Store.cmd` as Administrator
```

### Option 3: Replace Package Requirements Note

Replace the existing note about packages:

**OLD:**
```markdown
**Note:** Package files are not included in this repository. For personal use, you can:
- Extract from official Windows ISO images
- Use UUP Dump to download official packages
- Check MDL forums for package sources
```

**NEW:**
```markdown
**Note:** Package files are distributed via [GitHub Releases](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases) for easy access:
- **LTSC 2024:** [Download here](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2024)
- **LTSC 2021:** [Download here](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2021)
- **LTSC 2019:** [Download here](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2019)

Alternative sources:
- Extract from official Windows ISO images
- Use [UUP Dump](https://uupdump.net/) to download official packages
- See [GET_LTSC_2024_PACKAGES.md](GET_LTSC_2024_PACKAGES.md) for extraction guide
```

---

## Step 7: Update Chinese Section in README

Update the Chinese section similarly:

```markdown
## 📦 下载安装包文件

**安装包文件通过 GitHub Releases 分发。**

### 快速下载：
- **Windows 11 LTSC 2024:** [📥 下载 v1.0-ltsc2024](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2024)
- **Windows 10 LTSC 2021:** [📥 下载 v1.0-ltsc2021](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2021)
- **Windows 10 LTSC 2019:** [📥 下载 v1.0-ltsc2019](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2019)

**或浏览所有版本:** [查看所有发布](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases)
```

---

## Step 8: Create Download Instructions Document

Create a user-friendly download guide.

**Create `DOWNLOAD.md`:**

```markdown
# Package Download Instructions

## Download from GitHub Releases

All package files are hosted on GitHub Releases for easy access.

### Step-by-Step:

1. **Choose your Windows version:**
   - Windows 11 LTSC 2024 → [Download LTSC 2024 Packages](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2024)
   - Windows 10 LTSC 2021 → [Download LTSC 2021 Packages](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2021)
   - Windows 10 LTSC 2019 → [Download LTSC 2019 Packages](https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases/tag/v1.0-ltsc2019)

2. **Download files:**
   - Click on each file name to download
   - Or click "Assets" to see all files
   - Download all `.appx`, `.appxbundle`, and `.msixbundle` files
   - Also download the `.xml` files if present

3. **Extract to correct folder:**
   ```
   LTSB-Add-MicrosoftStore\
   ├── packages-2019\    ← Place LTSC 2019 files here
   ├── packages-2021\    ← Place LTSC 2021 files here
   └── packages-2024\    ← Place LTSC 2024 files here
   ```

4. **Verify download:**
   - Check file sizes match the release page
   - Ensure all required files are present

5. **Run installer:**
   - Open Command Prompt as Administrator
   - Navigate to repository folder
   - Run `Add-Store.cmd`

## Don't Know Your Windows Version?

Press `Win+R`, type `winver`, press Enter. Check the build number:
- Build 26100 = LTSC 2024
- Build 19044 or 19045 = LTSC 2021
- Build 17763 = LTSC 2019

## Troubleshooting

**Downloads are slow:**
- GitHub may throttle if many people download at once
- Try again later or use alternative sources in README

**Files won't download:**
- Check your internet connection
- Try a different browser
- Disable browser extensions temporarily

**Missing files:**
- Verify you downloaded ALL files from the release
- Check packages-XXXX folder has the files
```

---

## Step 9: Test the Setup

Verify everything works:

### Test 1: Clone Fresh Repository

```cmd
# Clone to a test location
cd C:\Temp
git clone https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore.git test-clone
cd test-clone

# Verify no package files are cloned
dir packages-2019
dir packages-2021
dir packages-2024

# Should show only .xml files or "File Not Found"
```

### Test 2: Download from Releases

1. Go to releases page
2. Download one package file
3. Verify it downloads completely
4. Check file size matches

### Test 3: Check .gitignore Works

```cmd
# Try to add a package file
cd C:\Users\Bladez\Documents\GitHub\LTSB-Add-MicrosoftStore
git status

# Should show clean working directory
# Package files should not appear
```

---

## Maintenance and Updates

### Adding New Package Versions

When you get updated packages:

```cmd
# 1. Update local package files
copy new-package.appx packages-2024\

# 2. Create new release
gh release create v1.1-ltsc2024 ^
  --title "LTSC 2024 Packages (Updated)" ^
  --notes "Updated packages for LTSC 2024 - December 2024" ^
  packages-2024\*.appx*

# 3. Optionally mark as latest
gh release edit v1.1-ltsc2024 --latest
```

### Deleting Old Releases

If you want to remove outdated releases:

```cmd
# Delete a release (keeps tag)
gh release delete v1.0-ltsc2019

# Delete release and tag
gh release delete v1.0-ltsc2019 --yes --cleanup-tag
```

---

## Summary Checklist

- [ ] GitHub CLI installed and authenticated
- [ ] `.gitignore` created and committed
- [ ] Package files removed from Git tracking
- [ ] Three releases created (2019, 2021, 2024)
- [ ] All package files uploaded to releases
- [ ] README.md updated with download links
- [ ] Download instructions created
- [ ] Changes pushed to GitHub
- [ ] Tested fresh clone
- [ ] Verified releases are accessible

---

## Benefits of This Setup

✅ **Free** - No GitHub LFS costs  
✅ **Simple** - Standard Git workflow  
✅ **Fast** - Repository is lightweight  
✅ **Easy for users** - Direct download links  
✅ **Organized** - Each LTSC version separate  
✅ **Unlimited file size** - No 100 MB limit  
✅ **Bandwidth** - GitHub CDN handles distribution  
✅ **Versioning** - Easy to update with new releases  

---

## Need Help?

- **GitHub CLI docs:** https://cli.github.com/manual/
- **GitHub Releases docs:** https://docs.github.com/en/repositories/releasing-projects-on-github
- **Issues?** Open an issue on your repository

---

**You're all set! Your repository now uses GitHub Releases for package distribution! 🎉**