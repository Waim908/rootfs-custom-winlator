@echo off
setlocal enabledelayedexpansion

:: Define paths
set SOURCE_DIR=%~dp0usr
set WINE_Z_DRIVE=Z:\
set TARGET_DIR=%WINE_Z_DRIVE%usr


:: Notify user of action
echo Copying files from "%SOURCE_DIR%" to "%TARGET_DIR%"...
echo This will merge with the existing usr directory if it exists.

:: Copy files
xcopy "%SOURCE_DIR%" "%TARGET_DIR%" /s /e /i /y >nul
if %errorlevel% neq 0 (
    echo [ERROR] Failed to copy files to "%TARGET_DIR%". Ensure you have write access to the Z: drive.
    pause
    exit /b 1
)

:: Success message
echo [SUCCESS] MangoHud has been successfully installed!
echo Please ensure the following environment variables are set:
echo   MANGOHUD=1
echo   MANGOHUD_CONFIG=engine_version,fps,frametime,ram,version,vulkan_driver,present_mode,arch
echo Refer to https://github.com/flightlessmango/MangoHud for more customization options.
echo.
echo You may now launch your Wine application to enjoy MangoHud overlays.
pause
exit /b 0

