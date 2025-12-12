# Firefox Latest Releases — 速览

- 项目目标：提供最新 Firefox 版本号及各平台直接下载链接的静态页面，无后端依赖。
- 核心页面：`index.html` 包含全部样式与脚本。JS 逻辑通过 `https://product-details.mozilla.org/1.0/firefox_versions.json` 获取最新版本，生成标准 FTP 下载链接；使用 `localStorage` 以键 `firefox_version_cache` 缓存 24 小时并定时（24h）静默检查更新。
- 失败回退：若 API 不可用，使用硬编码的 `commonVersion`（当前为 `141.0`）展示并生成下载链接，并提示为预设版本。
- 自动更新脚本：`update-firefox-version.sh` 用于 crontab。流程：备份 `index.html` → 调用 Mozilla API 获取 `LATEST_FIREFOX_VERSION` → 用 `sed` 更新 `index.html` 中的 `commonVersion` → 日志输出到 `update.log`，失败时自动恢复备份。
- 结构备注：主要 DOM 元素在 `index.html` 内，下载卡片与状态提示均由 `FirefoxReleaseChecker` 在运行时渲染；下载区域已分为“桌面端”（Win/macOS/Linux）与“移动端”（Android/Fenix APK 与目录），并提供官方站点备用链接。
- 常用操作：本地直接打开 `index.html` 即可；服务端自动化建议将脚本设定为每日 2:00 执行（详见 `README-crontab.md`）。如需调整缓存/检查周期，修改脚本中的 `cacheExpiration` 和 `autoUpdateInterval`。
