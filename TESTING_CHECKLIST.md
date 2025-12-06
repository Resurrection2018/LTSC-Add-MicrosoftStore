# Testing Checklist - Microsoft Store Installer for LTSC

This checklist ensures the installer works correctly on both Windows 10 LTSC 2019 and LTSC 2021.

## Pre-Installation Testing

### Environment Verification

#### LTSC 2019 (Build 17763)
- [ ] Verify Windows build: `winver` shows Build 17763
- [ ] Check Windows edition: Enterprise LTSC 2019
- [ ] Verify architecture: x64 or x86
- [ ] Ensure no existing Store installation
- [ ] Administrator privileges available
- [ ] Internet connectivity (for Store activation)

#### LTSC 2021 (Build 19044/19045)
- [ ] Verify Windows build: `winver` shows Build 19044 or 19045
- [ ] Check Windows edition: Enterprise LTSC 2021
- [ ] Verify architecture: x64 or x86
- [ ] Ensure no existing Store installation
- [ ] Administrator privileges available
- [ ] Internet connectivity (for Store activation)

### Package Verification

#### LTSC 2019 Packages
- [ ] All files in `packages-2019\` folder or root directory
- [ ] Microsoft.WindowsStore bundle present
- [ ] Microsoft.WindowsStore XML license present
- [ ] VCLibs x64 and x86 present (14.0.26706.0)
- [ ] .NET Framework 1.6 x64 and x86 present
- [ ] .NET Runtime 1.6 x64 and x86 present
- [ ] Optional: DesktopAppInstaller files
- [ ] Optional: StorePurchaseApp files
- [ ] Optional: XboxIdentityProvider files
- [ ] All packages have valid digital signatures

#### LTSC 2021 Packages
- [ ] All files in `packages-2021\` folder
- [ ] Microsoft.WindowsStore bundle present (newer version)
- [ ] Microsoft.WindowsStore XML license present
- [ ] VCLibs x64 and x86 present (14.0.30704.0+)
- [ ] .NET Framework 2.2+ x64 and x86 present
- [ ] .NET Runtime 2.2+ x64 and x86 present
- [ ] Optional: DesktopAppInstaller files (latest)
- [ ] Optional: StorePurchaseApp files (latest)
- [ ] Optional: XboxIdentityProvider files (latest)
- [ ] All packages have valid digital signatures

## Installation Testing

### Script Execution

#### Initial Run
- [ ] Run `Add-Store.cmd` as Administrator
- [ ] Script correctly detects Windows build number
- [ ] Script displays correct version (LTSC 2019 or 2021)
- [ ] Script shows correct package directory
- [ ] Script shows correct architecture (x64/x86)
- [ ] No errors during version detection

#### Installation Process
- [ ] "Adding Microsoft Store" message appears
- [ ] No error messages during Store installation
- [ ] Dependencies install without errors
- [ ] Optional: Purchase App installs (if included)
- [ ] Optional: App Installer installs (if included)
- [ ] Optional: Xbox Identity installs (if included)
- [ ] "Done" message appears
- [ ] Script completes successfully

### Error Handling Testing

#### Test Error Messages
- [ ] Run without admin rights → Shows "Error: Run as administrator"
- [ ] Run with missing packages → Shows "Error: Required files are missing"
- [ ] Shows correct package directory in error message
- [ ] Shows detected Windows version in error message

#### Version Compatibility
- [ ] LTSC 2019 uses packages-2019 folder
- [ ] LTSC 2021 uses packages-2021 folder
- [ ] Fallback to root directory works (LTSC 2019 backward compatibility)

## Post-Installation Verification

### Store Functionality

#### Basic Store Operations
- [ ] Microsoft Store icon appears in Start Menu
- [ ] Store app launches successfully
- [ ] Store displays initial setup screen
- [ ] Sign in with Microsoft account works
- [ ] Store home page loads
- [ ] Search functionality works
- [ ] App details pages load

#### App Installation
- [ ] Can browse app categories
- [ ] Can search for free apps
- [ ] Can download and install free app
- [ ] Installed app appears in Start Menu
- [ ] Installed app launches correctly
- [ ] App updates work
- [ ] Can uninstall apps

#### Optional Components (if installed)

##### Desktop App Installer / Winget
- [ ] App Installer appears in Apps & Features
- [ ] `winget` command works in PowerShell/CMD
- [ ] Can search packages with winget
- [ ] Can install apps with winget
- [ ] Winget version is appropriate for Windows build

##### Purchase App
- [ ] In-app purchases work (if applicable)
- [ ] Payment methods can be added
- [ ] Purchase flow completes

##### Xbox Identity Provider
- [ ] Xbox services function
- [ ] Can sign in with Xbox account
- [ ] Xbox Game Pass integration works (if subscribed)

### System Integration

- [ ] Store appears in Windows Update (for app updates)
- [ ] Store integrates with Windows Security
- [ ] Store notifications work
- [ ] Store updates itself automatically
- [ ] Store survives system restart
- [ ] Store survives Windows Update

## Troubleshooting Scenarios

### Common Issues Testing

#### Store Won't Launch
- [ ] Test WSReset.exe fix
  ```
  WSReset.exe
  ```
- [ ] Test PowerShell re-registration
  ```powershell
  PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage Microsoft.WindowsStore).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
  ```
- [ ] Verify fix resolves issue after reboot

#### Installation Failures
- [ ] Test with antivirus disabled
- [ ] Test after DISM health check
  ```
  DISM /Online /Cleanup-Image /RestoreHealth
  ```
- [ ] Test after SFC scan
  ```
  sfc /scannow
  ```

#### Updates Not Working
- [ ] Check Windows Update service status
- [ ] Reset Windows Update components
- [ ] Verify internet connectivity

## Regression Testing

### LTSC 2019 Backward Compatibility
- [ ] Original package structure (root directory) still works
- [ ] No breaking changes from version detection
- [ ] All original features work as before
- [ ] Performance is not degraded

### Clean System Testing
- [ ] Test on fresh LTSC 2019 installation
- [ ] Test on fresh LTSC 2021 installation
- [ ] Test with all optional components
- [ ] Test with minimal components (Store only)

## Performance Testing

### Installation Performance
- [ ] Installation completes in reasonable time
- [ ] No excessive CPU usage during installation
- [ ] No excessive memory usage during installation
- [ ] System remains responsive during installation

### Store Performance
- [ ] Store launches in reasonable time
- [ ] Search results appear quickly
- [ ] Downloads proceed at expected speed
- [ ] No memory leaks during extended use

## Security Testing

### Package Integrity
- [ ] All packages signed by Microsoft
- [ ] No tampered packages
- [ ] Digital signatures verified
- [ ] Package versions match expected versions

### System Security
- [ ] Windows Defender doesn't flag installer
- [ ] No security warnings during installation
- [ ] Store app passes SmartScreen checks
- [ ] Installed apps pass security checks

## Documentation Testing

### README Accuracy
- [ ] Instructions match actual behavior
- [ ] All links work correctly
- [ ] Troubleshooting steps effective
- [ ] Chinese translation accurate

### Package Guide
- [ ] Package sources accessible
- [ ] Version numbers accurate
- [ ] Directory structure diagram correct
- [ ] Verification steps work

## Multi-Architecture Testing

### x64 Systems
- [ ] Both x64 and x86 dependencies install
- [ ] Store functions correctly
- [ ] Apps install for both architectures

### x86 Systems (if applicable)
- [ ] Only x86 dependencies install
- [ ] Store functions correctly
- [ ] x86 apps install correctly

## Update/Upgrade Scenarios

### Upgrading from LTSC 2019 to LTSC 2021
- [ ] Uninstall Store from LTSC 2019
- [ ] Perform Windows upgrade to LTSC 2021
- [ ] Install Store using LTSC 2021 packages
- [ ] Verify functionality

### Updating Packages
- [ ] Remove old packages
- [ ] Install newer packages
- [ ] Verify updates work
- [ ] Settings and apps preserved

## Final Acceptance Criteria

### Must Pass
- [x] Version detection works correctly
- [x] Packages install without errors
- [x] Store launches and functions
- [x] Can download and install apps
- [x] Documentation is accurate
- [x] Backward compatibility maintained

### Should Pass
- [ ] All optional components work
- [ ] Troubleshooting steps resolve issues
- [ ] Performance is acceptable
- [ ] Security checks pass

### Nice to Have
- [ ] Winget functionality
- [ ] Xbox integration
- [ ] In-app purchases
- [ ] Automatic updates

## Test Results Template

### Test Environment
**Date:** _______________  
**Tester:** _______________  
**Windows Version:** LTSC 2019 / LTSC 2021 (circle one)  
**Build Number:** _______________  
**Architecture:** x64 / x86 (circle one)

### Test Summary
**Total Tests:** _______________  
**Passed:** _______________  
**Failed:** _______________  
**Skipped:** _______________  

### Critical Failures (if any)
1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

### Notes
____________________________________________________________________________
____________________________________________________________________________
____________________________________________________________________________

### Approval
- [ ] All critical tests passed
- [ ] Known issues documented
- [ ] Ready for deployment

**Approved by:** _______________  
**Date:** _______________

---

**Version:** 1.0  
**Last Updated:** 2025-11-30  
**For:** LTSC-Add-MicrosoftStore Personal Project