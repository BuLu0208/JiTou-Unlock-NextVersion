# 详细编译指南 / Detailed Build Guide

本指南提供了 JiTou-Unlock-NextVersion 项目的详细编译说明。

## 目录
- [前置要求](#前置要求)
- [快速开始](#快速开始)
- [详细步骤](#详细步骤)
- [故障排除](#故障排除)
- [高级配置](#高级配置)

## 前置要求

### 1. 安装 Qt

#### Windows
下载并安装 Qt：https://www.qt.io/download

推荐版本：
- Qt 5.15.2 或更高
- Qt 6.5.0 或更高

安装时确保选择以下组件：
- Desktop (MSVC 2019 64-bit 或 MinGW)
- Qt Quick Controls 2
- Qt Svg

#### macOS
```bash
# 使用 Homebrew 安装
brew install qt@6

# 或从官网下载安装包
# https://www.qt.io/download
```

### 2. 安装 CMake

#### Windows
从 https://cmake.org/download/ 下载安装包

#### macOS
```bash
brew install cmake
```

### 3. 安装编译器

#### Windows
- Visual Studio 2019 或更高版本
- 或 MinGW-w64

#### macOS
```bash
xcode-select --install
```

## 快速开始

### Windows
```cmd
# 双击运行以下任一脚本
quick_build.bat        # 快速构建
build_windows.bat      # 完整构建（推荐）
```

### macOS/Linux
```bash
chmod +x build.sh
./build.sh
```

## 详细步骤

### 第一步：克隆仓库
```bash
git clone https://github.com/dsus4wang/JiTou-Unlock-NextVersion.git
cd JiTou-Unlock-NextVersion
```

### 第二步：配置环境变量

#### Windows
将 Qt 和 CMake 添加到 PATH：
```cmd
set PATH=C:\Qt\6.5.0\msvc2019_64\bin;%PATH%
set PATH=C:\Program Files\CMake\bin;%PATH%
```

#### macOS/Linux
```bash
export PATH=$HOME/Qt/6.5.0/macos/bin:$PATH
# 或
export PATH=/opt/Qt/6.5.0/gcc_64/bin:$PATH
```

### 第三步：创建构建目录
```bash
mkdir build
cd build
```

### 第四步：配置项目

#### Windows (Visual Studio)
```cmd
cmake -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=Release ..
```

#### Windows (Ninja - 更快)
```cmd
cmake -G "Ninja" -DCMAKE_BUILD_TYPE=Release ..
```

#### Windows (MinGW)
```cmd
cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release ..
```

#### macOS/Linux
```bash
cmake -DCMAKE_BUILD_TYPE=Release ..
```

### 第五步：编译
```bash
cmake --build . --config Release
```

编译时间取决于您的计算机性能，通常需要 5-15 分钟。

### 第六步：部署 Qt 依赖
```bash
cmake --build . --config Release --target Script-DeployRelease
```

这一步会：
- 复制必要的 Qt DLL/库
- 复制 Qt 插件
- 创建完整的可分发包到 `dist` 目录

### 第七步：运行程序

#### Windows
```cmd
cd ..\dist
JiTou-Unlock-NextVersion-master.exe
```

#### macOS
```bash
cd ../dist
open JiTou-Unlock-NextVersion-master.app
```

## 创建安装程序

### Windows 安装程序（使用 Inno Setup）

1. 下载安装 Inno Setup: https://jrsoftware.org/isdl.php
2. 打开 `package/InstallerScript.iss`
3. 点击 Build -> Compile
4. 安装程序将生成在 `package` 目录

安装程序将包含：
- 主程序
- 所有 Qt 依赖
- 必要的 DLL 文件
- 桌面快捷方式

## 故障排除

### 问题：CMake 找不到 Qt

**解决方案**：
```bash
cmake -DCMAKE_PREFIX_PATH="C:/Qt/6.5.0/msvc2019_64" ..
```

### 问题：编译时出现中文乱码

**原因**：文件编码不正确

**解决方案**：
- 使用 UTF-8 编码（不带 BOM）
- 避免在代码中使用中文注释
- 使用 `tr()` 和 `qsTr()` 进行国际化

### 问题：运行时提示缺少 DLL

**解决方案**：
1. 确保执行了部署步骤（Script-DeployRelease）
2. 手动运行 windeployqt：
```cmd
cd dist
windeployqt JiTou-Unlock-NextVersion-master.exe
```

### 问题：macOS 权限被拒绝

**解决方案**：
```bash
# 给项目目录完全权限
sudo chmod -R 755 /path/to/JiTou-Unlock-NextVersion
```

### 问题：编译非常慢

**解决方案**：
- Windows: 使用 Ninja 生成器而不是 Visual Studio
- 使用多核编译：`cmake --build . --config Release -j 8`
- 确保防病毒软件不扫描构建目录

## 高级配置

### 自定义构建选项

```bash
# 使用特定 Qt 版本
cmake -DCMAKE_PREFIX_PATH="C:/Qt/6.5.0/msvc2019_64" ..

# 启用调试符号
cmake -DCMAKE_BUILD_TYPE=Debug ..

# 使用特定编译器
cmake -DCMAKE_CXX_COMPILER=g++ ..

# 并行编译（使用 8 个核心）
cmake --build . --config Release -j 8
```

### 静态编译

如果您希望创建不依赖 Qt DLL 的单一可执行文件，需要：

1. 使用静态编译的 Qt
2. 修改 CMakeLists.txt 添加静态链接选项
3. 重新编译

注意：静态编译的可执行文件会更大（50-100MB），但更易于分发。

### 交叉编译

本项目支持交叉编译，例如在 Linux 上编译 Windows 程序：

```bash
cmake -DCMAKE_TOOLCHAIN_FILE=windows-cross.cmake ..
```

## 更新翻译文件

当添加新的翻译字符串后：

```bash
cd build
cmake --build . --target Script-UpdateTranslations
```

这会更新 `.ts` 文件，然后您可以编辑翻译并重新生成 `.qm` 文件。

## 清理构建

```bash
# 删除构建目录
rm -rf build dist

# 或在 Windows
rmdir /s /q build dist
```

## 持续集成

项目包含 GitHub Actions 配置（`.github/workflows/msbuild.yml`），可以自动构建和测试。

## 获取帮助

如果遇到其他问题：
1. 查看 CMake 输出的错误信息
2. 检查 Qt 和 CMake 版本是否满足要求
3. 在项目 Issues 中搜索类似问题
4. 创建新的 Issue 并附上完整的错误日志

## 贡献

欢迎提交改进建议和 Pull Request！
