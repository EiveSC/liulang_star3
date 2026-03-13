#!/bin/bash
# 流浪写真集 - 一键外网访问（方案 A）

echo "=============================================="
echo "🌹 流浪写真集 - Cloudflare 外网隧道"
echo "=============================================="
echo ""

cd /home/admin/openclaw/workspace/photo-gallery

# 清理端口
echo "📁 清理端口..."
pkill -f "http.server" 2>/dev/null
lsof -ti:8080 | xargs kill -9 2>/dev/null
sleep 2

# 启动本地服务器
echo "🚀 启动本地服务器..."
python3 -m http.server 8080 &
sleep 3
echo "✅ 本地服务器：http://localhost:8080"
echo ""

# 启动 Cloudflare 隧道
echo "🌐 建立 Cloudflare 外网隧道..."
echo ""
/tmp/cloudflared-linux-amd64 tunnel --url http://localhost:8080

echo ""
echo "=============================================="
