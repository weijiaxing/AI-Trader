#!/bin/bash

# A股数据准备

# 获取项目根目录（scripts/ 的父目录）
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

cd "$PROJECT_ROOT"

# 确保 data/crypto 存在并进入该目录
mkdir -p "$PROJECT_ROOT/data/crypto"
cd "$PROJECT_ROOT/data/crypto" || { echo "❌ 无法进入目录 Cannot enter directory $PROJECT_ROOT/data/crypto"; exit 1; }

# 在运行 python 前输出当前工作目录
echo "📂 当前运行目录 Current directory: $(pwd)"
echo "📊 正在获取加密货币价格数据 Getting cryptocurrency price data..."
python get_daily_price_crypto.py

echo "📂 当前运行目录 Current directory: $(pwd)"
echo "🔀 正在合并加密货币数据 Merging cryptocurrency data..."
python merge_crypto_jsonl.py

# # for tushare
# echo "当前运行目录: $(pwd)"
# echo "即将运行: python get_daily_price_tushare.py"
# python get_daily_price_tushare.py
# echo "当前运行目录: $(pwd)"
# echo "即将运行: python merge_jsonl_tushare.py"
# python merge_jsonl_tushare.py

cd ..
