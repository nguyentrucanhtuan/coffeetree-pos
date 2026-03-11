# CoffeeTree POS — Odoo 19

Hệ thống Point of Sale tùy chỉnh trên nền Odoo 19, dành cho CoffeeTree.

## 🚀 Cài đặt nhanh với Docker

### Yêu cầu
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) đã được cài đặt và đang chạy

### Các bước

**1. Clone repo**
```bash
git clone https://github.com/nguyentrucanhtuan/coffeetree-pos.git --depth 1
cd coffeetree-pos
```

**2. Tạo file cấu hình**
```bash
# Copy template env
cp .env.example .env

# Tạo odoo.conf từ template
cp conf/odoo.conf.example conf/odoo.conf
```

**3. Chỉnh sửa mật khẩu** (mở `.env` và `conf/odoo.conf`, đổi các giá trị mặc định)

**4. Build & khởi động (All-in-One)**
```bash
docker compose up --build -d
```

> Lần đầu build mất khoảng 10–15 phút. Các lần sau chỉ cần `docker compose up -d`.

**5. Truy cập**
- Odoo: [http://localhost:8069](http://localhost:8069)
- Tạo database mới, đăng nhập và bắt đầu sử dụng!

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
