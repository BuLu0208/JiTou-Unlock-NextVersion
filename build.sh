#!/bin/bash
# macOS/Linux Build Script for JiTou-Unlock-NextVersion
# This script automates the build process

set -e

echo "========================================"
echo "JiTou-Unlock-NextVersion Build Script"
echo "========================================"
echo ""

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     PLATFORM=Linux;;
    Darwin*)    PLATFORM=macOS;;
    *)          PLATFORM="UNKNOWN:${OS}"
esac

echo "Detected platform: ${PLATFORM}"
echo ""

# Check if qmake is in PATH
if ! command -v qmake &> /dev/null; then
    echo "ERROR: Qt not found in PATH"
    echo "Please add Qt bin directory to your PATH environment variable"
    if [ "${PLATFORM}" = "macOS" ]; then
        echo "Example: export PATH=\$HOME/Qt/6.5.0/macos/bin:\$PATH"
    else
        echo "Example: export PATH=/opt/Qt/6.5.0/gcc_64/bin:\$PATH"
    fi
    echo ""
    exit 1
fi

# Check if cmake is in PATH
if ! command -v cmake &> /dev/null; then
    echo "ERROR: CMake not found in PATH"
    echo "Please install CMake"
    echo ""
    exit 1
fi

echo "[1/4] Creating build directory..."
mkdir -p build
cd build

echo "[2/4] Configuring CMake project..."
cmake -DCMAKE_BUILD_TYPE=Release ..

echo "[3/4] Building project..."
cmake --build . --config Release

echo "[4/4] Deploying Qt dependencies..."
if cmake --build . --config Release --target Script-DeployRelease 2>/dev/null; then
    echo "Deployment completed successfully"
else
    echo "WARNING: Deployment target not available on this platform"
    echo "You may need to manually deploy Qt dependencies"
fi

cd ..

echo ""
echo "========================================"
echo "Build completed successfully!"
echo "========================================"
echo ""

if [ "${PLATFORM}" = "macOS" ]; then
    echo "The application bundle is in: dist/"
    echo "Application name: JiTou-Unlock-NextVersion-master.app"
else
    echo "The executable and dependencies are in: bin/Release/"
    echo "Executable name: JiTou-Unlock-NextVersion-master"
fi
echo ""
