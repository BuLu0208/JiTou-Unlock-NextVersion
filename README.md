# JiTou-Unlock-NextVersion

基于 Qt/C++ 开发的跨平台应用程序

## 系统要求

### Windows
- Windows 10 或更高版本
- Visual Studio 2019 或更高版本（带 C++ 桌面开发工作负载）
- CMake 3.20 或更高版本
- Qt 5.15+ 或 Qt 6.x

### macOS
- macOS 10.15 或更高版本
- Xcode 命令行工具
- CMake 3.20 或更高版本
- Qt 5.15+ 或 Qt 6.x

## 编译说明

### Windows 编译步骤

#### 方式一：使用提供的批处理脚本（推荐）

1. 确保已安装 Qt 和 CMake，并将它们添加到系统 PATH
2. 打开命令提示符或 PowerShell
3. 运行构建脚本：
```cmd
build_windows.bat
```

这将自动完成以下步骤：
- 创建构建目录
- 配置 CMake 项目
- 编译项目
- 部署 Qt 依赖项到 dist 目录

#### 方式二：手动编译

1. 创建构建目录：
```cmd
mkdir build
cd build
```

2. 配置 CMake（请根据您的 Qt 安装路径修改 CMAKE_PREFIX_PATH）：
```cmd
cmake -G "Visual Studio 17 2022" -A x64 ^
      -DCMAKE_PREFIX_PATH=C:\Qt\6.5.0\msvc2019_64 ^
      -DCMAKE_BUILD_TYPE=Release ..
```

3. 编译项目：
```cmd
cmake --build . --config Release
```

4. 部署 Qt 依赖项：
```cmd
cmake --build . --config Release --target Script-DeployRelease
```

编译完成后，可执行文件和所有依赖项将位于 `dist` 目录中。

### macOS 编译步骤

1. 创建构建目录：
```bash
mkdir build
cd build
```

2. 配置 CMake（请根据您的 Qt 安装路径修改 CMAKE_PREFIX_PATH）：
```bash
cmake -DCMAKE_PREFIX_PATH=~/Qt/6.5.0/macos \
      -DCMAKE_BUILD_TYPE=Release ..
```

3. 编译项目：
```bash
cmake --build . --config Release
```

4. 部署 Qt 依赖项：
```bash
cmake --build . --config Release --target Script-DeployRelease
```

编译完成后，应用程序包将位于 `dist` 目录中。

## 创建安装程序

### Windows 安装程序

使用 Inno Setup 创建 Windows 安装程序：

1. 确保已完成编译并执行了部署步骤（dist 目录已生成）
2. 安装 [Inno Setup](https://jrsoftware.org/isdl.php)
3. 打开 `package/InstallerScript.iss`
4. 在 Inno Setup 中编译脚本
5. 安装程序将在 `package` 目录中生成

## 开发说明

### 文件编码
- 使用 UTF-8 编码（不带 BOM）
- 避免在代码和注释中使用中文字符
- 使用国际化（i18n）显示中文：
  - C++ 中使用 `tr()` 函数
  - QML 中使用 `qsTr()` 函数

### 更新翻译

当添加了新的 `tr()` 或 `qsTr()` 函数后：

```bash
cmake --build . --target Script-UpdateTranslations
```

这将更新 `.ts` 翻译文件并生成 `.qm` 文件。

## 项目结构

```
.
├── CMakeLists.txt          # 根 CMake 配置
├── src/                    # 源代码目录
│   ├── CMakeLists.txt     # 源代码 CMake 配置
│   ├── main.cpp           # 程序入口
│   ├── *.qml              # QML 界面文件
│   ├── helper/            # 辅助类
│   └── dll/               # Windows DLL 依赖
├── FluentUI/              # FluentUI 组件库
├── package/               # 打包脚本
│   └── InstallerScript.iss # Inno Setup 安装脚本
└── README.md              # 本文件

```

## 常见问题

### Q: 编译失败，提示找不到 Qt
A: 请确保在 CMake 配置时正确设置了 `CMAKE_PREFIX_PATH` 指向您的 Qt 安装目录。

### Q: macOS 编译失败，提示权限不足
A: 请给整个项目路径授予完全访问权限。

### Q: 运行时缺少 DLL
A: 请确保执行了部署步骤（Script-DeployRelease），该步骤会将所有必需的 Qt DLL 复制到输出目录。

## 许可证

请查看项目许可证文件。
