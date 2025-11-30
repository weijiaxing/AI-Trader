#!/bin/bash

# AI-Trader 主启动脚本
# 用于启动完整的交易环境

set -e  # 遇到错误时退出

echo "🚀 启动 AI Trader 环境 Launching AI Trader Environment..."

# Get the project root directory (parent of scripts/)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

cd "$PROJECT_ROOT"

echo "📊 正在获取并合并价格数据 Getting and merging price data..."
cd data
python get_daily_price.py
python merge_jsonl.py
cd ..

echo "🔧 正在启动 MCP 服务 Starting MCP services..."
cd agent_tools
python start_mcp_services.py
cd ..

#waiting for MCP services to start
sleep 2

echo "🤖 正在启动主交易代理 Starting the main trading agent..."
python main.py configs/default_config.json

echo "✅ AI-Trader 已停止 AI-Trader stopped"

echo "🔄 启动 Web 服务器 Starting web server..."
cd docs
python3 -m http.server 8888

echo "✅ Web 服务器已启动 Web server started"