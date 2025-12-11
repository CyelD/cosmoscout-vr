@echo off
title MapServer Cosmoscout

REM =====================================================
REM Pfad zum Docker-Projekt in WSL
REM =====================================================
set "PROJECT_PATH=/mnt/c/Repos/docker-mapserver"

REM =====================================================
REM Starte WSL und führe Befehle aus
REM =====================================================
echo Starte Ubuntu WSL und Docker MapServer...
wsl bash -c "cd %PROJECT_PATH% && sudo docker run -ti --rm -p 8080:80 ghcr.io/cosmoscout/mapserver-example"

echo.
echo MapServer beendet.
pause
exit /b 0