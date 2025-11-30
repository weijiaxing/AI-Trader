#!/bin/bash

# Get the project root directory (parent of scripts/)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

cd "$PROJECT_ROOT"

echo "🤖 正在启动主交易代理 Starting the main trading agent..."

# Please create the config file first!!

# python main.py configs/default_day_config.json #run daily config
python main.py configs/default_hour_config.json #run hourly config

echo "✅ AI-Trader 已停止 AI-Trader stopped"
