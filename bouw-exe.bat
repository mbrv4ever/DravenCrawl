@echo off
REM DravenCrawl - bouw de .exe (PyInstaller, spec) - Dravenlock
setlocal
cd /d "%~dp0"
set "PYEXE="
for %%V in (3.12 3.13 3.11) do ( if not defined PYEXE ( py -%%V -c "import sys" >nul 2>&1 && set "PYEXE=py -%%V" ) )
if not defined PYEXE ( echo Geen Python 3.11-3.13 gevonden. & pause & exit /b 1 )
if not exist ".build-venv\Scripts\python.exe" ( %PYEXE% -m venv .build-venv )
set "VPY=.build-venv\Scripts\python.exe"
"%VPY%" -m pip install --upgrade pip >nul 2>&1
"%VPY%" -m pip install --only-binary=:all: PyQt6 PyQt6-WebEngine PySocks pyinstaller
if errorlevel 1 ( echo Installeren mislukt. & pause & exit /b 1 )
"%VPY%" -m PyInstaller --noconfirm --clean DravenCrawl.spec
if errorlevel 1 ( echo Bouwen mislukt. & pause & exit /b 1 )
echo KLAAR
pause
