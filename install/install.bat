@echo off
chcp 65001 >nul
setlocal

set REPO=https://raw.githubusercontent.com/nguyentrucanhtuan/coffeetree-pos/19.0/install
set DIR=coffeetree-pos

echo ==============================
echo   CoffeeTree POS - Installer
echo ==============================

:: ── Kiểm tra Docker ────────────────────────────────────────────────
docker --version >nul 2>&1
if errorlevel 1 (
    echo Docker chua duoc cai. Dang mo trang tai Docker Desktop...
    start https://www.docker.com/products/docker-desktop
    echo Sau khi cai Docker Desktop xong, chay lai file nay.
    pause
    exit /b 1
)

echo Docker da san sang.

:: ── Tải docker-compose.yml ─────────────────────────────────────────
if not exist "%DIR%" mkdir "%DIR%"
cd "%DIR%"
echo Dang tai cau hinh...
curl -fsSL "%REPO%/docker-compose.yml" -o docker-compose.yml

:: ── Build & chạy ───────────────────────────────────────────────────
echo Build va khoi dong (lan dau ~15 phut)...
docker compose up --build -d

:: ── Chờ Odoo sẵn sàng ─────────────────────────────────────────────
echo Cho Odoo khoi dong...
:wait_loop
timeout /t 5 >nul
curl -sf http://localhost:8069/web/health >nul 2>&1
if errorlevel 1 goto wait_loop

:: ── Mở trình duyệt ────────────────────────────────────────────────
echo.
echo ==============================
echo   Odoo da san sang!
echo   http://localhost:8069
echo   Tai khoan: admin / admin
echo ==============================
start http://localhost:8069
pause
