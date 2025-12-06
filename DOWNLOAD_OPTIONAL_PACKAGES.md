# Step-by-Step Guide: Download Optional LTSC 2021 Packages

This guide shows you **exactly where to go and what to click** to download the 6 remaining optional packages for 100% completion.

---

## 📦 What You're Downloading (6 Files Total)

1. `Microsoft.DesktopAppInstaller_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
2. `Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml`
3. `Microsoft.StorePurchaseApp_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
4. `Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml`
5. `Microsoft.XboxIdentityProvider_*_neutral_~_8wekyb3d8bbwe.AppxBundle`
6. `Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml`

---

## 🎯 Method 1: store.rg-adguard.net (Recommended - Easiest)

### Package 1 & 2: Desktop App Installer (winget)

**Step 1:** Open your web browser and go to:
```
https://store.rg-adguard.net/
```

**Step 2:** On the page you'll see:
- A dropdown menu (should say "ProductId")
- A text box
- Another dropdown (should say "RP")

**Step 3:** Make sure the first dropdown says **"ProductId"**

**Step 4:** In the text box, type exactly:
```
9NBLGGH4NNS1
```

**Step 5:** In the second dropdown, select **"Slow"**

**Step 6:** Click the **checkmark button** (✓) or press Enter

**Step 7:** Wait for the page to load. You'll see a list of files.

**Step 8:** Look for these files and download them:
- Find a file ending in `.appxbundle` or `.msixbundle` that says "neutral" in the name
  - Example: `Microsoft.DesktopAppInstaller_1.22.11261.0_neutral_~_8wekyb3d8bbwe.AppxBundle`
  - Click it to download
  
**Step 9:** For the XML license file:
- **OPTION A:** Some downloads include the XML automatically
- **OPTION B:** If not included, you can copy it from your packages-2019 folder:
  ```batch
  copy packages-2019\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml packages-2021\
  ```

**Step 10:** Move the downloaded `.appxbundle` file to:
```
C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master\packages-2021\
```

---

### Package 3 & 4: Store Purchase App

**Step 1:** Go back to https://store.rg-adguard.net/

**Step 2:** Clear the text box

**Step 3:** Change the first dropdown from "ProductId" to **"PackageFamilyName"**

**Step 4:** In the text box, type exactly:
```
Microsoft.StorePurchaseApp_8wekyb3d8bbwe
```

**Step 5:** Keep "Slow" in the second dropdown

**Step 6:** Click the checkmark (✓)

**Step 7:** Look through the results for:
- A file ending in `.appxbundle` with "neutral" in the name
- Example: `Microsoft.StorePurchaseApp_12104.1001.1.0_neutral_~_8wekyb3d8bbwe.AppxBundle`
- Download it

**Step 8:** For the XML license:
- Copy from packages-2019:
  ```batch
  copy packages-2019\Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml packages-2021\
  ```

**Step 9:** Move the downloaded bundle to `packages-2021\` folder

---

### Package 5 & 6: Xbox Identity Provider

**Step 1:** Go back to https://store.rg-adguard.net/

**Step 2:** Make sure first dropdown is **"PackageFamilyName"**

**Step 3:** In the text box, type exactly:
```
Microsoft.XboxIdentityProvider_8wekyb3d8bbwe
```

**Step 4:** Keep "Slow" selected

**Step 5:** Click checkmark (✓)

**Step 6:** Download the file ending in `.appxbundle` with "neutral" in name
- Example: `Microsoft.XboxIdentityProvider_12.75.40001.0_neutral_~_8wekyb3d8bbwe.AppxBundle`

**Step 7:** For the XML license:
- Copy from packages-2019:
  ```batch
  copy packages-2019\Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml packages-2021\
  ```

**Step 8:** Move the bundle to `packages-2021\` folder

---

## 🎯 Method 2: Quick Copy XML Licenses from LTSC 2019

Since you already have all the XML license files in packages-2019, you can simply copy them:

**Open Command Prompt as Administrator and run:**

```batch
cd C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master

