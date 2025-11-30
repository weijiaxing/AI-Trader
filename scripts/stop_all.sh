#!/bin/bash

# AI-Trader 停止脚本
# 用于停止所有运行中的服务

set -e

echo "🛑 正在停止 AI-Trader 服务 Stopping AI-Trader services..."

# Get the project root directory (parent of scripts/)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

cd "$PROJECT_ROOT"

echo "🔍 正在查找 MCP 服务进程 Searching for MCP service processes..."

# 查找并停止 MCP 服务进程
MCP_PIDS=$(ps aux | grep -E "start_mcp_services|fastmcp" | grep -v grep | awk '{print $2}' || true)

if [ -z "$MCP_PIDS" ]; then
    echo "ℹ️  未发现运行中的 MCP 服务 No MCP services found running"
else
    echo "🛑 正在停止 MCP 服务 Stopping MCP services (PIDs: $MCP_PIDS)..."
    echo "$MCP_PIDS" | xargs kill 2>/dev/null || true
    sleep 1
    # 强制停止仍在运行的进程
    echo "$MCP_PIDS" | xargs kill -9 2>/dev/null || true
    echo "✅ MCP 服务已停止 MCP services stopped"
fi

# 停止可能运行的主交易代理
echo "🔍 正在查找交易代理进程 Searching for trading agent processes..."
AGENT_PIDS=$(ps aux | grep -E "main.py|get_daily_price.py" | grep -v grep | awk '{print $2}' || true)

if [ -z "$AGENT_PIDS" ]; then
    echo "ℹ️  未发现运行中的交易代理 No trading agent found running"
else
    echo "🛑 正在停止交易代理 Stopping trading agent (PIDs: $AGENT_PIDS)..."
    echo "$AGENT_PIDS" | xargs kill 2>/dev/null || true
    sleep 1
    echo "$AGENT_PIDS" | xargs kill -9 2>/dev/null || true
    echo "✅ 交易代理已停止 Trading agent stopped"
fi

# 停止可能运行的 Web 服务器
echo "🔍 正在查找 Web 服务器进程 Searching for web server processes..."
WEB_PIDS=$(ps aux | grep -E "http.server 8888" | grep -v grep | awk '{print $2}' || true)

if [ -z "$WEB_PIDS" ]; then
    echo "ℹ️  端口 8888 上未发现运行中的 Web 服务器 No web server found running on port 8888"
else
    echo "🛑 正在停止 Web 服务器 Stopping web server (PIDs: $WEB_PIDS)..."
    echo "$WEB_PIDS" | xargs kill 2>/dev/null || true
    echo "✅ Web 服务器已停止 Web server stopped"
fi

# 检查端口占用情况
echo ""
echo "📊 正在检查端口状态 Checking ports status..."
PORT_CHECK=$(lsof -i :8000-8006,8888 2>/dev/null | grep LISTEN || true)

if [ -z "$PORT_CHECK" ]; then
    echo "✅ 所有端口已释放 All ports (8000-8006, 8888) are free"
else
    echo "⚠️  部分端口仍在使用中 Some ports are still in use:"
    echo "$PORT_CHECK"
fi

echo ""
echo "✅ 停止操作已完成 Stop operation completed!"
