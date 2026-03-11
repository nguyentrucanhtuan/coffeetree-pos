# CoffeeTree POS

Hệ thống Point of Sale tùy chỉnh của coffeetree.vn

## 🚀 Cài đặt nhanh với Docker

> [!IMPORTANT]
> Nên sử dụng **Docker Desktop** cho tất cả các hệ điều hành để đảm bảo tính đồng bộ và dễ quản lý.

### Yêu cầu
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) đã được cài đặt và đang chạy

### 1 lệnh duy nhất (Linux/Mac)

```bash
curl -fsSL https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install/docker-compose.yml | docker compose -f - up --build -d
```

> Cài đặt lần đầu mất ~15 phút. Sau đó mở **http://localhost:8069** — đăng nhập `admin` / `admin`.

### Hoặc dùng script tự động

**Linux/Mac:**
```bash
curl -fsSL https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install/linux-mac-install.sh | bash
```

**Windows** — tải và chạy:
[win-install.bat](https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install/win-install.bat)

---