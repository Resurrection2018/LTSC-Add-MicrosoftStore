# Add Store to Windows 10/11 Enterprise LTSC
For Windows 10 Enterprise LTSC 2019, 2021 & Windows 11 Enterprise LTSC 2024

## Supported Versions
- **Windows 10 LTSC 2019** (Build 17763)
- **Windows 10 LTSC 2021** (Build 19044/19045)
- **Windows 11 LTSC 2024** (Build 26100)

The script automatically detects your Windows version and uses the appropriate packages.

## Installation

### Quick Start
1. Download the appropriate package files for your LTSC version (see Package Requirements below)
2. Place them in the correct folder structure:
   - LTSC 2019: Either in `packages-2019\` folder or the root directory
   - LTSC 2021: In `packages-2021\` folder
   - LTSC 2024: In `packages-2024\` folder
3. Run `Add-Store.cmd` as Administrator

### Detailed Steps
**Optional Components:**
If you do not want App Installer / Purchase App / Xbox Identity, you can delete the corresponding `.appxbundle` files before running the installer. However, if you plan on installing games or any app with in-app purchase options, keep all components.

**If the Store doesn't function after installation:**
1. Reboot your computer
2. If still not working, open Command Prompt as Administrator and run:
   ```
   PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage Microsoft.WindowsStore).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
   ```
3. Reboot once more

## Package Requirements

### For LTSC 2019 (Build 17763)
Place files in `packages-2019\` folder or root directory:
- Microsoft.WindowsStore (AppxBundle + XML)
- Microsoft.VCLibs.140.00 (x64 & x86 .appx)
- Microsoft.NET.Native.Framework.1.6 (x64 & x86 .appx)
- Microsoft.NET.Native.Runtime.1.6 (x64 & x86 .appx)
- Optional: StorePurchaseApp, DesktopAppInstaller, XboxIdentityProvider

### For LTSC 2021 (Build 19044/19045)
Place files in `packages-2021\` folder:
- Microsoft.WindowsStore (AppxBundle + XML) - **Updated version**
- Microsoft.VCLibs.140.00 (**newer version: 14.0.30704.0+**)
- Microsoft.NET.Native.Framework (**version 2.2+**)
- Microsoft.NET.Native.Runtime (**version 2.2+**)
- Optional: StorePurchaseApp, DesktopAppInstaller, XboxIdentityProvider

### For LTSC 2024 (Build 26100) - Windows 11
Place files in `packages-2024\` folder:
- Microsoft.WindowsStore (AppxBundle + XML) - **Latest version**
- Microsoft.VCLibs.140.00 (**version 14.0.33519.0+**)
- Microsoft.NET.Native.Framework (**version 2.2+**)
- Microsoft.NET.Native.Runtime (**version 2.2+**)
- Microsoft.UI.Xaml.2.8 (x64 & x86 .appx) - **Required for Windows 11**
- Optional: StorePurchaseApp, DesktopAppInstaller, XboxIdentityProvider

**Note:** Package files are not included in this repository. For personal use, you can:
- Extract from official Windows ISO images
- Use UUP Dump to download official packages
- Check MDL forums for package sources
- See [GET_LTSC_2024_PACKAGES.md](GET_LTSC_2024_PACKAGES.md) for Windows 11 extraction guide

## Git LFS Support

⚠️ **Important for GitHub Users:** This repository uses Git LFS (Large File Storage) to manage package files.

### What You Need to Know

**If you're cloning this repository:**
```cmd
# Install Git LFS first (one-time setup)
winget install GitHub.GitLFS
git lfs install

