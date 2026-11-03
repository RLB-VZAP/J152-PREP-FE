@echo off
REM Rebuild src\main\webapp\css\tailwind.css from src\main\tailwind\input.css
REM Pass "watch" as the first argument to rebuild automatically on every save:
REM     build-css.cmd watch
REM Requires tools\tailwindcss.exe (standalone CLI - no Node.js / npm needed).
REM Download it from:
REM https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-windows-x64.exe

setlocal
cd /d "%~dp0"

if not exist "tools\tailwindcss.exe" (
    echo [ERROR] tools\tailwindcss.exe not found.
    echo Download the standalone Tailwind CLI into the tools folder - see the comments in this file.
    exit /b 1
)

if /i "%~1"=="watch" (
    tools\tailwindcss.exe -i src\main\tailwind\input.css -o src\main\webapp\css\tailwind.css --watch
) else (
    tools\tailwindcss.exe -i src\main\tailwind\input.css -o src\main\webapp\css\tailwind.css --minify
)
