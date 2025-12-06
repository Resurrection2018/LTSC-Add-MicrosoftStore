# Complete Walkthrough - Let's Do This Together!

I'll guide you through everything step by step. This should take about 30-45 minutes.

---

## Step 1: Check Your Windows Version (2 minutes)

### What to do:
1. Press `Win + R` on your keyboard
2. Type: `winver`
3. Press Enter

### What you'll see:
A window showing something like:
- "Version 1809 (OS Build **17763**.xxxx)" ← You have **LTSC 2019**
- "Version 21H2 (OS Build **19044**.xxxx)" ← You have **LTSC 2021**
- "Version 21H2 (OS Build **19045**.xxxx)" ← You have **LTSC 2021**

**Write down your build:** ________________

---

## Step 2: Choose Your Organization Method (1 minute)

You have two options:

### Option A: Keep Everything As-Is (Easiest)
✅ **Best if:** You only use LTSC 2019 and want minimal changes
✅ **What happens:** Everything works right now, no file moving needed
➡️ **Skip to Step 4** if you choose this

### Option B: Organize for Both Versions (Recommended)
✅ **Best if:** You might use LTSC 2021 in the future
✅ **What happens:** We'll create folders and organize packages
➡️ **Continue to Step 3** if you choose this

---

## Step 3: Organize Your Files (10 minutes)

**Only do this if you chose Option B above**

### Part A: Create the Folder

Open Command Prompt:
1. Press `Win + R`
2. Type: `cmd`
3. Press Enter

Run these commands:
```batch
cd C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master
mkdir packages-2019
```

### Part B: Move Package Files

**Using File Explorer (Easier):**

1. Navigate to: `C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master`
2. Select ALL these types of files (hold Ctrl while clicking):
   - Files ending in `.AppxBundle`
   - Files ending in `.Appx`
   - Files ending in `.xml`
   
3. **Do NOT select:**
   - `Add-Store.cmd`
   - Any `.md` files (README, QUICKSTART, etc.)

4. Cut the selected files (Ctrl+X)
5. Open the `packages-2019` folder
6. Paste (Ctrl+V)

**Using Commands (Faster):**
```batch
move *.AppxBundle packages-2019\
move *.Appx packages-2019\
move *.xml packages-2019\
```

### Part C: Verify
Your folder should now look like this:
```
LTSC-Add-MicrosoftStore-master/
├── Add-Store.cmd          ← Script here
├── README.md              ← Docs here
├── (other .md files)      ← Docs here
└── packages-2019/         ← Packages here
    ├── Microsoft.WindowsStore_*.AppxBundle
    ├── (all other package files)
```

---

## Step 4: Test the Installer (10 minutes)

### Part A: Run as Administrator

1. Press `Win + X`
2. Click "Command Prompt (Admin)" or "PowerShell (Admin)"
3. Click "Yes" when Windows asks for permission

### Part B: Navigate and Run

Type these commands:
```batch
cd C:\Users\Bladez\Desktop\LTSC-Add-MicrosoftStore-master
Add-Store.cmd
```

### Part C: Watch for This Message

You should see:
```
============================================================
Windows Build: 17763 (LTSC 2019)
Package Directory: packages-2019    OR    .
Architecture: x64
============================================================
```

### Part D: Watch Installation Progress

You'll see these messages appear one by one:
```
Adding Microsoft Store
Adding Store Purchase App
Adding App Installer
Adding Xbox Identity Provider
Done
```

### If You See Errors:
- "Run as administrator" → Right-click script, choose "Run as administrator"
- "Required files missing" → Check that packages are in correct folder
- Other errors → Note the message and we'll troubleshoot

---

## Step 5: Restart Your Computer (2 minutes)

**This is important!** The Store needs a restart to work properly.

1. Close all programs
2. Click Start → Power → Restart

---

## Step 6: Test Microsoft Store (15 minutes)

### Part A: Open the Store

After restart:
1. Click Start Menu
2. Find and click "Microsoft Store"

### Part B: Sign In (Optional)

- Sign in with your Microsoft account
- Or click "Maybe later" to browse without signing in

### Part C: Test These Features

**Test 1: Search Works**
- Click the search box at the top
- Type: "calculator"
- You should see results

**Test 2: Browse Works**
- Click "Apps" in the menu
- Browse different categories
- Apps should load

**Test 3: Download an App (Optional)**
- Search for "Windows Terminal" or "Ubuntu"
- Click "Get" or "Install"
- Wait for download
- Check Start Menu for the new app

### If Store Won't Open - Quick Fixes

**Fix #1: Reset Store Cache**
1. Press `Win + R`
2. Type: `WSReset.exe`
3. Press Enter
4. Wait for black window to close
5. Store should open automatically

**Fix #2: Reboot Again**
Sometimes it just needs another restart.

**Fix #3: Re-register Store**
In PowerShell (Admin):
```powershell
PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage Microsoft.WindowsStore).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
```
Then restart again.

---

## Frequently Asked Questions

**Q: Why did we update the script?**
A: To support Windows 10 LTSC 2021 automatically while keeping LTSC 2019 working.

**Q: Will my existing setup still work?**
A: Yes! 100% backward compatible. If you kept files in root directory, it still works.

**Q: Do I need to do anything for LTSC 2021?**
A: Not unless you upgrade to LTSC 2021. Then you'll need new packages.

**Q: Where do I get LTSC 2021 packages?**
A: See [`PACKAGE_GUIDE.md`](PACKAGE_GUIDE.md:1) - it lists multiple sources.

**Q: Can I undo these changes?**
A: Yes! Just move package files back to root directory.

**Q: What if Store crashes?**
A: Try the three fixes in Step 6 above.

---

## Success Checklist

Mark these off as you complete them:

### Installation
- [ ] Checked Windows version
- [ ] Organized files (or kept as-is)
- [ ] Ran installer as Administrator
- [ ] Saw "Done" message
- [ ] Restarted computer

### Testing
- [ ] Microsoft Store appears in Start Menu
- [ ] Store opens without errors
- [ ] Can search for apps
- [ ] Can browse categories
- [ ] Downloaded a test app (optional)

### All Done?
If you checked all boxes above: **Congratulations! You're finished!** 🎉

---

## What to Do Next

### You're on LTSC 2019
✅ You're all set! Use the Store normally.
✅ Keep this folder for future reference.

### You're Planning to Upgrade to LTSC 2021
1. Keep your organized structure
2. When you upgrade, visit [`PACKAGE_GUIDE.md`](PACKAGE_GUIDE.md:1)
3. Download LTSC 2021 packages
4. Put them in `packages-2021\` folder
5. Run the script again - it auto-detects!

---

## Need More Help?

### Quick Answers
- Start here: [`QUICKSTART.md`](QUICKSTART.md:1)
- Full details: [`README.md`](README.md:1)

### Specific Topics
- Finding packages: [`PACKAGE_GUIDE.md`](PACKAGE_GUIDE.md:1)
- Testing checklist: [`TESTING_CHECKLIST.md`](TESTING_CHECKLIST.md:1)
- Technical details: [`UPGRADE_PLAN.md`](UPGRADE_PLAN.md:1)

### Still Stuck?
Just ask! Tell me:
1. What step you're on
2. What happened
3. Any error messages you saw

I'm here to help you through every step! 😊

---

**Total Time:** 30-45 minutes  
**Difficulty:** Beginner-friendly  
**Last Updated:** 2025-11-30