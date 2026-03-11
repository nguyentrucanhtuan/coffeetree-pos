#!/bin/bash
set -e

REPO="https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0"
DIR="coffeetree-pos"

echo "=============================="
echo "  CoffeeTree POS - Installer  "
echo "=============================="

# Kiểm tra Docker
if ! command -v docker &> /dev/null; then
  echo "❌ Docker chưa được cài. Tải tại: https://www.docker.com/products/docker-desktop"
  exit 1
fi

echo "✅ Docker đã được cài."

# Tạo thư mục
mkdir -p "$DIR/custom_addons"
cd "$DIR"

# Tải file cấu hình
echo "📥 Đang tải file cấu hình..."
curl -fsSL "$REPO/Dockerfile" -o Dockerfile
curl -fsSL "$REPO/docker-compose.yml" -o docker-compose.yml

echo "🔨 Đang build và khởi động (lần đầu ~15 phút)..."
docker compose up --build -d

echo ""
echo "=============================="
echo "  ✅ Hoàn tất! Mở trình duyệt:"
echo "     http://localhost:8069"
echo "=============================="

# Tự mở trình duyệt
sleep 3
if command -v xdg-open &> /dev/null; then
  xdg-open http://localhost:8069
elif command -v open &> /dev/null; then
  open http://localhost:8069
fi
