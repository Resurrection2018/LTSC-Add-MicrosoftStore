# UUP Dump Download Guide - Get StorePurchaseApp

UUP Dump downloads official Microsoft packages directly from Windows Update servers.

---

## Step-by-Step: Download from UUP Dump

### Step 1: Go to UUP Dump Website
Open your browser and visit:
```
https://uupdump.net/
```

### Step 2: Search for Your Build
In the search box at the top of the page, type:
```
19044
```
Press **Enter**

### Step 3: Choose the Right Build
You'll see a list of Windows builds. Look for:
- **"Windows 10"** (not Windows 11)
- **"amd64"** or **"x64"** architecture
- Build number **19044** or **19045**
- Type: **"Feature update"** or **"Cumulative update"**

**Example of what to look for:**
```
Windows 10, version 21H2, build 19044.xxxx amd64
```

Click on one of the **recent** entries (newer is better)

### Step 4: Select Language
On the next page:
- Find **"Language selection"**
- Choose: **"English (United States)"** or your preferred language
- Click **"Next"**

### Step 5: Choose Download Method
You'll see download options. Choose:
- **"Download and convert to ISO"** (downloads everything)
- OR **"Download using aria2 and convert"** (faster)

Click **"Create download package"**

### Step 6: Download the Package
- A small file (`.zip`) will download
- This is the download script, NOT the actual files yet

### Step 7: Extract and Run
1. Extract the downloaded `.zip` file
2. You'll see files like:
   - `uup_download_windows.cmd` (for Windows)
   - `aria2c.exe` (downloader tool)
   - Other config files

3. **Right-click** `uup_download_windows.cmd`
4. Select **"Run as Administrator"**

### Step 8: Wait for Download
The script will:
- Download several GB of Windows files
- This can take 30-60 minutes depending on your internet
- You'll see progress bars

**DO NOT CLOSE THE WINDOW** until it says "Finished" or "Conversion complete"

### Step 9: Find the Packages
After download completes, look in the extracted folder for a subfolder called:
- `UUPs` or 
- `Windows10` or
- Similar name

Inside, search for files containing "StorePurchase"

### Step 10: Copy to Your Packages Folder
Once you find:
```
Microsoft.StorePurchaseApp_<version>_neutral_~_8wekyb3d8bbwe.AppxBundle
```

Copy it to:
```
C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\packages-2021\
```

---

## Alternative: Direct Link Method (If Available)

Some UUP Dump pages show direct download links:

### Step 1-3: Same as above (search 19044, choose build)

### Step 4: Look for Direct Downloads
Instead of "Next", scroll down the page looking for:
- A list of files
- Direct download links

### Step 5: Find StorePurchaseApp
Use **Ctrl+F** to search the page for:
```
StorePurchase
```

### Step 6: Download Directly
If you see a direct link like:
```
Microsoft.StorePurchaseApp_12104.1001.1.0_neutral_~_8wekyb3d8bbwe.AppxBundle
```
Click it to download directly (no need for the conversion script)

---

## What You'll Get from UUP Dump

UUP Dump typically provides:
- ✓ Microsoft.StorePurchaseApp bundle
- ✓ All other Store packages (if you need them)
- ✓ Latest cumulative updates
- ✓ Feature on Demand (FOD) packages

**It's the most complete source!**

---

## Other Reliable Sites

### 1. Microsoft Store Direct (Sometimes Works)
```
ms-windows-store://pdp/?productid=9WZDNCRFJBMP
```
Paste this in Run dialog (Win+R) - might offer Store download

### 2. Microsoft Update Catalog
```
https://www.catalog.update.microsoft.com/
```
Search for: `19044 Store` or `Windows 10 Store`
Download cumulative updates that include Store components

### 3. MSDN Subscriber Downloads (If You Have Access)
```
https://my.visualstudio.com/downloads
```
Official Microsoft source if you have a subscription

---

## Quick Comparison

| Site | Speed | Complete | Easy | Recommended |
|------|-------|----------|------|-------------|
| **store.rg-adguard.net** | ⚡⚡⚡ Fast | ⚠️ Individual files | ✅ Very Easy | For single packages |
| **UUP Dump** | ⚡ Slow | ✅ Everything | ⚠️ Moderate | For complete set |
| **Update Catalog** | ⚡⚡ Medium | ⚠️ In updates | ⚠️ Complex | Advanced users |

---

## My Recommendation

**For just StorePurchaseApp:**
1. Try **store.rg-adguard.net** first (5 minutes)
2. If that fails, use **UUP Dump** (1 hour but guaranteed)

**For complete package set:**
Use **UUP Dump** - you get everything in one download

---

## After You Get the File

Once you have `Microsoft.StorePurchaseApp_*_neutral_~_8wekyb3d8bbwe.AppxBundle`:

```batch
# Move to packages-2021
move "%USERPROFILE%\Downloads\Microsoft.StorePurchaseApp*.AppxBundle" packages-2021\

# Verify 16 files
cd C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master
dir packages-2021\*.appx* | find /c ".appx"

# Should show 12 or more .appx files

# Install!
Add-Store.cmd
```

---

## Troubleshooting UUP Dump

**Q: Script gives error "Access denied"**
A: Run as Administrator

**Q: Download is very slow**
A: Normal for large Windows updates (2-4 GB). Be patient.

**Q: Can't find StorePurchaseApp in downloaded files**
A: Try a different build number (19045 instead of 19044)

**Q: Script stuck or frozen**
A: Wait. It may pause during conversion. Don't close!

---

**UUP Dump official site:** https://uupdump.net/  
**Time required:** 30-60 minutes (mostly download time)  
**Success rate:** Very high - official Microsoft files