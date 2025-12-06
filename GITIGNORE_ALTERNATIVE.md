# Alternative: Using .gitignore Instead of Git LFS

If you prefer **NOT** to use Git LFS and want to keep package files out of version control entirely, this guide shows you how to configure `.gitignore` to exclude large package files.

## Table of Contents
- [When to Use This Approach](#when-to-use-this-approach)
- [Advantages and Disadvantages](#advantages-and-disadvantages)
- [Setup Instructions](#setup-instructions)
- [Obtaining Package Files](#obtaining-package-files)
- [Sharing the Repository](#sharing-the-repository)
- [Switching from LFS to .gitignore](#switching-from-lfs-to-gitignore)

---

## When to Use This Approach

Use `.gitignore` instead of Git LFS if:

✅ You want to keep package files locally but not in version control  
✅ You don't need to version control the package files themselves  
✅ You want to avoid GitHub LFS storage quotas and costs  
✅ You're maintaining a public repository where users download packages themselves  
✅ You only want to version control the scripts and documentation  

---

## Advantages and Disadvantages

### Advantages ✅

- **No LFS costs:** No storage quotas or bandwidth charges
- **Smaller repository:** Only scripts and docs are versioned
- **Simpler workflow:** Standard Git operations, no LFS commands
- **Faster operations:** No LFS object transfers
- **Privacy:** Package files stay on your local machine

### Disadvantages ❌

- **No package version control:** Can't track package file changes over time
- **Distribution:** Users must obtain packages separately
- **Setup complexity:** Each user must download packages manually
- **Version mismatches:** No guarantee users have correct package versions
- **Lost history:** If package files were previously tracked, they remain in Git history

---

## Setup Instructions

### Step 1: Create .gitignore File

Create a `.gitignore` file in the repository root to exclude all package files:

**For Windows (Command Prompt):**
```cmd
cd C:\Users\Bladez\Documents\GitHub\LTSB-Add-MicrosoftStore
```

**Create the file using PowerShell:**
```powershell
@"
# Windows Package Files - Keep these out of Git
# Users should download these files separately

# All package file types
*.appx
*.Appx
*.appxbundle
*.AppxBundle
*.msixbundle
*.Msixbundle
*.eappxbundle
*.EAppxBundle

# Keep XML manifest files in Git (they're small)
!*.xml

# Keep batch/command scripts
!*.cmd
!*.bat

# Keep documentation
!*.md

# Package directories - exclude all binary files
packages-2019/*.appx
packages-2019/*.Appx
packages-2019/*.appxbundle
packages-2019/*.AppxBundle
packages-2019/*.msixbundle
packages-2019/*.Msixbundle

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

# But keep the XML files in package directories
!packages-2019/*.xml
!packages-2021/*.xml
!packages-2024/*.xml
"@ | Out-File -FilePath .gitignore -Encoding UTF8
```

**Or create manually in a text editor:**
```gitignore
# Windows Package Files - Keep these out of Git
# Users should download these files separately

# All package file types
*.appx
*.Appx
*.appxbundle
*.AppxBundle
*.msixbundle
*.Msixbundle
*.eappxbundle
*.EAppxBundle

# Keep XML manifest files in Git (they're small)
!*.xml

# Package directories content
packages-2019/*.appx*
packages-2019/*.Appx*
packages-2019/*.msix*
packages-2019/*.Msix*

packages-2021/*.appx*
packages-2021/*.Appx*
packages-2021/*.msix*
packages-2021/*.Msix*

packages-2024/*.appx*
packages-2024/*.Appx*
packages-2024/*.msix*
packages-2024/*.Msix*

# But keep XML files
!packages-*/*.xml
```

### Step 2: Remove Package Files from Git Tracking

If package files are already tracked in Git, remove them (keeps local files):

```cmd
# Remove from Git index but keep local files
git rm --cached *.appx
git rm --cached *.Appx
git rm --cached *.appxbundle
git rm --cached *.AppxBundle
git rm --cached *.msixbundle
git rm --cached *.Msixbundle
git rm --cached *.eappxbundle
git rm --cached *.EAppxBundle

# Remove package files in subdirectories
git rm --cached -r packages-2019/*.appx*
git rm --cached -r packages-2019/*.Appx*
git rm --cached -r packages-2021/*.appx*
git rm --cached -r packages-2021/*.Appx*
git rm --cached -r packages-2024/*.appx*
git rm --cached -r packages-2024/*.Appx*
git rm --cached -r packages-2024/*.msix*
git rm --cached -r packages-2024/*.Msix*
```

**Note:** This removes files from Git tracking but **KEEPS** them on your local disk.

### Step 3: Commit the Changes

```cmd
# Add .gitignore
git add .gitignore

# Commit the removal of package files and new .gitignore
git commit -m "Remove package files from version control, add .gitignore"

# Push to GitHub
git push origin main
```

### Step 4: Verify Package Files are Ignored

```cmd
# Check Git status - package files should NOT appear
git status

# Should show clean working tree
# Package files should be ignored
```

Test by creating a new package file:
```cmd
# Create a test file
echo test > test.appx

# Check status - should be ignored
git status
# Output should NOT list test.appx

# Clean up
del test.appx
```

---

## Obtaining Package Files

Since package files are no longer in the repository, users must download them separately.

### Update README.md

Add clear instructions for users to obtain packages. Update the "Package Requirements" section:

```markdown
## Package Files Not Included

⚠️ **Important:** Package files are NOT included in this Git repository due to their large size.

### How to Obtain Package Files

**Option 1: Extract from Windows ISO**
1. Download Windows 10/11 LTSC ISO from Microsoft Volume Licensing
2. Mount the ISO
3. Extract required packages from `\sources\` directory
4. See [EXTRACT_FROM_ISO.md](EXTRACT_FROM_ISO.md) for detailed instructions

**Option 2: Download from UUP Dump**
1. Visit https://uupdump.net/
2. Select your Windows LTSC version
3. Download the required packages
4. See [UUPDUMP_DOWNLOAD_GUIDE.md](UUPDUMP_DOWNLOAD_GUIDE.md)

**Option 3: Use Store Package Repository (if available)**
- Check store.rg-adguard.net for official package downloads
- Search for package names listed in requirements

**After obtaining packages:**
- Place them in the appropriate folders:
  - LTSC 2019: `packages-2019\` or root directory
  - LTSC 2021: `packages-2021\`
  - LTSC 2024: `packages-2024\`
```

### Create Package List Document

Create a `PACKAGE_LIST.md` file with exact package names and versions users need:

```markdown
# Required Package Files

This document lists all package files needed for each LTSC version.

## LTSC 2019 (Build 17763)

Place in `packages-2019\` folder:

- Microsoft.WindowsStore_11809.1001.713.0_neutral_~_8wekyb3d8bbwe.AppxBundle
- Microsoft.VCLibs.140.00_14.0.26706.0_x64__8wekyb3d8bbwe.Appx
- Microsoft.VCLibs.140.00_14.0.26706.0_x86__8wekyb3d8bbwe.Appx
- Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x64__8wekyb3d8bbwe.Appx
- Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x86__8wekyb3d8bbwe.Appx
- Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x64__8wekyb3d8bbwe.Appx
- Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x86__8wekyb3d8bbwe.Appx

(Continue for each version...)
```

---

## Sharing the Repository

When sharing with others:

### What Users Get
- ✅ Installation scripts (`.cmd`, `.bat`)
- ✅ Documentation (`.md` files)
- ✅ XML manifest files
- ✅ Configuration files
- ❌ Package files (they must download separately)

### Instructions for Contributors

Add to your `CONTRIBUTING.md` or README:

```markdown
## For Contributors

This repository does NOT include package files (`.appx`, `.appxbundle`, etc.).

**To set up locally:**
1. Clone the repository
2. Download required packages (see package requirements)
3. Place packages in appropriate folders
4. Package files are automatically ignored by `.gitignore`

**When contributing:**
- Do NOT commit package files
- Only commit changes to scripts and documentation
- `.gitignore` prevents accidental package file commits
```

---

## Switching from LFS to .gitignore

If you previously set up Git LFS and want to switch to `.gitignore`:

### Step 1: Remove LFS Configuration

```cmd
# Uninstall LFS from this repository
git lfs uninstall

# Remove .gitattributes LFS configuration
del .gitattributes
```

### Step 2: Remove LFS Objects from Git History

⚠️ **WARNING:** This rewrites Git history!

```cmd
# Install git-filter-repo if needed
pip install git-filter-repo

# Remove all LFS objects from history
git filter-repo --path-glob '*.appx*' --path-glob '*.msix*' --invert-paths --force
```

**Alternative (using BFG Repo-Cleaner):**
```cmd
# Download BFG from https://reps-cleaner.github.io/bfg-repo-cleaner/
java -jar bfg.jar --delete-files '*.{appx,appxbundle,msixbundle}'
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

### Step 3: Set Up .gitignore

Follow the [Setup Instructions](#setup-instructions) above to create `.gitignore`.

### Step 4: Force Push Clean History

```cmd
git push origin --force --all
```

### Step 5: Notify Collaborators

All collaborators must re-clone the repository:
```cmd
cd ..
rmdir /s /q LTSB-Add-MicrosoftStore
git clone https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore.git
```

---

## Verifying .gitignore Works

### Test 1: Check Ignored Files

```cmd
# List all ignored files
git status --ignored

# Should show package files under "Ignored files:"
```

### Test 2: Try to Add Package File

```cmd
# Try to add a package file
git add packages-2019\Microsoft.WindowsStore*.AppxBundle

# Should see: "The following paths are ignored by one of your .gitignore files"
```

### Test 3: Check Repository Size

```cmd
# Check repository size (should be small without packages)
git count-objects -vH
```

---

## Summary Comparison

| Feature | Git LFS | .gitignore |
|---------|---------|------------|
| **Version Control** | ✅ Package files tracked | ❌ Not tracked |
| **Repository Size** | Small (pointers only) | Small (no packages) |
| **Storage Costs** | May exceed free tier | Free |
| **User Setup** | Must install LFS | No extra tools needed |
| **Package Distribution** | Automatic via Git | Manual download |
| **History Tracking** | Full package history | Scripts/docs only |
| **Complexity** | Medium (LFS commands) | Low (standard Git) |

---

## Recommendation

For this LTSC Microsoft Store installer repository:

**Use .gitignore if:**
- Repository is primarily for script distribution
- Users can obtain packages from Microsoft/UUPDump
- You want to avoid LFS storage costs
- Package versions don't change frequently

**Use Git LFS if:**
- You need to version control package files
- You're building specific package sets for distribution
- You want users to get exact package versions
- You're willing to manage LFS storage quotas

---

**Questions?** Open an issue on GitHub for assistance.