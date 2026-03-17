# CoffeeTree POS

Hệ thống Point of Sale tùy chỉnh của coffeetree.vn

## 🚀 Cài đặt nhanh với Docker

Chọn đúng hệ điều hành của bạn:

---

### 🐧 Ubuntu / Debian (All-in-one — chưa có gì cả)

> Lệnh này tự động cài **curl → Docker Engine → Docker Compose → CoffeeTree POS** trong một lần duy nhất.

```bash
sudo apt-get update && sudo apt-get install -y curl && curl -fsSL https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install/linux-docker-engine-install.sh | bash
```

---

### 🍎 Mac / Linux (đã có Docker Desktop)

```bash
curl -fsSL https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install/linux-mac-install.sh | bash
```

> Nếu Mac chưa có Docker Desktop, tải tại: [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/)

---

### 🪟 Windows

Tải và chạy file sau (tự động cài Docker Desktop nếu chưa có):

👉 [win-install.bat](https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install/win-install.bat)

---

### ✅ Sau khi cài xong

Mở trình duyệt: **http://localhost:8069**

| Tài khoản | Mật khẩu |
|-----------|----------|
| `admin`   | `admin`  |

> ⏱️ Lần đầu cài đặt mất ~15 phút (clone source + build image).