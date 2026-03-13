# 🚀 流浪写真集 - 一键部署

## ✅ 素材已准备好

```
images/
├── avatar.jpg      ✓ 头像
├── photo01.jpg     ✓ 照片 1
└── photo02.jpg     ✓ 照片 2
```

---

## 🎯 5 分钟部署到 Vercel

### 方法 1：网页拖拽（最简单）

1. **访问** https://vercel.com
2. **登录** - 用 GitHub 快捷登录
3. **创建项目** - "Add New..." → "Project"
4. **拖拽** - 将整个 `photo-gallery` 文件夹拖到上传区域
5. **等待** - 1-2 分钟自动部署
6. **完成** - 获得链接 https://xxx.vercel.app

### 方法 2：使用命令行（如果已安装 Node.js）

```bash
# 安装 Vercel CLI
npm install -g vercel

# 进入项目目录
cd /home/admin/openclaw/workspace/photo-gallery

# 登录
vercel login

# 部署
vercel --prod
```

---

## 📱 微信访问

部署完成后：
1. 复制链接（如：https://liulang-gallery.vercel.app）
2. 发送到微信
3. 点击打开 - 完美显示！✨

---

## 🎨 页面预览

访问本地测试：
```bash
cd /home/admin/openclaw/workspace/photo-gallery
python3 -m http.server 8080
```

浏览器打开：http://localhost:8080

---

## 💡 添加更多照片

1. 复制照片到 `images/` 目录
2. 编辑 `index.html` 第 268 行
3. 添加新路径到 `photos` 数组
4. 重新部署

---

**现在就开始部署吧！** 🚀
