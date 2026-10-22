@echo off
title Actualizar Barista Pro en GitHub
cls
echo ========================================================
echo   Actualizando Barista Pro en GitHub Pages...
echo ========================================================
git add .
set /p commitMsg="Describe tu cambio (o presiona Enter para usar 'Actualizacion'): "
if "%commitMsg%"=="" set commitMsg=Actualizacion
git commit -m "%commitMsg%"
git push origin main
echo.
echo ========================================================
echo   Listo! GitHub Pages se actualizara en 1 minuto.
echo ========================================================
pause
