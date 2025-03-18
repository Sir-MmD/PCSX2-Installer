::MmD
@echo off
setlocal

set "SCRIPT_DIR=%~dp0"

for /f "delims=" %%a in ('powershell -NoProfile -Command "[Environment]::GetFolderPath(\"MyDocuments\")"') do set "DOCS_DIR=%%a"

set "PCSX2_INI=%DOCS_DIR%\PCSX2\inis\PCSX2.ini"

if not exist "%PCSX2_INI%" (
    echo PCSX2.ini not found in "%DOCS_DIR%\PCSX2\inis".
    pause
    exit /b 1
)

echo Modifying PCSX2.ini...

powershell -NoProfile -Command ^
  "(Get-Content '%PCSX2_INI%') -replace '^\s*Bios\s*=.*$', 'Bios=%SCRIPT_DIR%data\Bios' -replace '^\s*Snapshots\s*=.*$', 'Snapshots=%SCRIPT_DIR%data\Snapshots' -replace '^\s*Savestates\s*=.*$', 'Savestates=%SCRIPT_DIR%data\Savestates' -replace '^\s*MemoryCards\s*=.*$', 'MemoryCards=%SCRIPT_DIR%data\MemoryCards' -replace '^\s*Logs\s*=.*$', 'Logs=%SCRIPT_DIR%data\Logs' -replace '^\s*Cheats\s*=.*$', 'Cheats=%SCRIPT_DIR%data\Cheats' -replace '^\s*Patches\s*=.*$', 'Patches=%SCRIPT_DIR%data\Patches' -replace '^\s*UserResources\s*=.*$', 'UserResources=%SCRIPT_DIR%data\UserResources' -replace '^\s*Cache\s*=.*$', 'Cache=%SCRIPT_DIR%data\Cache' -replace '^\s*Textures\s*=.*$', 'Textures=%SCRIPT_DIR%TEXTURE' -replace '^\s*InputProfiles\s*=.*$', 'InputProfiles=%SCRIPT_DIR%data\InputProfiles' -replace '^\s*Videos\s*=.*$', 'Videos=%SCRIPT_DIR%data\Videos' -replace '^\s*RecursivePaths\s*=.*$', 'RecursivePaths=%SCRIPT_DIR%ROM' -replace '^\s*Covers\s*=.*$', 'Covers=%SCRIPT_DIR%data\Covers' | Set-Content '%PCSX2_INI%'"

echo PCSX2.ini has been modified successfully.
echo;
echo [92m DONE[0m 
echo;
echo Press any key to exit
pause > nul
endlocal
