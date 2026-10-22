@echo off
title Actualizar Barista Pro en GitHub
cls
echo ========================================================
echo   Actualizando Barista Pro en GitHub Pages...
echo ========================================================

git remote | findstr "origin" >nul
if errorlevel 1 (
    echo.
    echo [!] TU CARPETA LOCAL AUN NO ESTA VINCULADA A GITHUB
    echo ----------------------------------------------------
    echo 1. Crea un repositorio en https://github.com/new
    echo 2. Copia la direccion URL (ej: https://github.com/usuario/barista-pro.git)
    echo.
    set /p repoUrl="Pega aqui la URL de tu repositorio y presiona Enter: "
    if not "%repoUrl%"=="" (
        git remote add origin %repoUrl%
        echo Repositorio vinculado correctamente!
    ) else (
        echo Operacion cancelada. No se indico una URL.
        pause
        exit /b
    )
)

echo.
git add .
set /p commitMsg="Describe tu cambio (o presiona Enter para usar 'Actualizar app'): "
if "%commitMsg%"=="" set commitMsg=Actualizar app
git commit -m "%commitMsg%"

echo.
echo Subiendo cambios a GitHub...
git push -u origin main

if errorlevel 1 (
    echo.
    echo [ERROR] No se pudo subir a GitHub.
    echo Revisa si la URL de tu repositorio es correcta y tienes conexion a internet.
) else (
    echo.
    echo ========================================================
    echo   Listo! Tus cambios ya estan en GitHub.
    echo   GitHub Pages se actualizara en ~1 minuto.
    echo ========================================================
)
pause
