# Firefox版本自动更新 - Crontab设置说明

## 使用方法

### 1. 测试脚本
```bash
# 进入项目目录
cd /Users/scavin/Documents/GitHub/Firefox-latest-releases

# 手动运行测试
./update-firefox-version.sh
```

### 2. 设置Crontab
```bash
# 编辑crontab
crontab -e

# 添加以下行（每天凌晨2点执行）
0 2 * * * /Users/scavin/Documents/GitHub/Firefox-latest-releases/update-firefox-version.sh

# 或者每天上午9点执行
0 9 * * * /Users/scavin/Documents/GitHub/Firefox-latest-releases/update-firefox-version.sh
```

### 3. 查看Crontab任务
```bash
# 查看当前crontab任务
crontab -l

# 查看cron日志 (macOS)
log show --predicate 'process == "cron"' --last 1d

# 查看脚本执行日志
tail -f /Users/scavin/Documents/GitHub/Firefox-latest-releases/update.log
```

## Crontab时间格式说明

```
* * * * * command
│ │ │ │ │
│ │ │ │ └─── 星期几 (0-7, 0和7都表示周日)
│ │ │ └───── 月份 (1-12)
│ │ └─────── 日期 (1-31)
│ └───────── 小时 (0-23)
└─────────── 分钟 (0-59)
```

### 常用时间设置示例
```bash
# 每天凌晨2点
0 2 * * *

# 每天上午9点
0 9 * * *

# 每12小时执行一次
0 */12 * * *

# 每周一上午9点
0 9 * * 1

# 每月1号凌晨2点
0 2 1 * *
```

## 脚本功能

✅ **自动获取最新版本**
- 优先使用Mozilla官方API
- GitHub API作为备用
- 版本格式验证

✅ **智能更新**
- 版本比较，只在有新版本时更新
- 自动备份原文件
- 更新失败时自动恢复

✅ **纯HTML托管适配**
- 直接更新HTML文件
- 无Git操作，适合静态托管
- 托管环境自动检测文件变化

✅ **日志记录**
- 详细的执行日志
- 错误处理和报告
- 时间戳记录

## 故障排除

### 常见问题
1. **权限问题**: 确保脚本有执行权限 `chmod +x update-firefox-version.sh`
2. **路径问题**: 使用绝对路径设置crontab
3. **网络问题**: 检查API访问是否正常
4. **文件权限**: 确保HTML文件可写入

### 测试命令
```bash
# 手动测试脚本
./update-firefox-version.sh

# 检查日志
cat update.log

# 验证crontab设置
crontab -l
```