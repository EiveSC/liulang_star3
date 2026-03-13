#!/bin/bash
# 人物写真集 - 快速部署脚本

echo "=============================================="
echo "📱 人物写真集 - 快速部署"
echo "=============================================="

PROJECT_DIR="/home/admin/openclaw/workspace/photo-gallery"
cd "$PROJECT_DIR" || exit 1

# 创建素材目录
echo ""
echo "📁 创建素材目录..."
mkdir -p images videos

# 检查是否有素材
echo ""
echo "📂 当前素材:"
echo "  images/: $(ls images/ 2>/dev/null | wc -l) 个文件"
echo "  videos/: $(ls videos/ 2>/dev/null | wc -l) 个文件"

# 启动本地服务器
echo ""
echo "🚀 启动本地服务器..."
echo ""
echo "   访问地址：http://localhost:8080"
echo "   按 Ctrl+C 停止服务器"
echo ""

python3 -m http.server 8080
