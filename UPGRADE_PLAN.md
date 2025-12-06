# Upgrade Plan: Microsoft Store Installer for Windows 10 LTSC 2021

## Executive Summary
This document outlines the plan to update the LTSC-Add-MicrosoftStore project to support Windows 10 LTSC 2021 (build 19044/19045) while maintaining backward compatibility with LTSC 2019 (build 17763).

## Current State Analysis

### Existing Implementation
- **Target OS**: Windows 10 LTSC 2019 (build 17763)
- **Minimum Build Check**: Build 16299 (line 2 of Add-Store.cmd)
- **Components**:
  - Microsoft Store: 11809.1001.713.0
  - VCLibs: 14.0.26706.0
  - .NET Native Framework: 1.6.24903.0
  - .NET Native Runtime: 1.6.24903.0
  - Desktop App Installer: 1.6.29000.1000
  - Purchase App: 11808.1001.413.0
  - Xbox Identity Provider: 12.45.6001.0

### Current Limitations
- No version detection beyond minimum build
- Single package set (2019 versions only)
- May not be compatible with LTSC 2021 requirements

## Target State: LTSC 2021 Support

### Windows 10 LTSC 2021 Details
- **Build Numbers**: 19044 (initial) or 19045 (with updates)
- **Base Version**: Windows 10 21H2
- **Release Date**: November 2021
- **Support Lifecycle**: Extended support through January 2027
- **Key Requirements**: Newer package versions and dependency updates

## Architectural Design

### Version Detection Flow

```
User runs Add-Store.cmd
    ↓
Detect Windows Build Number
    ↓
Build 17763? → Use LTSC 2019 packages
Build 19044/19045? → Use LTSC 2021 packages
Other supported builds? → Check compatibility
Unsupported? → Display error
    ↓
Install Store with appropriate packages
    ↓
Success
```

### Project Structure Options

#### Option A: Unified Installer (Recommended)
```
LTSC-Add-MicrosoftStore/
├── Add-Store.cmd (enhanced with version detection)
├── packages-2019/
│   ├── Microsoft.WindowsStore_*.appxbundle
│   ├── Microsoft.VCLibs*.appx
│   └── ... (other 2019 packages)
├── packages-2021/
│   ├── Microsoft.WindowsStore_*.appxbundle
│   ├── Microsoft.VCLibs*.appx
│   └── ... (other 2021 packages)
├── *.xml (license files - may be version-specific)
└── README.md (updated for both versions)
```

**Pros:**
- Single repository
- Automatic version selection
- Better user experience
- Easier maintenance of shared components

**Cons:**
- Larger repository size
- Need to maintain two package sets

#### Option B: Separate Branches
```
Branch: 2019
  └── Current structure

Branch: 2021
  └── LTSC 2021 specific packages
```

**Pros:**
- Cleaner organization
- Smaller individual downloads
- Clear separation

**Cons:**
- Duplicate maintenance
- Users must manually select version
- Documentation scattered

**Decision: Option A** - Better user experience and maintainability

## Required Package Updates

### Package Version Research Needed

| Component | LTSC 2019 Version | LTSC 2021 Version (TBD) |
|-----------|-------------------|-------------------------|
| Microsoft Store | 11809.1001.713.0 | Research needed |
| VCLibs | 14.0.26706.0 | 14.0.30704.0+ |
| .NET Native Framework | 1.6.24903.0 | 2.2.x (likely) |
| .NET Native Runtime | 1.6.24903.0 | 2.2.x (likely) |
| Desktop App Installer | 1.6.29000.1000 | Latest version |
| Purchase App | 11808.1001.413.0 | Research needed |
| Xbox Identity | 12.45.6001.0 | Research needed |

### Compatibility Research
- Determine if newer packages work on both versions
- Identify minimum package versions for LTSC 2021
- Test backward compatibility scenarios

## Implementation Plan

### Phase 1: Research & Documentation
**Todo Items 1-3**

1. Research current Microsoft Store package versions
   - Check Microsoft's official channels
   - Review LTSC 2021 documentation
   - Identify package sources

