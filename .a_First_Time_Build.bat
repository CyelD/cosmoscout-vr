@echo off
setlocal enabledelayedexpansion
title CosmoScout VR Build and Run Script

REM =====================================================
REM 0. Submodules & Build Externals
REM =====================================================

echo.
echo Updating submodules...
git submodule update --init --recursive 

echo.
echo Building externals...
.\make_externals.bat -G "Visual Studio 17 2022" -A x64


REM =====================================================
REM 1. CMake-Konfiguration
REM =====================================================
echo.
echo Starting CMake configuration...
cmake --preset windows-vs-release-config -G "Visual Studio 17 2022" -A x64
if errorlevel 1 (
    echo.
    echo Error while configuring CMake!

    REM =====================================================
    REM 1.2. Bei Fehler alten Build-Ordner löschen
    REM =====================================================
    set "BUILD_PATH=C:\Repos\cosmoscout-vr\build\windows-Release"

    if exist "%BUILD_PATH%" (
        echo.
        echo Deleting \build\windows-Release...
        rmdir /S /Q "%BUILD_PATH%"
        echo.
        echo Folder deleted.
    ) else (
        echo.
        echo No folder found to delete.
    )

    echo Restarting CMake configuration...
    cmake --preset windows-vs-release-config -G "Visual Studio 17 2022" -A x64
    if errorlevel 1 (
        echo.
        echo Error while configuring CMake!
        pause
        exit /b 1

        REM =====================================================
        REM 1.3. Bei Fehler alten Build-Ordner löschen
        REM =====================================================
        set "BUILD_PATH=C:\Repos\cosmoscout-vr\build\windows-Release"

        if exist "%BUILD_PATH%" (
            echo.
            echo Deleting \build\windows-Release...
            rmdir /S /Q "%BUILD_PATH%"
            echo.
            echo Folder deleted.
        ) else (
            echo.
            echo No folder found to delete.
        )

    )

)
echo.
echo Completed CMake configuration.

REM =====================================================
REM 2. Build starten
REM =====================================================
echo.
echo Starting build process...
cmake --build --preset windows-vs-release-build
if errorlevel 1 (
    echo.
    echo Error while building!
    pause
    exit /b 1
)
echo.
echo Completed build.

REM =====================================================
REM 3. In Bin-Verzeichnis wechseln
REM =====================================================
set "BIN_PATH=C:\Repos\cosmoscout-vr\install\windows-Release\bin"
if exist "%BIN_PATH%" (
    cd /d "%BIN_PATH%"
    echo.
    echo Changing directory to "%BIN_PATH%"
) else (
    echo.
    echo Error: Directory not found!
    pause
    exit /b 1
)

REM =====================================================
REM 4. Benutzer-Eingabe: VR oder 2D
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
