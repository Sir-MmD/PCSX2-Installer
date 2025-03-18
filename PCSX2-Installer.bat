::MmD
@echo off
chcp 65001 >nul
echo;
echo;
echo [34m██████╗  ██████╗███████╗██╗  ██╗██████╗[0m       [36m██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗ [0m
echo [34m██╔══██╗██╔════╝██╔════╝╚██╗██╔╝╚════██╗[0m      [36m██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗[0m
echo [34m██████╔╝██║     ███████╗ ╚███╔╝  █████╔╝[0m█████╗[36m██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝[0m
echo [34m██╔═══╝ ██║     ╚════██║ ██╔██╗ ██╔═══╝ [0m╚════╝[36m██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗[0m
echo [34m██║     ╚██████╗███████║██╔╝ ██╗███████╗[0m      [36m██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║[0m                                                                     
echo [0m                                              
echo;
echo;

setlocal enabledelayedexpansion

echo [31mPress any key to START...[0m 
pause > nul
echo;

set "SCRIPT_DIR=%~dp0"

set "RELEASES_URL=https://github.com/PCSX2/pcsx2/releases"

set "BIN_DIR=%SCRIPT_DIR%pcsx2\bin"
set "PCSX2_DIR=%SCRIPT_DIR%pcsx2"
set "BIOS_DIR=%PCSX2_DIR%\data\Bios"
set "TEXTURE_DIR=%PCSX2_DIR%\TEXTURE"

:: installation check
if exist "%BIN_DIR%\pcsx2-qt.exe" (
    echo [92mPCSX2 is already installed[0m 
	echo;
    pause
    exit /b 0
)

:: create folders
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
if not exist "%PCSX2_DIR%" mkdir "%PCSX2_DIR%"
set "DATA_DIR=%PCSX2_DIR%\data"
if not exist "%DATA_DIR%" mkdir "%DATA_DIR%"

:: data sub folders
set SUBDATA=Bios Snapshots SaveStates MemoryCards Logs Cheats Patches UserResources Cache InputProfiles Videos Covers
for %%f in (%SUBDATA%) do (
    if not exist "%DATA_DIR%\%%f" mkdir "%DATA_DIR%\%%f"
)

set "ROM_DIR=%PCSX2_DIR%\ROM"

if not exist "%ROM_DIR%" mkdir "%ROM_DIR%"
if not exist "%TEXTURE_DIR%" mkdir "%TEXTURE_DIR%"

:: fetch latest version
echo Fetching the latest PCSX2 version...
for /f "delims=" %%i in ('powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$latest = (Invoke-WebRequest -Uri '%RELEASES_URL%' -UseBasicParsing).Links | Where-Object { $_.href -match '/PCSX2/pcsx2/releases/tag/v[\d\.]+' } | Select-Object -First 1 -ExpandProperty href; $latest -replace '.*/tag/v',''"') do set "LATEST_VERSION=%%i"

if "%LATEST_VERSION%"=="" (
    echo Failed to fetch the latest version.
    pause
    exit /b 1
)

echo Latest version found: v%LATEST_VERSION%

set "DOWNLOAD_URL=https://github.com/PCSX2/pcsx2/releases/download/v%LATEST_VERSION%/pcsx2-v%LATEST_VERSION%-windows-x64-Qt.7z"
set "OUTPUT_FILE=%BIN_DIR%\pcsx2-v%LATEST_VERSION%-windows-x64-Qt.7z"
echo Downloading PCSX2 v%LATEST_VERSION%...
:: download pcsx2
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%OUTPUT_FILE%'"

if %errorlevel% neq 0 (
    echo Download failed! Check your internet connection or GitHub availability.
    pause
    exit /b 1
)

echo Download complete: %OUTPUT_FILE%

:: download 7z
if not exist "%BIN_DIR%\7zr.exe" (
    echo Downloading 7zr.exe...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "Invoke-WebRequest -Uri 'https://www.7-zip.org/a/7zr.exe' -OutFile '%BIN_DIR%\7zr.exe'"

    if %errorlevel% neq 0 (
        echo Failed to download 7zr.exe. Check your internet connection or 7-Zip availability.
        pause
        exit /b 1
    )
    echo 7zr.exe downloaded successfully.
)

:: pcsx2 extraction
echo Extracting PCSX2...
"%BIN_DIR%\7zr.exe" x "%OUTPUT_FILE%" -o"%BIN_DIR%" -y >nul 2>&1

if %errorlevel% neq 0 (
    echo Extraction failed!
    pause
    exit /b 1
)
echo Extraction complete. PCSX2 is ready in %BIN_DIR%.
echo Removing the downloaded archive...
del "%OUTPUT_FILE%"
echo Archive removed successfully.

:: download bios
echo Downloading BIOS archive...
set "BIOS_ARCHIVE_URL=https://raw.githubusercontent.com/Sir-MmD/PCSX2-Installer/refs/heads/main/bios.7z"
set "BIOS_ARCHIVE=%BIOS_DIR%\bios.7z"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Invoke-WebRequest -Uri '%BIOS_ARCHIVE_URL%' -OutFile '%BIOS_ARCHIVE%'"

if %errorlevel% neq 0 (
    echo Failed to download BIOS archive.
    pause
    exit /b 1
)
echo BIOS archive downloaded: %BIOS_ARCHIVE%
:: extract bios
echo Extracting BIOS...
"%BIN_DIR%\7zr.exe" x "%BIOS_ARCHIVE%" -o"%BIOS_DIR%" -p"0xFPHe^5P&tKjt2sf2rvk" -y >nul 2>&1

if %errorlevel% neq 0 (
    echo BIOS extraction failed!
    pause
    exit /b 1
)
echo BIOS extraction complete.
echo Removing the BIOS archive...
del "%BIOS_ARCHIVE%"

:: pcsx2 ini setup
set "DOCS_DIR=%USERPROFILE%\Documents\PCSX2"
if not exist "%DOCS_DIR%" mkdir "%DOCS_DIR%"
set "INIS_DIR=%DOCS_DIR%\inis"
if not exist "%INIS_DIR%" mkdir "%INIS_DIR%"

:CHOICE_LOOP
echo;
echo Enter Your preferred input:
echo 1. Keyboard
echo 2. XBOX Controller
echo 3. Other Controllers
set /p INPUT_CHOICE="Enter the number (1-3): "
echo;

set "PCSX2_INI_URL="

if "%INPUT_CHOICE%"=="1" (
    set "PCSX2_INI_URL=https://raw.githubusercontent.com/Sir-MmD/PCSX2-Installer/main/PCSX2_Keyboard.ini"
) else if "%INPUT_CHOICE%"=="2" (
    set "PCSX2_INI_URL=https://raw.githubusercontent.com/Sir-MmD/PCSX2-Installer/main/PCSX2_XBOX.ini"
) else if "%INPUT_CHOICE%"=="3" (
    set "PCSX2_INI_URL=https://raw.githubusercontent.com/Sir-MmD/PCSX2-Installer/main/PCSX2_SDL.ini"
)

if not defined PCSX2_INI_URL (
    echo Invalid choice! Please try again.
    echo;
    goto CHOICE_LOOP
)
:: download pcsx2.ini
echo Downloading PCSX2.ini...
set "PCSX2_INI_FILE=%INIS_DIR%\PCSX2.ini"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Invoke-WebRequest -Uri '%PCSX2_INI_URL%' -OutFile '%PCSX2_INI_FILE%'"

if %errorlevel% neq 0 (
    echo Failed to download PCSX2.ini.
    pause
    exit /b 1
)
echo PCSX2.ini downloaded successfully to %PCSX2_INI_FILE%.

:: create desktop shortcut
echo Creating shortcut for PCSX2 on the desktop...
set "DESKTOP_DIR=%USERPROFILE%\Desktop"
set "SHORTCUT_NAME=PCSX2.lnk"
set "TARGET_EXE=%BIN_DIR%\pcsx2-qt.exe"

:: vb script for shortcut creation
echo Set objShell = CreateObject("WScript.Shell") > "%TEMP%\create_shortcut.vbs"
echo Set objShortcut = objShell.CreateShortcut("%DESKTOP_DIR%\%SHORTCUT_NAME%") >> "%TEMP%\create_shortcut.vbs"
echo objShortcut.TargetPath = "%TARGET_EXE%" >> "%TEMP%\create_shortcut.vbs"
echo objShortcut.IconLocation = "%TARGET_EXE%" >> "%TEMP%\create_shortcut.vbs"
echo objShortcut.Save >> "%TEMP%\create_shortcut.vbs"

cscript //nologo "%TEMP%\create_shortcut.vbs"
del "%TEMP%\create_shortcut.vbs"

if %errorlevel% neq 0 (
    echo Failed to create shortcut
	pause
    exit /b 1
)

echo Shortcut created successfully on the desktop.

:: download Reconfig_Paths.bat
echo Downloading Reconfig_Paths.bat...
set "RECONFIG_URL=https://raw.githubusercontent.com/Sir-MmD/PCSX2-Installer/main/Reconfig_Paths.bat"
set "RECONFIG_FILE=%PCSX2_DIR%\Reconfig_Paths.bat"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Invoke-WebRequest -Uri '%RECONFIG_URL%' -OutFile '%RECONFIG_FILE%'"

if %errorlevel% neq 0 (
    echo Failed to download Reconfig_Paths.bat.
    pause
    exit /b 1
)

echo Reconfig_Paths.bat downloaded successfully to %RECONFIG_FILE%.

:: execute Reconfig_Paths.bat
echo Executing Reconfig_Paths.bat...
call "%RECONFIG_FILE%"

if %errorlevel% neq 0 (
    echo Failed to execute Reconfig_Paths.bat.
    pause
    exit /b 1
)
echo Reconfig_Paths.bat executed successfully.

exit
