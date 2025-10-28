@echo off
REM Quick Build Script - Simplified version
REM Uses default Visual Studio generator

echo Building JiTou-Unlock-NextVersion...
echo.

if not exist build mkdir build
cd build

echo Configuring...
cmake -DCMAKE_BUILD_TYPE=Release .. || goto :error

echo Building...
cmake --build . --config Release || goto :error

echo Deploying...
cmake --build . --config Release --target Script-DeployRelease

cd ..
echo.
echo ========================================
echo Build completed! Check the dist folder.
echo ========================================
pause
exit /b 0

:error
echo.
echo ========================================
echo Build failed! Please check errors above.
echo ========================================
cd ..
pause
exit /b 1
