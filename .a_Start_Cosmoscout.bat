@echo off
setlocal enabledelayedexpansion
title CosmoScout VR Run Script

REM =====================================================
REM 1. In Bin-Verzeichnis wechseln
REM =====================================================
set "BIN_PATH=C:\Repos\cosmoscout-vr\install\windows-Release\bin"
if exist "%BIN_PATH%" (
    cd /d "%BIN_PATH%"
    echo Changing directory to "%BIN_PATH%"
) else (
    echo Error: Directory not found!
    pause
    exit /b 1
)

REM =====================================================
REM 2. Benutzer-Eingabe: VR oder 2D
REM =====================================================
echo.
echo Start CosmoScout in
echo vr - Head-Mounted Display (Standard)
echo 2d - Windowed-Mode
echo.

set /p MODE=Choose [vr] or [2d]: 
if "%MODE%"=="" set MODE=vr

if /I "%MODE%"=="2d" (
    echo Starting 2D mode
    start "CosmoScout 2D" cmd /c "cd /d "%BIN_PATH%" && start.bat"
) else if /I "%MODE%"=="vr" (
    echo Starting VR mode
    start "CosmoScout VR" cmd /c "cd /d "%BIN_PATH%" && hmd.bat"
) else (
    echo Unknown input, starting standard (VR)
    start "CosmoScout VR" cmd /c "cd /d "%BIN_PATH%" && hmd.bat"
)

echo.
echo Started CosmoScout.
exit /b 0
