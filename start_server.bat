@echo off
title ComicCraft - AI Comic Story Creator
cd /d "%~dp0"
echo ========================================================
echo   Starting ComicCraft - AI Comic Story Creator
echo ========================================================
echo.
echo Website will open at: http://127.0.0.1:8000
echo Swagger API docs at:  http://127.0.0.1:8000/docs
echo.
python -m uvicorn app.main:app --reload --host 127.0.0.1 --port 8000
pause
