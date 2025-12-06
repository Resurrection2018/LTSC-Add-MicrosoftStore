# 🚀 EASY MODE - Just Copy & Paste These Commands

**Total time: 5 minutes. No thinking required.**

---

## What This Does

- Removes large files from Git
- Uploads them to GitHub Releases instead
- Users download from Releases page
- **100% FREE, no costs**

---

## STEP 1: Open Command Prompt

1. Press `Win+R`
2. Type `cmd`
3. Press Enter

---

## STEP 2: Install GitHub CLI

**Copy this, paste in Command Prompt, press Enter:**

```cmd
winget install GitHub.GitLFS
```

Wait for it to finish (30 seconds).

**Then copy this, paste, press Enter:**

```cmd
gh auth login
```

- Choose: **GitHub.com**
- Choose: **HTTPS**
- Login in your browser when it opens
- Come back to Command Prompt when done

---

## STEP 3: Go to Your Repository Folder

**Copy this EXACT command, paste, press Enter:**

```cmd
cd C:\Users\Bladez\Documents\GitHub\LTSB-Add-MicrosoftStore
```

---

## STEP 4: Create .gitignore File

**Copy ALL of this, paste, press Enter:**

```cmd
(
echo # Package files go to GitHub Releases, not Git
echo *.appx
echo *.Appx
echo *.appxbundle
echo *.AppxBundle
echo *.msixbundle
echo *.Msixbundle
echo *.eappxbundle
echo *.EAppxBundle
echo !*.xml
echo !*.cmd
echo !*.bat
echo !*.md
) > .gitignore
```

---

## STEP 5: Remove Packages from Git

**Copy this, paste, press Enter:**

```cmd
git rm --cached -r *.appx 2>nul & git rm --cached -r *.Appx 2>nul & git rm --cached -r *.appxbundle 2>nul & git rm --cached -r *.AppxBundle 2>nul & git rm --cached -r *.msixbundle 2>nul & git rm --cached -r packages-2019\*.appx* 2>nul & git rm --cached -r packages-2021\*.appx* 2>nul & git rm --cached -r packages-2021\*.msix* 2>nul & git rm --cached -r packages-2024\*.appx* 2>nul & git rm --cached -r packages-2024\*.msix* 2>nul
```

---

## STEP 6: Save Changes to Git

**Copy this, paste, press Enter:**

```cmd
git add .gitignore
```

**Then copy this, paste, press Enter:**

```cmd
git commit -m "Use GitHub Releases for packages"
```

**Then copy this, paste, press Enter:**

```cmd
git push origin main
```

---

## STEP 7: Create Releases with Your Packages

**Copy EACH command ONE AT A TIME, paste, press Enter, wait for it to finish:**

### Release 1 (LTSC 2019):
```cmd
gh release create v1.0-ltsc2019 --title "LTSC 2019 Packages" --notes "Download all files to packages-2019 folder" packages-2019\*.appx packages-2019\*.Appx packages-2019\*.appxbundle packages-2019\*.AppxBundle
```

Wait for "✓" checkmark before doing next one.

### Release 2 (LTSC 2021):
```cmd
gh release create v1.0-ltsc2021 --title "LTSC 2021 Packages" --notes "Download all files to packages-2021 folder" packages-2021\*.appx packages-2021\*.Appx packages-2021\*.appxbundle packages-2021\*.AppxBundle packages-2021\*.msixbundle packages-2021\*.Msixbundle
```

Wait for "✓" checkmark before doing next one.

### Release 3 (LTSC 2024):
```cmd
gh release create v1.0-ltsc2024 --title "LTSC 2024 Packages" --notes "Download all files to packages-2024 folder" packages-2024\*.appx packages-2024\*.Appx packages-2024\*.appxbundle packages-2024\*.AppxBundle packages-2024\*.msixbundle packages-2024\*.Msixbundle
```

Wait for final "✓" checkmark.

---

## STEP 8: Verify It Worked

**Copy this, paste, press Enter:**

```cmd
gh release list
```

You should see 3 releases listed. ✅

---

## 🎉 DONE!

Your packages are now on GitHub Releases!

**View them here:**
- Go to your repository on GitHub
- Click "Releases" on the right side
- You'll see 3 releases with all your packages

**Your Git repository is now small and fast!**

---

## What Happens Now?

### For You:
- Your repository only has scripts and docs
- No more "file too large" errors
- Free GitHub hosting

### For Users:
1. They go to your Releases page
2. Download the packages for their Windows version
3. Put files in `packages-XXXX\` folder
4. Run `Add-Store.cmd`

---

## If Something Goes Wrong

**GitHub CLI not found?**
- Close Command Prompt
- Open new Command Prompt
- Try `gh auth login` again

**Release creation failed?**
- Make sure you're in the right folder: `cd C:\Users\Bladez\Documents\GitHub\LTSB-Add-MicrosoftStore`
- Make sure you're logged in: `gh auth status`
- Try the release command again

**Still stuck?**
- Take a screenshot of the error
- Open an issue on GitHub

---

## That's It!

No configuration files to edit.  
No complex Git commands.  
Just copy, paste, done.

**Your large files problem is solved! 🎉**