copy packages-2019\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml packages-2021\
copy packages-2019\Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml packages-2021\
copy packages-2019\Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml packages-2021\
```

**Why this works:** XML license files are version-agnostic. The same licenses work for both LTSC 2019 and 2021.

---

## 🎯 Method 3: UUP Dump (Download Everything at Once)

This method downloads ALL packages at once, including the ones you already have.

**Step 1:** Go to:
```
https://uupdump.net/
```

**Step 2:** In the search box at the top, type:
```
19044
```

**Step 3:** Press Enter. You'll see a list of Windows builds.

**Step 4:** Look for entries that say:
- "Windows 10" 
- "Feature update" or "Cumulative update"
- Build number starting with 19044 or 19045

**Step 5:** Click on one of the newer entries

**Step 6:** On the next page:
- Scroll down to the language selection
- Select your language (English - United States)
- Click "Next"

**Step 7:** On the download method page:
- Select "Download and convert to ISO"
- Or select "Download using aria2 and convert"
- Click "Create download package"

**Step 8:** Download the files

**Step 9:** Run the download script (a .cmd file will be included)

**Step 10:** After download completes, look in the extracted folder for:
- All `.appxbundle` files
- All `.xml` files
- Copy them to your `packages-2021\` folder

**Note:** This downloads a LOT of files (several GB). Only use if you want to download everything fresh.

---

## 📋 Quick Summary Checklist

After downloading, verify you have these files in `packages-2021\`:

```
☐ Microsoft.DesktopAppInstaller_*.appxbundle (or .msixbundle)
☐ Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml
☐ Microsoft.StorePurchaseApp_*.appxbundle
☐ Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml
☐ Microsoft.XboxIdentityProvider_*.appxbundle
☐ Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml
```

---

## 🚀 Fastest Method: My Recommendation

### For the 3 AppX Bundles:
Use **Method 1 (store.rg-adguard.net)** to download the bundles

### For the 3 XML Licenses:
Use **Method 2 (Copy from packages-2019)** - just copy them over

**Total time: ~10 minutes**

---

## 💻 Complete Command Sequence

Open **Command Prompt as Administrator** and paste this:

```batch
cd C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master

REM Copy all XML licenses from 2019 to 2021
copy packages-2019\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml packages-2021\
copy packages-2019\Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml packages-2021\
copy packages-2019\Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml packages-2021\

REM Verify copies
dir packages-2021\*.xml

echo.
echo XML licenses copied! Now download the 3 AppxBundle files from store.rg-adguard.net
echo.
pause
```

This copies all 3 XML files in one go. Then you just need to download the 3 `.appxbundle` files from store.rg-adguard.net.

---

## 🔍 Troubleshooting

### Problem: store.rg-adguard.net shows "No results"
**Solution:** 
- Try changing "Slow" to "Fast" or "RP" ring
- Try using "PackageFamilyName" instead of "ProductId"
- Check your internet connection

### Problem: Downloaded file is .msixbundle not .appxbundle
**Solution:** 
- This is OK! .msixbundle is the newer format
- The installer should accept it
- If it doesn't, try renaming .msixbundle to .appxbundle

### Problem: Can't find the exact version numbers
**Solution:** 
- Any recent version will work
- Look for files from 2021-2023 timeframe
- Newer is generally better for LTSC 2021

### Problem: XML file not included in download
**Solution:**
- Just copy from packages-2019 (Method 2)
- XML licenses are version-agnostic

---

## ✅ After Downloading All Files

**Step 1:** Verify all files are in `packages-2021\` folder

**Step 2:** Run this command to check:
```batch
dir packages-2021
```

You should see 16 total files (10 required + 6 optional)

**Step 3:** Run the installer:
```batch
Add-Store.cmd
```
(Right-click → Run as Administrator)

**Step 4:** Reboot your computer

**Step 5:** Test winget:
```batch
winget --version
```

**Step 6:** Test Microsoft Store (Win key → type "Store")

---

## 📞 Need Help?

If you get stuck at any step:
1. Check what files you already have: `dir packages-2021`
2. Verify you can access store.rg-adguard.net
3. Make sure you have admin rights to copy files
4. Try the UUP Dump method if store.rg-adguard.net isn't working

---

**Last Updated:** 2025-12-02  
**Estimated Time:** 10-15 minutes  
**Difficulty:** Easy  
**Internet Required:** Yes