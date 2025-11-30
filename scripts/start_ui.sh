#!/bin/bash

# Start AI-Trader Web UI

# Get the project root directory (parent of scripts/)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

cd "$PROJECT_ROOT"

echo "🌐 正在启动 Web UI 服务器 Starting Web UI server..."
echo ""
echo "按 Ctrl+C 停止服务器 Press Ctrl+C to stop the server"
echo ""

cd docs
python3 -m http.server 8888