# Clone normally - LFS files download automatically
git clone https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore.git
```

**If you're contributing or forking:**
- Git LFS is required to work with package files
- Package files (`.appx`, `.appxbundle`, `.msixbundle`) are stored in LFS
- The repository automatically tracks these files via [`.gitattributes`](.gitattributes)
- See [GIT_LFS_SETUP.md](GIT_LFS_SETUP.md) for complete setup and migration guide

**Storage Considerations:**
- Free GitHub accounts include 1 GB LFS storage and 1 GB bandwidth/month
- This repository contains ~4-6 GB of package files across all LTSC versions
- Consider keeping only the packages you need to stay within free tier limits
- See [GIT_LFS_SETUP.md](GIT_LFS_SETUP.md) for storage optimization strategies

**Why Git LFS?**
- Package files are 50-150 MB each (exceed GitHub's 100 MB limit)
- Git LFS stores large files efficiently outside Git history
- Keeps repository operations fast and lightweight
- Enables version control for all package files

📖 **Full Documentation:** [GIT_LFS_SETUP.md](GIT_LFS_SETUP.md)

## Troubleshooting

### Store Won't Open or Crashes
1. **Clear Store Cache:**
   - Press `Win+R`
   - Type: `WSReset.exe`
   - Press Enter
   
2. **Re-register Store:**
   ```
   PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage Microsoft.WindowsStore).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
   ```

### Installation Fails
- Ensure you're running as Administrator
- Check that all required dependency files are present
- Verify you're using packages for your Windows build version
- Disable antivirus temporarily during installation

### Version-Specific Issues

**LTSC 2019:**
- May need to ensure older .NET Native Framework 1.6 packages
- Store version should be from 2019 timeframe

**LTSC 2021:**
- Requires newer dependency versions
- Older packages from LTSC 2019 may not work
- Ensure VCLibs 14.0.30704.0 or newer
  
---

# 为Windows 10/11 Enterprise LTSC增加应用商店
适用于Windows 10 Enterprise LTSC 2019、2021 和 Windows 11 Enterprise LTSC 2024

## 支持的版本
- **Windows 10 LTSC 2019** (版本号 17763)
- **Windows 10 LTSC 2021** (版本号 19044/19045)
- **Windows 11 LTSC 2024** (版本号 26100)

脚本会自动检测您的Windows版本并使用相应的安装包。

## 安装说明

### 快速开始
1. 下载适合您LTSC版本的安装包文件（见下方安装包要求）
2. 将文件放置在正确的文件夹结构中：
   - LTSC 2019: 放在 `packages-2019\` 文件夹或根目录
   - LTSC 2021: 放在 `packages-2021\` 文件夹
   - LTSC 2024: 放在 `packages-2024\` 文件夹
3. 以管理员身份运行 `Add-Store.cmd`

### 详细步骤
**可选组件：**
如果您不想安装App Installer / Purchase App / Xbox，请在运行安装之前删除对应的 `.appxbundle` 文件。但是，如果您计划安装游戏或带有内购的应用，请保留所有组件。

**如果安装后商店无法使用：**
1. 重启计算机
2. 如果仍然不行，以管理员身份打开命令提示符并运行：
   ```
   PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage Microsoft.WindowsStore).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
   ```
3. 再次重启

## 安装包要求

### LTSC 2019 (版本号 17763)
将文件放在 `packages-2019\` 文件夹或根目录：
- Microsoft.WindowsStore (AppxBundle + XML)
- Microsoft.VCLibs.140.00 (x64 和 x86 .appx)
- Microsoft.NET.Native.Framework.1.6 (x64 和 x86 .appx)
- Microsoft.NET.Native.Runtime.1.6 (x64 和 x86 .appx)
- 可选：StorePurchaseApp、DesktopAppInstaller、XboxIdentityProvider

### LTSC 2021 (版本号 19044/19045)
将文件放在 `packages-2021\` 文件夹：
- Microsoft.WindowsStore (AppxBundle + XML) - **更新版本**
- Microsoft.VCLibs.140.00 (**更新版本：14.0.30704.0+**)
- Microsoft.NET.Native.Framework (**版本 2.2+**)
- Microsoft.NET.Native.Runtime (**版本 2.2+**)
- 可选：StorePurchaseApp、DesktopAppInstaller、XboxIdentityProvider

### LTSC 2024 (版本号 26100) - Windows 11
将文件放在 `packages-2024\` 文件夹：
- Microsoft.WindowsStore (AppxBundle + XML) - **最新版本**
- Microsoft.VCLibs.140.00 (**版本 14.0.33519.0+**)
- Microsoft.NET.Native.Framework (**版本 2.2+**)
- Microsoft.NET.Native.Runtime (**版本 2.2+**)
- Microsoft.UI.Xaml.2.8 (x64 和 x86 .appx) - **Windows 11必需**
- 可选：StorePurchaseApp、DesktopAppInstaller、XboxIdentityProvider

**注意：** 此仓库不包含安装包文件。个人使用可以通过以下方式获取：
- 从官方Windows ISO镜像中提取
- 使用UUP Dump下载官方安装包
- 查看MDL论坛获取安装包来源
- 参阅 [GET_LTSC_2024_PACKAGES.md](GET_LTSC_2024_PACKAGES.md) 了解 Windows 11 提取指南

## Git LFS 支持

⚠️ **GitHub 用户注意：** 此仓库使用 Git LFS（大文件存储）来管理安装包文件。

### 需要了解的信息

**如果您要克隆此仓库：**
```cmd
# 首先安装 Git LFS（一次性设置）
winget install GitHub.GitLFS
git lfs install

