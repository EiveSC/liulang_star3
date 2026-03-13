#!/bin/bash
# 流浪写真集 - 外网访问方案

echo "=============================================="
echo "🌐 流浪写真集 - 外网访问方案"
echo "=============================================="
echo ""

# 检查本地服务器
if ! curl -s http://localhost:8080 > /dev/null; then
    echo "🚀 启动本地服务器..."
    cd /home/admin/openclaw/workspace/photo-gallery
    python3 -m http.server 8080 &
    sleep 2
fi

echo "✅ 本地服务器运行中：http://localhost:8080"
echo ""
echo "=============================================="
echo "方案 1: Cloudflare Quick Tunnel (推荐)"
echo "=============================================="
echo ""
echo "正在下载 cloudflared..."
cd /tmp

# 下载 cloudflared
if [ ! -f cloudflared ]; then
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
    chmod +x cloudflared
fi

echo "启动 Cloudflare Tunnel..."
echo ""
./cloudflared tunnel --url http://localhost:8080 2>&1 | grep -E "(trycloudflare|https://)" &

sleep 5

echo ""
echo "=============================================="
echo "🎉 外网访问链接:"
echo "=============================================="
echo ""
echo "请在上方查找 https://xxx.trycloudflare.com 链接"
echo ""
echo "复制该链接到微信即可访问！✨"
echo ""
echo "按 Ctrl+C 停止所有服务"
echo ""
