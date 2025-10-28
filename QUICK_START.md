# 快速开始指南

如果你只想快速编译出 exe 文件，按照以下步骤操作：

## Windows 用户

### 方法一：自动构建（推荐）

1. 安装必要软件：
   - Qt 6.x 或 Qt 5.15+
   - CMake
   - Visual Studio 2019+

2. 双击运行：
   ```
   build_windows.bat
   ```

3. 编译完成后，exe 文件位于 `dist` 文件夹中

### 方法二：快速构建

如果方法一失败，试试：
```
quick_build.bat
```

### 方法三：手动构建

```cmd
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release
cmake --build . --config Release --target Script-DeployRelease
```

## macOS 用户

1. 安装必要软件：
   ```bash
   brew install qt@6 cmake
   ```

2. 运行构建脚本：
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

3. 编译完成后，app 文件位于 `dist` 文件夹中

## 常见问题

### Q: 提示找不到 Qt
A: 将 Qt 的 bin 目录添加到系统 PATH 环境变量
   - Windows: `C:\Qt\6.5.0\msvc2019_64\bin`
   - macOS: `~/Qt/6.5.0/macos/bin`

### Q: 提示找不到 CMake
A: 安装 CMake 并添加到 PATH
   - 下载地址：https://cmake.org/download/

### Q: 编译失败
A: 
1. 检查是否安装了 Visual Studio（Windows）或 Xcode（macOS）
2. 查看详细的 BUILD_GUIDE.md 文档
3. 在 GitHub Issues 中寻求帮助

## 创建安装程序（仅 Windows）

1. 下载安装 Inno Setup：https://jrsoftware.org/isdl.php
2. 打开 `package\InstallerScript.iss`
3. 点击编译
4. 安装程序生成在 `package` 文件夹

## 需要更详细的说明？

请查看：
- `README.md` - 完整的项目说明
- `BUILD_GUIDE.md` - 详细的编译指南和故障排除

## 获取帮助

如果遇到问题，请访问：
https://github.com/dsus4wang/JiTou-Unlock-NextVersion/issues