# 正常克隆 - LFS 文件会自动下载
git clone https://github.com/YOUR_USERNAME/LTSB-Add-MicrosoftStore.git
```

**如果您要贡献或分叉此仓库：**
- 需要 Git LFS 才能处理安装包文件
- 安装包文件（`.appx`、`.appxbundle`、`.msixbundle`）存储在 LFS 中
- 仓库通过 [`.gitattributes`](.gitattributes) 自动跟踪这些文件
- 查看 [GIT_LFS_SETUP.md](GIT_LFS_SETUP.md) 了解完整的设置和迁移指南

**存储注意事项：**
- 免费 GitHub 账户包含 1 GB LFS 存储空间和 1 GB/月带宽
- 此仓库包含所有 LTSC 版本约 4-6 GB 的安装包文件
- 考虑只保留您需要的安装包以保持在免费额度内
- 查看 [GIT_LFS_SETUP.md](GIT_LFS_SETUP.md) 了解存储优化策略

**为什么使用 Git LFS？**
- 安装包文件每个 50-150 MB（超过 GitHub 100 MB 限制）
- Git LFS 在 Git 历史记录之外高效存储大文件
- 保持仓库操作快速轻量
- 为所有安装包文件启用版本控制

📖 **完整文档：** [GIT_LFS_SETUP.md](GIT_LFS_SETUP.md)

## 故障排除

### 商店无法打开或崩溃
1. **清除商店缓存：**
   - 按 `Win+R`
   - 输入：`WSReset.exe`
   - 按回车
   
2. **重新注册商店：**
   ```
   PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage Microsoft.WindowsStore).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
   ```

### 安装失败
- 确保以管理员身份运行
- 检查所有必需的依赖文件是否存在
- 验证使用的安装包与您的Windows版本匹配
- 安装期间临时禁用杀毒软件

### 版本特定问题

**LTSC 2019：**
- 需要确保使用旧版 .NET Native Framework 1.6 安装包
- 商店版本应为2019年发布的版本

**LTSC 2021：**
- 需要更新的依赖项版本
- LTSC 2019的旧安装包可能无法使用
- 确保使用 VCLibs 14.0.30704.0 或更新版本

---
  
## 致谢

原始脚本由 abbodi1406 贡献：
https://forums.mydigitallife.net/threads/add-store-to-windows-10-enterprise-ltsc-LTSC.70741/page-30#post-1468779

LTSC 2021 和 LTSC 2024 (Windows 11) 更新支持由个人维护。
