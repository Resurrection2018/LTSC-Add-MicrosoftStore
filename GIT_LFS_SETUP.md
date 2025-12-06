# Git LFS Setup Guide

This guide explains how to set up Git Large File Storage (LFS) for this repository to handle large Windows package files that exceed GitHub's standard file size limits.

## Table of Contents
- [What is Git LFS?](#what-is-git-lfs)
- [Why Use Git LFS?](#why-use-git-lfs)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [First-Time Repository Setup](#first-time-repository-setup)
- [Migrating Existing Files to LFS](#migrating-existing-files-to-lfs)
- [Cloning an LFS-Enabled Repository](#cloning-an-lfs-enabled-repository)
- [Working with LFS Files](#working-with-lfs-files)
- [GitHub LFS Storage Quotas](#github-lfs-storage-quotas)
- [Troubleshooting](#troubleshooting)

---

## What is Git LFS?

Git Large File Storage (LFS) is an extension to Git that handles large files by storing them outside the main repository. Instead of storing the actual large files in Git, LFS stores small "pointer files" that reference the actual content stored on a remote server.

**How it works:**
- Large files are stored on LFS server (not in Git history)
- Git repository only contains small pointer files (~100 bytes)
- Actual files are downloaded when needed
- Reduces repository clone size and speeds up operations

---

## Why Use Git LFS?

This repository contains Windows package files (`.appx`, `.appxbundle`, `.msixbundle`) that are typically **50-150 MB each**. Without LFS:

❌ **Problems:**
- GitHub rejects files larger than 100 MB
- Repository becomes extremely large (1+ GB)
- Slow clones and operations
- Git performance degrades

✅ **Benefits with LFS:**
- All files can be version controlled
- Fast repository operations
- Manageable repository size
- GitHub accepts the repository

---

## Prerequisites

- **Git:** Version 2.x or higher
- **Operating System:** Windows 10/11 (this guide focuses on Windows)
- **GitHub Account:** For pushing to GitHub
- **Admin Rights:** To install Git LFS on Windows

---

## Installation

### Step 1: Install Git LFS on Windows

**Option A: Using Git for Windows Installer**
1. Download latest Git for Windows from https://git-scm.com/download/win
2. During installation, ensure "Git LFS" is selected
3. Complete the installation

**Option B: Using Winget (Windows Package Manager)**
```cmd
winget install Git.Git
winget install GitHub.GitLFS
```

**Option C: Using Chocolatey**
```cmd
choco install git-lfs
```

**Option D: Manual Installation**
1. Download Git LFS from https://git-lfs.github.com/
2. Run the installer
3. Follow the installation wizard

### Step 2: Verify Installation

Open Command Prompt or PowerShell and run:
```cmd
git lfs version
```

You should see output like:
```
git-lfs/3.4.0 (GitHub; windows amd64; go 1.21.0)
```

### Step 3: Initialize Git LFS (One-Time Setup)

Run this command to set up Git LFS for your user account:
```cmd
git lfs install
```

You should see:
```
Updated Git hooks.
Git LFS initialized.
```

---

## First-Time Repository Setup

If you're setting up this repository **for the first time** with Git LFS:

### Step 1: Navigate to Repository
```cmd
cd C:\Users\Bladez\Documents\GitHub\LTSB-Add-MicrosoftStore
```

### Step 2: Initialize Git LFS in Repository
```cmd
git lfs install
```

### Step 3: Verify .gitattributes Configuration

The `.gitattributes` file is already configured to track package files. Verify it exists:
```cmd
type .gitattributes
```

You should see entries like:
```
*.appx filter=lfs diff=lfs merge=lfs -text
*.appxbundle filter=lfs diff=lfs merge=lfs -text
*.msixbundle filter=lfs diff=lfs merge=lfs -text
```

### Step 4: Track Existing Files (if not already done)

If you have package files that aren't tracked yet:
```cmd
git lfs track "*.appx"
git lfs track "*.Appx"
git lfs track "*.appxbundle"
git lfs track "*.AppxBundle"
git lfs track "*.msixbundle"
git lfs track "*.Msixbundle"
git lfs track "*.eappxbundle"
git lfs track "*.EAppxBundle"
```

---

## Migrating Existing Files to LFS

⚠️ **WARNING:** This process rewrites Git history. All collaborators must re-clone after migration.

### Prerequisites for Migration
1. **Backup your repository** (make a copy of the entire folder)
2. Ensure all changes are committed
3. Ensure you have no uncommitted changes: `git status`
4. All collaborators should be notified about the migration

### Migration Steps

#### Step 1: Current State Check
```cmd
# Check current repository size
git count-objects -vH

# View current branch
git branch

# Check for uncommitted changes
git status
```

#### Step 2: Migrate Existing Files to LFS

This command finds all existing package files in Git history and migrates them to LFS:

```cmd
git lfs migrate import --include="*.appx,*.Appx,*.appxbundle,*.AppxBundle,*.msixbundle,*.Msixbundle,*.eappxbundle,*.EAppxBundle" --everything
```

**What this does:**
- Scans entire Git history for matching files
- Converts them to LFS pointers
- Rewrites Git history
- Moves actual files to LFS storage

**Expected output:**
```
migrate: Sorting commits: ..., done.
migrate: Rewriting commits: 100% (X/X), done.
migrate: Updating refs: ..., done.
migrate: checkout: ..., done.
```

#### Step 3: Verify Migration

Check which files are tracked by LFS:
```cmd
git lfs ls-files
```

You should see all your package files listed.

Check repository size (should be much smaller):
```cmd
git count-objects -vH
```

#### Step 4: Force Push to GitHub

⚠️ **This rewrites remote history - use with caution!**

```cmd
# First, ensure you're on the main/master branch
git branch

# Force push the rewritten history
git push origin --force --all

# Push LFS objects
git lfs push origin --all
```

#### Step 5: Push Git LFS Objects
```cmd
git lfs push origin main --all
```

---

## Cloning an LFS-Enabled Repository

### For New Contributors

When cloning this repository, Git LFS will automatically download the large files:

```cmd
# Clone the repository
git clone https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore.git

# Enter the directory
cd LTSB-Add-MicrosoftStore

# LFS files are automatically downloaded during clone
# Verify LFS files are present
git lfs ls-files
```

### Existing Clones (After Migration)

If you had the repository cloned **before** LFS migration:

```cmd
# Navigate to your local repository
cd C:\path\to\LTSB-Add-MicrosoftStore

# Remove the old repository
cd ..
rmdir /s /q LTSB-Add-MicrosoftStore

# Re-clone fresh
git clone https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore.git
```

---

## Working with LFS Files

### Adding New Package Files

Just add and commit files normally. Git LFS handles them automatically:

```cmd
# Copy new package file to repository
copy "C:\Downloads\NewPackage.appxbundle" packages-2024\

# Add to Git
git add packages-2024\NewPackage.appxbundle

# Commit
git commit -m "Add NewPackage for LTSC 2024"

# Push (LFS automatically handles the large file)
git push origin main
```

### Checking LFS Status

View which files are managed by LFS:
```cmd
git lfs ls-files
```

View LFS storage usage:
```cmd
git lfs status
```

### Pulling LFS Files

When pulling updates that include LFS files:
```cmd
git pull origin main
```

LFS files are downloaded automatically.

---

## GitHub LFS Storage Quotas

### Free GitHub Account Limits
- **Storage:** 1 GB for all LFS objects
- **Bandwidth:** 1 GB/month for downloads
- **Cost:** Free

### What This Means for This Repository

With approximately **54 package files** averaging **80-120 MB each**:
- **Estimated total size:** 4-6 GB of LFS objects
- **Recommendation:** You'll likely exceed free tier limits

### Options

**Option 1: Delete Older Packages**
- Keep only LTSC 2024 packages
- Remove packages-2019 and packages-2021 folders
- Reduces storage to ~1 GB

**Option 2: GitHub LFS Data Packs**
- Purchase additional storage: $5/month for 50 GB
- Purchase additional bandwidth: $5/month for 50 GB
- See: https://docs.github.com/en/billing/managing-billing-for-git-large-file-storage

**Option 3: Alternative Hosting**
- Use Git LFS with GitLab (10 GB free)
- Self-host LFS server
- Use cloud storage links instead

**Option 4: Don't Track All Versions**
- Only commit latest package versions
- Document where users can download older versions
- Use `.gitignore` for some package directories

---

## Troubleshooting

### LFS Files Not Downloading

**Problem:** After clone, LFS files show as pointer files (text files with "version https://git-lfs.github.com...")

**Solution:**
```cmd
# Fetch all LFS objects
git lfs fetch --all

# Checkout LFS files
git lfs checkout
```

### "This exceeds GitHub's file size limit"

**Problem:** Pushing fails with file size error

**Solution:** Ensure LFS is properly configured:
```cmd
# Check if file is tracked by LFS
git lfs ls-files | findstr "filename"

# If not tracked, add to LFS
git lfs track "*.appxbundle"
git add .gitattributes
git add your-file.appxbundle
git commit --amend
```

### Migration Failed or Corrupted

**Problem:** Migration command failed or repository is corrupted

**Solution:**
```cmd
# Restore from backup
cd ..
rmdir /s /q LTSB-Add-MicrosoftStore
xcopy /s /e LTSB-Add-MicrosoftStore-BACKUP LTSB-Add-MicrosoftStore

# Try migration again with verbose output
cd LTSB-Add-MicrosoftStore
git lfs migrate import --include="*.appx" --everything --verbose
```

### Bandwidth Quota Exceeded

**Problem:** "Error: batch response: This repository is over its data quota"

**Solution:**
1. Wait until quota resets (monthly)
2. Purchase additional bandwidth from GitHub
3. Use `git lfs fetch --exclude=""` to skip LFS files temporarily

### LFS Commands Not Found

**Problem:** "git: 'lfs' is not a git command"

**Solution:**
```cmd
# Reinstall Git LFS
winget install GitHub.GitLFS

# Initialize for your user
git lfs install
```

### Slow LFS Operations

**Problem:** LFS operations are very slow

**Solution:**
```cmd
# Use concurrent transfers
git config lfs.concurrenttransfers 10

# Increase timeout
git config lfs.activitytimeout 0
```

### Checking LFS Configuration

View all LFS settings:
```cmd
git lfs env
```

View tracked patterns:
```cmd
git lfs track
```

---

## Additional Resources

- **Git LFS Official:** https://git-lfs.github.com/
- **GitHub LFS Docs:** https://docs.github.com/en/repositories/working-with-files/managing-large-files
- **Git LFS Tutorial:** https://github.com/git-lfs/git-lfs/wiki/Tutorial
- **Pricing:** https://docs.github.com/en/billing/managing-billing-for-git-large-file-storage

---

## Summary Checklist

- [ ] Git LFS installed on Windows
- [ ] `git lfs install` run globally
- [ ] `.gitattributes` file configured
- [ ] Existing files migrated to LFS (if needed)
- [ ] Changes pushed to GitHub
- [ ] LFS storage quota checked
- [ ] All collaborators notified of migration

---

**For questions or issues, please open an issue on GitHub.**