# CoffeeTree POS — Odoo 19

Hệ thống Point of Sale tùy chỉnh trên nền Odoo 19, dành cho CoffeeTree.

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

## 📦 Cấu trúc thư mục

```
coffeetree-pos/
├── Dockerfile              # Build Odoo từ source
├── docker-compose.yml      # Orchestration Odoo + PostgreSQL
├── .env.example            # Template biến môi trường (copy → .env)
├── conf/
│   ├── odoo.conf.example   # Template config Odoo (copy → odoo.conf)
│   └── odoo.conf           # Config thực (không được commit)
├── custom_addons/          # Module tùy chỉnh của CoffeeTree
├── addons/                 # Core addons Odoo 19
└── ...                     # Source code Odoo 19
```

## 🛠️ Các lệnh thường dùng

```bash
# Xem logs
docker compose logs -f odoo

# Dừng
docker compose down

# Restart Odoo (sau khi thêm module mới)
docker compose restart odoo

# Update module
docker compose exec odoo /opt/odoo/odoo-bin -c /mnt/conf/odoo.conf -u MODULE_NAME -d DATABASE_NAME --stop-after-init

# Backup database
docker compose exec db pg_dump -U odoo DATABASE_NAME > backup.sql
```

## 🔐 Bảo mật

- File `.env` và `conf/odoo.conf` **không được commit** lên GitHub (chứa mật khẩu)
- Nhớ đổi `admin_passwd` trong `conf/odoo.conf` trước khi deploy production
- Nhớ đổi `POSTGRES_PASSWORD` trong `.env` trước khi deploy production

## 📁 Custom Addons

Đặt module tùy chỉnh vào thư mục `custom_addons/`. Sau khi thêm module mới:
```bash
docker compose restart odoo
```
Rồi cài đặt module trong giao diện Odoo.
