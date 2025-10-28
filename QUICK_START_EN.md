# Quick Start Guide

If you just want to quickly compile the exe file, follow these steps:

## Windows Users

### Method 1: Automated Build (Recommended)

1. Install required software:
   - Qt 6.x or Qt 5.15+
   - CMake
   - Visual Studio 2019+

2. Double-click to run:
   ```
   build_windows.bat
   ```

3. After compilation, the exe file will be in the `dist` folder

### Method 2: Quick Build

If Method 1 fails, try:
```
quick_build.bat
```

### Method 3: Manual Build

```cmd
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release
cmake --build . --config Release --target Script-DeployRelease
```

## macOS Users

1. Install required software:
   ```bash
   brew install qt@6 cmake
   ```

2. Run build script:
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

3. After compilation, the app file will be in the `dist` folder

## Common Issues

### Q: Qt not found
A: Add Qt's bin directory to your system PATH environment variable
   - Windows: `C:\Qt\6.5.0\msvc2019_64\bin`
   - macOS: `~/Qt/6.5.0/macos/bin`

### Q: CMake not found
A: Install CMake and add it to PATH
   - Download: https://cmake.org/download/

### Q: Build failed
A: 
1. Check if Visual Studio (Windows) or Xcode (macOS) is installed
2. See detailed BUILD_GUIDE.md documentation
3. Seek help in GitHub Issues

## Create Installer (Windows Only)

1. Download and install Inno Setup: https://jrsoftware.org/isdl.php
2. Open `package\InstallerScript.iss`
3. Click compile
4. Installer will be generated in `package` folder

## Need More Details?

Please refer to:
- `README.md` - Complete project documentation
- `BUILD_GUIDE.md` - Detailed build guide and troubleshooting

## Get Help

If you encounter problems, please visit:
https://github.com/dsus4wang/JiTou-Unlock-NextVersion/issues
