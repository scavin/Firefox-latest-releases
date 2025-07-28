# Firefox Latest Releases

🔥 自动获取最新 Firefox 版本和下载链接的静态网站

## 🌟 项目特色

- **🔄 智能缓存**：24小时缓存机制，减少API调用
- **🚀 自动更新**：客户端每日自动检查新版本
- **📱 响应式设计**：支持各种设备屏幕
- **🛡️ 可靠数据源**：Mozilla官方API，无依赖第三方
- **⚡ 即时显示**：缓存数据秒级加载
- **🎯 精准下载**：支持Windows、macOS、Linux多平台

## 📸 界面预览

访问网站即可看到：
- 当前最新Firefox版本号
- 各平台直接下载链接
- 版本更新时间显示
- 简洁优雅的界面设计

## 🔧 技术实现

### 前端特性
- **纯HTML/CSS/JavaScript**：无框架依赖
- **智能API调用**：仅使用Mozilla官方API，可靠稳定
- **本地存储缓存**：localStorage实现24小时缓存
- **自动定时更新**：每24小时静默检查新版本
- **用户友好提示**：版本更新通知和状态显示

### API数据源
1. **Mozilla Product Details API**（主要且唯一可靠源）
   ```
   https://product-details.mozilla.org/1.0/firefox_versions.json
   ```

2. **备用方案**：手动维护版本号
   - 当API不可用时使用预设版本
   - 定期手动更新或通过crontab脚本更新

### 下载链接生成
基于Mozilla FTP服务器规律自动生成：
```
https://ftp.mozilla.org/pub/firefox/releases/{version}/{platform}/zh-CN/
```

## 🤖 服务端自动化

### Crontab定时更新
项目包含完整的服务端自动更新解决方案：

```bash
# 设置每日凌晨2点自动更新
0 2 * * * /path/to/update-firefox-version.sh
```

**功能特性：**
- ✅ 自动获取最新Firefox版本
- ✅ 智能版本比较，仅在有更新时执行
- ✅ 文件备份和错误恢复机制
- ✅ 详细日志记录和错误处理
- ✅ 适配纯HTML托管环境

详细设置说明请查看：[README-crontab.md](README-crontab.md)

## 🚀 快速开始

### 方法一：直接使用
访问部署好的网站即可使用，无需任何配置。

### 方法二：本地部署
```bash
# 克隆仓库
git clone https://github.com/scavin/Firefox-latest-releases.git
cd Firefox-latest-releases

# 直接打开HTML文件或部署到任意Web服务器
# 支持：Apache、Nginx、静态托管平台等
```

### 方法三：自动化部署
```bash
# 1. 测试自动更新脚本
./update-firefox-version.sh

# 2. 设置定时任务
crontab -e
# 添加：0 2 * * * /完整路径/update-firefox-version.sh
```

## 📁 项目结构

```
Firefox-latest-releases/
├── index.html              # 主页面文件
├── update-firefox-version.sh  # 自动更新脚本
├── README-crontab.md       # Crontab详细说明
├── assets/                 # 静态资源
│   ├── hero-high-res.png   # 英雄图片
│   ├── logo-word-hor.svg   # Firefox logo
│   └── favicon.ico         # 网站图标
└── README.md              # 项目说明
```

## 🔄 缓存机制

### 客户端缓存
- **存储方式**：浏览器localStorage
- **缓存时长**：24小时
- **缓存内容**：Firefox版本号和获取时间
- **自动清理**：过期缓存自动删除

### 时间显示格式
- `今天` - 当日更新
- `昨天` - 昨日更新  
- `X天前` - 更早的更新

## 🛠️ 部署指南

### 静态托管平台
- **Vercel**：直接导入GitHub仓库
- **Netlify**：拖拽文件夹或Git部署
- **GitHub Pages**：仓库设置中开启Pages
- **Cloudflare Pages**：连接GitHub自动部署

### 传统服务器
```bash
# Apache/Nginx
cp -r Firefox-latest-releases/* /var/www/html/

# 启用自动更新（可选）
chmod +x update-firefox-version.sh
crontab -e  # 添加定时任务
```

## ⚙️ 配置选项

### 自定义缓存时间
修改 `index.html` 中的缓存配置：
```javascript
this.cacheExpiration = 24 * 60 * 60 * 1000; // 24小时
this.autoUpdateInterval = 24 * 60 * 60 * 1000; // 检查间隔
```

### 自定义更新频率
修改crontab时间设置：
```bash
# 每12小时
0 */12 * * *

# 每周一次
0 2 * * 1
```

## 🔍 故障排除

### 常见问题
1. **API访问失败**：检查网络连接和防火墙设置
2. **缓存不更新**：清除浏览器localStorage
3. **脚本执行失败**：检查文件权限和路径设置
4. **版本显示错误**：查看浏览器控制台错误信息

### 调试方法
```bash
# 查看脚本日志
tail -f update.log

# 手动测试API
curl -s "https://product-details.mozilla.org/1.0/firefox_versions.json"

# 检查crontab任务
crontab -l
```

## 📄 开源协议

本项目采用 MIT 协议，欢迎自由使用和修改。

## 🤝 贡献指南

欢迎提交问题和改进建议：
1. Fork 本仓库
2. 创建功能分支
3. 提交改动
4. 发起 Pull Request

## 🔗 相关链接

- [Mozilla Firefox官网](https://www.mozilla.org/firefox/)
- [Mozilla FTP服务器](https://ftp.mozilla.org/pub/firefox/releases/)
- [Firefox版本发布说明](https://www.mozilla.org/firefox/releases/)

---

⭐ 如果这个项目对你有帮助，请给个Star支持一下！
