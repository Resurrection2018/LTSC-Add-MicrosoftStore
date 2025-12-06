# Quick Start: GitHub Releases Setup

**Copy and paste these commands to set up GitHub Releases in 5 minutes.**

---

## Step 1: Install GitHub CLI (1 minute)

```cmd
winget install GitHub.CLI
gh auth login
```
Follow prompts to authenticate.

---

## Step 2: Create .gitignore (30 seconds)

```cmd
cd C:\Users\Bladez\Documents\GitHub\LTSB-Add-MicrosoftStore
```

**PowerShell:**
```powershell
@"
# Windows Package Files - Distributed via GitHub Releases
*.appx
*.Appx
*.appxbundle
*.AppxBundle
*.msixbundle
*.Msixbundle
*.eappxbundle
*.EAppxBundle
!*.xml
!*.cmd
!*.bat
!*.md
packages-2019/*.appx*
packages-2019/*.Appx*
packages-2021/*.appx*
packages-2021/*.Appx*
packages-2021/*.msix*
packages-2024/*.appx*
packages-2024/*.Appx*
packages-2024/*.msix*
!packages-*/*.xml
"@ | Out-File -FilePath .gitignore -Encoding UTF8
```

---

## Step 3: Remove Packages from Git (1 minute)

```cmd
git rm --cached -r *.appx* 2>nul
git rm --cached -r *.Appx* 2>nul
git rm --cached -r *.msix* 2>nul
git rm --cached -r packages-2019/*.appx* 2>nul
git rm --cached -r packages-2021/*.appx* 2>nul
git rm --cached -r packages-2021/*.msix* 2>nul
git rm --cached -r packages-2024/*.appx* 2>nul
git rm --cached -r packages-2024/*.msix* 2>nul

git add .gitignore
git commit -m "Use GitHub Releases for package distribution"
git push origin main
```

---

## Step 4: Create Releases (2 minutes)

**Copy and paste each command:**

### LTSC 2019:
```cmd
gh release create v1.0-ltsc2019 --title "LTSC 2019 Packages" --notes "Complete package set for Windows 10 Enterprise LTSC 2019 (Build 17763). Download all files and place in packages-2019\ folder, then run Add-Store.cmd as Administrator." packages-2019\*.appx packages-2019\*.Appx packages-2019\*.appxbundle packages-2019\*.AppxBundle
```

### LTSC 2021:
```cmd
gh release create v1.0-ltsc2021 --title "LTSC 2021 Packages" --notes "Complete package set for Windows 10 Enterprise LTSC 2021 (Build 19044/19045). Download all files and place in packages-2021\ folder, then run Add-Store.cmd as Administrator." packages-2021\*.appx packages-2021\*.Appx packages-2021\*.appxbundle packages-2021\*.AppxBundle packages-2021\*.msixbundle packages-2021\*.Msixbundle
```

### LTSC 2024:
```cmd
gh release create v1.0-ltsc2024 --title "LTSC 2024 Packages" --notes "Complete package set for Windows 11 Enterprise LTSC 2024 (Build 26100). Download all files and place in packages-2024\ folder, then run Add-Store.cmd as Administrator." packages-2024\*.appx packages-2024\*.Appx packages-2024\*.appxbundle packages-2024\*.AppxBundle packages-2024\*.msixbundle packages-2024\*.Msixbundle
```

---

## Step 5: Verify (30 seconds)

```cmd
gh release list
```

You should see three releases listed.

**Or visit:** `https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore/releases`

---

## Done! ✅

Your package files are now distributed via GitHub Releases:
- ✅ Free hosting
- ✅ No file size limits
- ✅ Easy downloads for users
- ✅ Clean Git repository

### Next Steps:
1. Update README.md with download links (see [GITHUB_RELEASES_SETUP.md](GITHUB_RELEASES_SETUP.md))
2. Share the releases page with users
3. Keep local package files for future updates

**Full documentation:** [GITHUB_RELEASES_SETUP.md](GITHUB_RELEASES_SETUP.md)