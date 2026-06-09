# MikeClub iOS App

这是把 `MikeClub.html` 转成的原生 iOS WebView App 工程。页面文件已打包在 App 内部，`localStorage` 会使用 `WKWebView` 的默认数据存储保留本机数据。

## 用 Xcode 打包

1. 在 macOS 上解压本目录。
2. 打开 `MikeClub.xcodeproj`。
3. 选择 `MikeClub` target，在 `Signing & Capabilities` 里选择你的 Apple Developer Team。
4. 如需上架或安装到真机，请把 `Bundle Identifier` 从 `com.mikeclub.seating` 改成你的唯一标识。
5. 运行模拟器测试：`Product > Run`。
6. 生成归档：`Product > Archive`，然后在 Organizer 里导出 `.ipa`。

也可以用命令行：

```sh
xcodebuild -project MikeClub.xcodeproj -scheme MikeClub -configuration Release -destination 'generic/platform=iOS' archive -archivePath build/MikeClub.xcarchive
xcodebuild -exportArchive -archivePath build/MikeClub.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath build/export
```

注意：`.ipa` 导出必须在 macOS 上完成，并且需要 Xcode、Apple Developer 账号和有效签名证书。

## 用 GitHub Actions 打包

仓库里已包含 `.github/workflows/ios-build.yml`。推送到 GitHub 后，Actions 会自动构建并上传 `MikeClub-iOS-build` 产物：

- `MikeClub-unsigned.ipa`：未签名 IPA，不能直接安装到真机，需要后续签名。
- `MikeClub-simulator-app.zip`：iOS 模拟器 App，可用于验证构建结果。

如果需要直接导出可安装真机的 `.ipa`，需要在 GitHub 仓库 secrets 中配置 Apple 证书、provisioning profile 和导出参数。
