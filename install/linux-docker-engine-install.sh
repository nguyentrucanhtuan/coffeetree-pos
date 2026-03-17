#!/bin/bash
set -e

REPO="https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install"
DIR="coffeetree-pos"

# ── Cài curl nếu chưa có ────────────────────────────────────────────
if ! command -v curl &> /dev/null; then
  echo "📦 Đang cài curl..."
  sudo apt-get update -qq && sudo apt-get install -y curl
fi

echo "=========================================="
echo "  CoffeeTree POS - Linux Docker Engine Installer"
echo "=========================================="

# ── Install Docker Engine (Ubuntu/Debian) ──────────────────────────
if ! command -v docker &> /dev/null; then
  echo "🔧 Docker chưa được cài. Đang cài đặt Docker Engine..."
  
  # Cài đặt qua script của Docker (hỗ trợ hầu hết các distro Linux)
  curl -fsSL https://get.docker.com | sudo sh
  
  # Thêm user vào group docker để không cần dùng sudo
  sudo usermod -aG docker "$USER"
  
  echo "✅ Docker Engine đã được cài."
  echo "⚠️ Vui lòng ĐĂNG XUẤT và ĐĂNG NHẬP LẠI (hoặc restart máy) để áp dụng quyền chạy docker không cần sudo."
  echo "Sau đó chạy lại script này."
  exit 0
else
  echo "✅ Docker đã sẵn sàng."
fi

# ── Tải docker-compose.yml ──────────────────────────────────────────
mkdir -p "$DIR" && cd "$DIR"
echo "📥 Đang tải cấu hình..."
curl -fsSL "$REPO/docker-compose.yml" -o docker-compose.yml

# ── Xóa image cũ để buộc re-clone code mới nhất ────────────────────
echo "🗑️  Xóa image cũ (nếu có) để lấy code mới nhất từ git..."
sudo docker rmi coffeetree-pos-web 2>/dev/null || true

# ── Build & chạy ────────────────────────────────────────────────────
echo "🔨 Build và khởi động (lần đầu ~15 phút)..."
sudo docker compose up --build -d

# ── Chờ Odoo sẵn sàng ──────────────────────────────────────────────
echo "⏳ Chờ Odoo khởi động..."
until curl -sf http://localhost:8069/web/health > /dev/null 2>&1; do
  sleep 5
  echo "   Đang chờ... (có thể mất vài phút)"
done

# ── Thông báo ──────────────────────────────────────────────────────
echo ""
echo "=========================================="
echo "  ✅ CoffeeTree POS đã sẵn sàng!"
echo "     URL: http://localhost:8069"
echo "     Tài khoản: admin / admin"
echo "=========================================="
