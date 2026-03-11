#!/bin/bash
set -e

REPO="https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0"
DIR="coffeetree-pos"

echo "=============================="
echo "  CoffeeTree POS - Installer  "
echo "=============================="

# ── Cài Docker nếu chưa có ─────────────────────────────────────────
if ! command -v docker &> /dev/null; then
  echo "🔧 Docker chưa được cài. Đang cài đặt..."

  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "❌ Trên Mac, vui lòng tải Docker Desktop thủ công:"
    echo "   https://www.docker.com/products/docker-desktop"
    exit 1
  fi

  # Linux (Ubuntu/Debian)
  curl -fsSL https://get.docker.com | sudo sh
  sudo usermod -aG docker "$USER"
  echo "✅ Docker đã được cài. Đang khởi động..."
  sudo systemctl start docker
  sudo systemctl enable docker
else
  echo "✅ Docker đã sẵn sàng."
fi

# ── Tải docker-compose.yml ──────────────────────────────────────────
mkdir -p "$DIR" && cd "$DIR"
echo "📥 Đang tải cấu hình..."
curl -fsSL "$REPO/docker-compose.yml" -o docker-compose.yml

# ── Build & chạy ────────────────────────────────────────────────────
echo "🔨 Build và khởi động (lần đầu ~15 phút, bao gồm clone + cài packages)..."
docker compose up --build -d

# ── Chờ Odoo sẵn sàng ──────────────────────────────────────────────
echo "⏳ Chờ Odoo khởi động (có thể mất vài phút lần đầu)..."
until curl -sf http://localhost:8069/web/health > /dev/null 2>&1; do
  sleep 5
  echo "   Đang chờ..."
done

# ── Mở trình duyệt ─────────────────────────────────────────────────
echo ""
echo "=============================="
echo "  ✅ Odoo đã sẵn sàng!"
echo "     http://localhost:8069"
echo "     Tài khoản: admin / admin"
echo "=============================="

if command -v xdg-open &> /dev/null; then
  xdg-open http://localhost:8069
elif command -v open &> /dev/null; then
  open http://localhost:8069
fi
