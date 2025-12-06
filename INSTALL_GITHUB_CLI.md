# Install GitHub CLI - Alternative Methods

Since `winget` is not available on your system, use one of these methods:

## Method 1: Manual Download (Easiest)

1. **Download GitHub CLI:**
   - Go to: https://github.com/cli/cli/releases/latest
   - Click on `gh_X.XX.X_windows_amd64.msi` (the .msi file)
   - Wait for download to complete

2. **Install:**
   - Double-click the downloaded `.msi` file
   - Click "Next" through the installer
   - Click "Install"
   - Click "Finish"

3. **Restart Command Prompt:**
   - Close any open Command Prompt windows
   - Open a new Command Prompt
   - Test: Type `gh --version` and press Enter

## Method 2: Using PowerShell Direct Download

**Copy this entire block, paste in PowerShell, press Enter:**

```powershell
# Download GitHub CLI installer
$url = "https://github.com/cli/cli/releases/download/v2.40.1/gh_2.40.1_windows_amd64.msi"
$output = "$env:TEMP\gh_installer.msi"
Invoke-WebRequest -Uri $url -OutFile $output

# Run installer
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$output`" /quiet"

# Clean up
Remove-Item $output

Write-Host "GitHub CLI installed! Please restart your Command Prompt."
```

## Method 3: Using Chocolatey (If You Have It)

```cmd
choco install gh
```

## After Installation

**Close and reopen Command Prompt, then continue with EASY_MODE.md at Step 2:**

```cmd
gh auth login
```

## Direct Link

**Download directly:** https://github.com/cli/cli/releases/latest

Look for the `.msi` file and download it.