2. Document build differences
   - LTSC 2019: Build 17763
   - LTSC 2021: Builds 19044/19045
   - Feature set differences

3. Identify dependency versions
   - Updated VCLibs requirements
   - .NET Native Framework/Runtime versions
   - Any new dependencies

### Phase 2: Script Development
**Todo Items 4-7**

4. Design version detection logic
   ```batch
   for /f "tokens=3" %%i in ('ver') do set "build=%%i"
   set "build=%build:~0,-1%"
   
   if %build% equ 17763 (set "version=2019")
   if %build% geq 19044 if %build% leq 19045 (set "version=2021")
   ```

5. Update Add-Store.cmd
   - Implement build detection
   - Add version-specific package paths
   - Enhance error messages
   - Add logging/verbose mode

6. Research package compatibility
   - Test newer packages on LTSC 2019
   - Identify any breaking changes
   - Document compatibility matrix

7. Package organization strategy
   - Implement folder structure
   - Update file discovery logic
   - Create version-specific install paths

### Phase 3: Documentation
**Todo Items 8-11**

8. Update README.md
   - Add LTSC 2021 section
   - Update system requirements
   - Add version detection info
   - Include both download links

9. LTSC 2021 troubleshooting
   - Common installation issues
   - Version-specific fixes
   - Known incompatibilities
   - WSReset and re-registration

10. Update Chinese translation
    - Mirror English updates
    - Ensure technical accuracy
    - Version-specific terminology

11. Package acquisition documentation
    - Legal considerations (cannot redistribute)
    - Official Microsoft sources
    - UUP dump alternatives
    - Version verification steps

### Phase 4: Validation
**Todo Item 12**

12. Testing checklist
    - LTSC 2019 compatibility (regression testing)
    - LTSC 2021 new functionality
    - Version detection accuracy
    - Package installation success
    - Store functionality post-install
    - Edge cases and error handling

## Expected Deliverables

1. **Updated Add-Store.cmd**
   - Multi-version support
   - Enhanced error handling
   - Better user feedback

2. **Package Acquisition Guide**
   - Step-by-step instructions
   - Verification procedures
   - Legal compliance notes

3. **Comprehensive README.md**
   - Both LTSC 2019 and 2021 instructions
   - Clear version detection info
   - Updated troubleshooting

4. **Testing Documentation**
   - Validation procedures
   - Known issues list
   - Compatibility matrix

5. **UPGRADE_GUIDE.md** (optional)
   - Migration from 2019 to 2021
   - What to expect
   - Troubleshooting upgrades

## Critical Considerations

### Licensing & Distribution
⚠️ **Cannot redistribute Microsoft AppX packages**
- Packages must be downloaded by end users
- Provide clear instructions for obtaining packages
- Include checksums for verification
- Link to official Microsoft sources when available

### Version Compatibility
⚠️ **Testing on both versions is essential**
- Some newer packages may work on older builds
- Backward compatibility cannot be assumed
- Document tested configurations

### Script Robustness
⚠️ **Enhanced error handling needed**
- Clear error messages for each failure point
- Version mismatch warnings
- Missing file detection by version
- Rollback capability considerations

## Timeline Estimate

- **Phase 1 (Research)**: 2-3 hours research time
- **Phase 2 (Development)**: 1-2 hours scripting
- **Phase 3 (Documentation)**: 1-2 hours writing
- **Phase 4 (Testing)**: Requires access to both OS versions

**Total Effort**: 4-7 hours (excluding testing on actual hardware)

## Success Criteria

- ✅ Script correctly detects LTSC 2019 vs 2021
- ✅ Appropriate packages selected per version
- ✅ Successful Store installation on both versions
- ✅ Backward compatibility maintained
- ✅ Clear documentation for both versions
- ✅ No regressions in LTSC 2019 functionality

## Next Steps

1. Approve this architectural plan
2. Begin Phase 1: Research current package versions
3. Document findings
4. Proceed to script development
5. Update documentation
6. Create testing guidelines

---

**Prepared by**: Roo (Architect Mode)  
**Date**: 2025-11-30  
**Status**: Awaiting approval