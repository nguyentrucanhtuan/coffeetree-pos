@echo off
chcp 65001 >nul
setlocal

set REPO=https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0
set DIR=coffeetree-pos

echo ==============================
echo   CoffeeTree POS - Installer
echo ==============================

:: Kiểm tra Docker
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker chua duoc cai. Tai tai: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

echo ✅ Docker da duoc cai.

:: Tạo thư mục
if not exist "%DIR%\custom_addons" mkdir "%DIR%\custom_addons"
cd "%DIR%"

:: Tải file cấu hình
echo 📥 Dang tai file cau hinh...
curl -fsSL "%REPO%/Dockerfile" -o Dockerfile
curl -fsSL "%REPO%/docker-compose.yml" -o docker-compose.yml

echo 🔨 Dang build va khoi dong (lan dau ~15 phut)...
docker compose up --build -d

echo.
echo ==============================
echo   ✅ Hoan tat! Mo trinh duyet:
echo      http://localhost:8069
echo ==============================

timeout /t 3 >nul
start http://localhost:8069

pause
