#!/bin/bash
# Regenerate Frontend Cache
# Run this script after updating trading data to regenerate the pre-computed cache files

set -e  # Exit on error

echo "========================================"
echo "重新生成前端缓存 Regenerating Frontend Cache"
echo "========================================"
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"

cd "$PROJECT_ROOT"

# Try to find Python with yaml module
if command -v ~/miniconda3/bin/python3 &> /dev/null && ~/miniconda3/bin/python3 -c "import yaml" &> /dev/null; then
    PYTHON=~/miniconda3/bin/python3
elif command -v python3 &> /dev/null && python3 -c "import yaml" &> /dev/null; then
    PYTHON=python3
elif command -v python &> /dev/null && python -c "import yaml" &> /dev/null; then
    PYTHON=python
else
    echo "❌ 错误：未找到安装 PyYAML 的 Python Error: Python with PyYAML not found. Please install: pip install pyyaml"
    exit 1
fi

echo "使用 Python Using Python: $PYTHON"
echo ""

# Run the cache generation script
echo "🛠️  正在运行缓存生成脚本 Running cache generation script..."
$PYTHON scripts/precompute_frontend_cache.py

echo ""
echo "========================================"
echo "✅ 缓存重新生成完成 Cache regeneration complete!"
echo "========================================"
echo ""
echo "📄 已生成文件 Generated files:"
echo "  - docs/data/us_cache.json"
echo "  - docs/data/cn_cache.json"
echo ""
echo "ℹ️  这些文件将被前端自动使用以加快加载速度 These files will be automatically used by the frontend for faster loading."
echo "📦 请提交这些文件以便 GitHub Pages 部署 Commit these files to your repository for GitHub Pages deployment."
