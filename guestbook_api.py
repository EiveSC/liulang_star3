#!/usr/bin/env python3
import json
import os
from datetime import datetime
from http.server import HTTPServer, BaseHTTPRequestHandler
import urllib.parse

DATA_FILE = 'data/guestbook.json'

class GuestbookHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/api/guestbook':
            try:
                with open(DATA_FILE, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                self.send_response(200)
                self.send_header('Content-Type', 'application/json; charset=utf-8')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                self.wfile.write(json.dumps(data, ensure_ascii=False).encode('utf-8'))
            except Exception as e:
                self.send_response(500)
                self.end_headers()
                self.wfile.write(str(e).encode('utf-8'))
        else:
            self.send_response(404)
            self.end_headers()
    
    def do_POST(self):
        if self.path == '/api/guestbook':
            try:
                content_length = int(self.headers['Content-Length'])
                post_data = self.rfile.read(content_length).decode('utf-8')
                data = json.loads(post_data)
                
                # 读取现有留言
                with open(DATA_FILE, 'r', encoding='utf-8') as f:
                    guestbook = json.load(f)
                
                # 添加新留言
                new_message = {
                    'id': guestbook['next_id'],
                    'name': data.get('name', '匿名'),
                    'content': data.get('content', ''),
                    'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                }
                guestbook['messages'].append(new_message)
                guestbook['next_id'] += 1
                
                # 保存
                with open(DATA_FILE, 'w', encoding='utf-8') as f:
                    json.dump(guestbook, f, ensure_ascii=False, indent=2)
                
                self.send_response(200)
                self.send_header('Content-Type', 'application/json; charset=utf-8')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                self.wfile.write(json.dumps({'success': True, 'message': new_message}, ensure_ascii=False).encode('utf-8'))
            except Exception as e:
                self.send_response(500)
                self.end_headers()
                self.wfile.write(str(e).encode('utf-8'))
        else:
            self.send_response(404)
            self.end_headers()
    
    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()
    
    def log_message(self, format, *args):
        print(f"[{datetime.now()}] {args[0]}")

if __name__ == '__main__':
    # 监听所有网络接口（0.0.0.0），外网可访问
    server = HTTPServer(('0.0.0.0', 5000), GuestbookHandler)
    print('留言板 API 服务运行在 http://0.0.0.0:5000')
    print('外网可通过 服务器 IP:5000 访问')
    server.serve_forever()
