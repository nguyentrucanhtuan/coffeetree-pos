# CoffeeTree POS

Hệ thống Point of Sale tùy chỉnh của coffeetree.vn

## 🚀 Cài đặt nhanh với Docker

### Yêu cầu
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) đã được cài đặt và đang chạy

### 1 lệnh duy nhất

```bash
curl -fsSL https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install/docker-compose.yml | docker compose -f - up --build -d
```

> Lần đầu mất ~15 phút (clone Odoo + cài packages + tạo DB + load demo data). Sau đó mở **http://localhost:8069** — đăng nhập `admin` / `admin`.

### Hoặc dùng script tự động (cài Docker nếu chưa có)

**Linux/Mac:**
```bash
curl -fsSL https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install/install.sh | bash
```

**Windows** — tải và double-click:
[install.bat](https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install/install.bat)

---