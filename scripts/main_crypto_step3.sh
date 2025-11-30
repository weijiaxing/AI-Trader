#!/bin/bash

# 获取项目根目录（scripts/ 的父目录）
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

cd "$PROJECT_ROOT"

echo "🤖 正在启动加密货币交易代理 Starting the cryptocurrencies trading agent..."

python main.py configs/default_crypto_config.json 

echo "✅ AI-Trader 已停止 AI-Trader stopped"
