#!/bin/bash
set -e

# --- 内部变量映射 ---
# DG_ 前缀有效避免了与其他工具或基础镜像可能存在的 WEB_PORT 冲突
DG_WEB_PORT=${DAGSTER_WEBSERVER_PORT:-3000}
DG_WEB_WORKSPACE=${DAGSTER_WEBSERVER_WORKSPACE:-workspace.yaml}

if [ "$1" = 'webserver' ]; then
    echo "🚀 Starting Dagster Webserver..."
    echo "📍 Workspace: $DG_WEB_WORKSPACE"
    echo "🔌 Port: $DG_WEB_PORT"
    # 使用 exec 确保进程作为 PID 1 运行
    exec dagster-webserver -h 0.0.0.0 -p "$DG_WEB_PORT" -w "$DG_WEB_WORKSPACE"

elif [ "$1" = 'daemon' ]; then
    echo "👾 Starting Dagster Daemon..."
    exec dagster-daemon run
fi

# 执行自定义命令（如 /bin/bash 或 dagster job execute）
exec "$@"