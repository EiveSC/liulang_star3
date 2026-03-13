#!/bin/bash
# 流浪写真集 - 快速分享（无需注册）

echo "=============================================="
echo "🚀 流浪写真集 - 快速分享"
echo "=============================================="

PROJECT_DIR="/home/admin/openclaw/workspace/photo-gallery"
cd "$PROJECT_DIR" || exit 1

echo ""
echo "📁 项目目录：$PROJECT_DIR"
echo ""
echo "📂 素材检查:"
echo "  照片：$(ls images/*.jpg 2>/dev/null | wc -l) 张"
echo "  视频：$(ls videos/*.mp4 videos/*.mov 2>/dev/null | wc -l) 个"
echo ""

# 启动本地服务器
echo "🎬 启动本地服务器..."
python3 -m http.server 8080 &
SERVER_PID=$!
sleep 2

echo ""
echo "✅ 本地服务器已启动 (PID: $SERVER_PID)"
echo "   访问：http://localhost:8080"
echo ""

# 检查 ngrok
if command -v ngrok &> /dev/null; then
    echo "🌐 正在启动 ngrok..."
    echo ""
    echo "=============================================="
    echo "⚠️  按 Ctrl+C 停止所有服务"
    echo "=============================================="
    echo ""
    ngrok http 8080
else
    echo "⚠️  ngrok 未安装"
    echo ""
    echo "=============================================="
    echo "📥 安装 ngrok:"
    echo "=============================================="
    echo ""
    echo "方法 1: 使用 Homebrew (Mac)"
    echo "  brew install ngrok"
    echo ""
    echo "方法 2: 使用 APT (Ubuntu/Debian)"
    echo "  sudo apt update && sudo apt install ngrok"
    echo ""
    echo "方法 3: 手动下载"
    echo "  1. 访问 https://ngrok.com/download"
    echo "  2. 下载对应版本"
    echo "  3. 解压后运行: ./ngrok http 8080"
    echo ""
    echo "=============================================="
    echo "🌐 或使用其他免费方案:"
    echo "=============================================="
    echo ""
    echo "方案 1: Serveo (无需安装)"
    echo "  ssh -R 80:localhost:8080 serveo.net"
    echo ""
    echo "方案 2: Cloudflare Tunnel"
    echo "  cloudflared tunnel --url http://localhost:8080"
    echo ""
    echo "方案 3: LocalXpose"
    echo "  ./loclx tunnel http --to localhost:8080"
    echo ""
    
    echo "=============================================="
    echo "💡 本地预览:"
    echo "=============================================="
    echo ""
    echo "  浏览器访问：http://localhost:8080"
    echo ""
    echo "  按 Ctrl+C 停止服务器"
    echo ""
    
    # 保持服务器运行
    wait $SERVER_PID
fi

# 清理
kill $SERVER_PID 2>/dev/null
