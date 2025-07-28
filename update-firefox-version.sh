#!/bin/bash

# Firefox版本自动更新脚本
# 用于crontab定时任务，自动获取最新Firefox版本并更新HTML文件

set -e  # 遇到错误立即退出

# 配置
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HTML_FILE="$SCRIPT_DIR/index.html"
LOG_FILE="$SCRIPT_DIR/update.log"
BACKUP_FILE="$SCRIPT_DIR/index.html.backup"

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 错误处理函数
error_exit() {
    log "错误: $1"
    # 如果有备份文件，恢复原文件
    if [ -f "$BACKUP_FILE" ]; then
        cp "$BACKUP_FILE" "$HTML_FILE"
        log "已恢复原文件"
    fi
    exit 1
}

# 获取Firefox最新版本
get_latest_firefox_version() {
    log "开始获取Firefox最新版本..."
    
    # 方法1: Mozilla Product Details API
    VERSION=$(curl -s "https://product-details.mozilla.org/1.0/firefox_versions.json" | \
              grep -o '"LATEST_FIREFOX_VERSION":"[^"]*"' | \
              cut -d'"' -f4)
    
    if [ -n "$VERSION" ] && [[ "$VERSION" =~ ^[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; then
        log "从Mozilla API获取到版本: $VERSION"
        echo "$VERSION"
        return 0
    fi
    
    
    error_exit "无法从Mozilla API获取版本信息"
}

# 获取HTML文件中的当前版本
get_current_version() {
    grep -o 'const commonVersion = "[^"]*"' "$HTML_FILE" | cut -d'"' -f2
}

# 更新HTML文件中的版本
update_html_version() {
    local new_version="$1"
    
    log "更新HTML文件中的版本为: $new_version"
    
    # 创建备份
    cp "$HTML_FILE" "$BACKUP_FILE"
    
    # 使用sed替换版本号
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/const commonVersion = \"[^\"]*\"/const commonVersion = \"$new_version\"/" "$HTML_FILE"
    else
        # Linux
        sed -i "s/const commonVersion = \"[^\"]*\"/const commonVersion = \"$new_version\"/" "$HTML_FILE"
    fi
    
    # 验证替换是否成功
    if grep -q "const commonVersion = \"$new_version\"" "$HTML_FILE"; then
        log "HTML文件更新成功"
        rm -f "$BACKUP_FILE"  # 删除备份文件
        return 0
    else
        error_exit "HTML文件更新失败"
    fi
}

# 文件更新完成通知
notify_update_complete() {
    local version="$1"
    log "文件更新完成，新版本: $version"
    log "HTML文件已更新，托管环境将自动生效"
}

# 主函数
main() {
    log "========== Firefox版本更新脚本开始 =========="
    
    # 检查必要文件
    if [ ! -f "$HTML_FILE" ]; then
        error_exit "HTML文件不存在: $HTML_FILE"
    fi
    
    # 获取当前版本
    current_version=$(get_current_version)
    log "当前版本: $current_version"
    
    # 获取最新版本
    latest_version=$(get_latest_firefox_version)
    log "最新版本: $latest_version"
    
    # 比较版本
    if [ "$current_version" = "$latest_version" ]; then
        log "版本已是最新，无需更新"
        log "========== 脚本执行完成 =========="
        exit 0
    fi
    
    log "检测到新版本，开始更新..."
    
    # 更新HTML文件
    update_html_version "$latest_version"
    
    # 通知更新完成
    notify_update_complete "$latest_version"
    
    log "Firefox版本更新完成: $current_version -> $latest_version"
    log "========== 脚本执行完成 =========="
}

# 执行主函数
main "$@"