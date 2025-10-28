@echo off
REM Windows Build Script for JiTou-Unlock-NextVersion
REM This script automates the build process for Windows

echo ========================================
echo JiTou-Unlock-NextVersion Build Script
echo ========================================
echo.

REM Check if Qt is in PATH
where qmake >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Qt not found in PATH
    echo Please add Qt bin directory to your PATH environment variable
    echo Example: C:\Qt\6.5.0\msvc2019_64\bin
    echo.
    pause
    exit /b 1
)

REM Check if CMake is in PATH
where cmake >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: CMake not found in PATH
    echo Please install CMake and add it to your PATH
    echo.
    pause
    exit /b 1
)

echo [1/4] Creating build directory...
if not exist build (
    mkdir build
)
cd build

echo [2/4] Configuring CMake project...
cmake -G "Ninja" -DCMAKE_BUILD_TYPE=Release ..
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: CMake configuration failed
    echo If Ninja is not available, try using Visual Studio generator:
    echo   cmake -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=Release ..
    echo.
    cd ..
    pause
    exit /b 1
)

echo [3/4] Building project...
cmake --build . --config Release
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Build failed
    cd ..
    pause
    exit /b 1
)

echo [4/4] Deploying Qt dependencies...
cmake --build . --config Release --target Script-DeployRelease
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo WARNING: Deployment may have failed, but executable might still work
    echo You may need to manually run windeployqt
)

cd ..

echo.
echo ========================================
echo Build completed successfully!
echo ========================================
echo.
echo The executable and dependencies are in: dist\
echo Executable name: JiTou-Unlock-NextVersion-master.exe
echo.
echo To create an installer, open package\InstallerScript.iss in Inno Setup
echo.
pause
