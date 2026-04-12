@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title KAMALBLBAS CLEANUP TOOLBOX v6.3 - STABLE
color 0B

:: ====================================================
:: Admin Check
:: ====================================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] تکایە بە Administrator ەوە بیکەرەوە!
    echo [ERROR] Right-click ^> Run as administrator
    pause
    exit /b
)

:: ====================================================
:: Settings
:: ====================================================
set "owner=Kamal Blbas"
set "logdate=%date:~-4,4%%date:~-10,2%%date:~-7,2%"
set "logfile=%USERPROFILE%\Desktop\Cleanup_Log_%logdate%.txt"

:: ====================================================
:: Initialize Log
:: ====================================================
echo ========================================== > "%logfile%"
echo   KAMALBLBAS CLEANUP TOOLBOX v6.3 LOG >> "%logfile%"
echo   Date: %date% Time: %time% >> "%logfile%"
echo   User: %USERNAME% >> "%logfile%"
echo ========================================== >> "%logfile%"
echo. >> "%logfile%"

:menu
cls
echo ==========================================
echo    KAMALBLBAS CLEANUP TOOLBOX v6.3
echo    Developer: %owner%
echo ==========================================
echo.
echo  [1] Clean vMix (Complete Removal)
echo  [2] Clean Adobe Cache
echo  [3] Clean Discord and Telegram
echo  [4] Clean Chrome/Opera/Edge
echo  [5] Clean System Temp
echo  [6] Clean Windows Update
echo  [7] Flush DNS + Thumbnails
echo  [8] Empty Recycle Bin
echo  [9] RUN ALL (Full Clean)
echo.
echo  [L] View Log (بینینی لۆگ)
echo  [O] Open Log Folder (کردنەوەی فۆڵدەر)
echo.
echo  [0] Exit
echo ------------------------------------------
echo  Log: Desktop\Cleanup_Log_%logdate%.txt
echo ------------------------------------------
set /p choice="Select option (0-9,L,O): "

if /i "%choice%"=="L" goto view_log
if /i "%choice%"=="O" goto open_folder
if "%choice%"=="1" goto clean_vmix
if "%choice%"=="2" goto clean_adobe
if "%choice%"=="3" goto clean_chat
if "%choice%"=="4" goto clean_browser
if "%choice%"=="5" goto clean_temp
if "%choice%"=="6" goto clean_update
if "%choice%"=="7" goto clean_dns
if "%choice%"=="8" goto clean_bin
if "%choice%"=="9" goto clean_all
if "%choice%"=="0" goto end
goto menu

:: ====================================================
:: View Log
:: ====================================================
:view_log
cls
echo ==========================================
echo            LOG FILE CONTENT
echo ==========================================
echo.
if exist "%logfile%" (
    type "%logfile%"
    echo.
    echo ==========================================
    echo File: %logfile%
) else (
    echo [ERROR] Log file not found!
)
echo.
pause
goto menu

:: ====================================================
:: Open Folder
:: ====================================================
:open_folder
start "" "%USERPROFILE%\Desktop"
goto menu

:: ====================================================
:: Clean vMix
:: ====================================================
:clean_vmix
cls
echo [*] vMix Cleanup Started... >> "%logfile%"
echo.
echo [*] Stopping vMix processes...
taskkill /f /im vMix.exe >nul 2>&1
taskkill /f /im vMix64.exe >nul 2>&1
timeout /t 2 >nul
echo [*] Removing vMix folders...
if exist "C:\Program Files (x86)\vMix" (
    rd /s /q "C:\Program Files (x86)\vMix"
    echo   - Removed Program Files\vMix >> "%logfile%"
)
if exist "%AppData%\vMix" (
    rd /s /q "%AppData%\vMix"
    echo   - Removed AppData\vMix >> "%logfile%"
)
echo [*] Cleaning registry...
reg delete "HKCU\Software\StudioCoast\vMix" /f >nul 2>&1
echo [*] vMix Cleaned Successfully >> "%logfile%"
echo [OK] vMix cleaned!
pause
goto menu

:: ====================================================
:: Clean Adobe
:: ====================================================
:clean_adobe
cls
echo [*] Adobe Cleanup Started... >> "%logfile%"
echo.
echo [*] Stopping Adobe services...
taskkill /f /im "Adobe Desktop Service.exe" >nul 2>&1
timeout /t 2 >nul
echo [*] Cleaning cache folders...
if exist "%LocalAppData%\Adobe\Common\Media Cache Files" (
    rd /s /q "%LocalAppData%\Adobe\Common\Media Cache Files"
    echo   - Removed Media Cache >> "%logfile%"
)
if exist "%AppData%\Adobe\Common\Media Cache Files" (
    rd /s /q "%AppData%\Adobe\Common\Media Cache Files"
    echo   - Removed AppData Media Cache >> "%logfile%"
)
if exist "%LocalAppData%\Adobe\CameraRaw\Cache" (
    rd /s /q "%LocalAppData%\Adobe\CameraRaw\Cache"
    echo   - Removed CameraRaw Cache >> "%logfile%"
)
echo [*] Adobe Cleaned Successfully >> "%logfile%"
echo [OK] Adobe cache cleaned!
pause
goto menu

:: ====================================================
:: Clean Chat Apps
:: ====================================================
:clean_chat
cls
echo [*] Chat Apps Cleanup Started... >> "%logfile%"
echo.
echo [*] Stopping Discord/Telegram...
taskkill /f /im Discord.exe >nul 2>&1
taskkill /f /im Telegram.exe >nul 2>&1
timeout /t 2 >nul
echo [*] Cleaning Discord cache...
if exist "%AppData%\discord\Cache" rd /s /q "%AppData%\discord\Cache"
if exist "%AppData%\discord\Code Cache" rd /s /q "%AppData%\discord\Code Cache"
echo [*] Cleaning Telegram cache...
if exist "%AppData%\Telegram Desktop\tdata\user_data\cache" rd /s /q "%AppData%\Telegram Desktop\tdata\user_data\cache"
echo [*] Chat Apps Cleaned Successfully >> "%logfile%"
echo [OK] Messengers cleaned!
pause
goto menu

:: ====================================================
:: Clean Browsers
:: ====================================================
:clean_browser
cls
echo [*] Browser Cleanup Started... >> "%logfile%"
echo.
echo [*] Stopping browsers...
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im opera.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
timeout /t 2 >nul
echo [*] Cleaning Chrome...
if exist "%LocalAppData%\Google\Chrome\User Data\Default\Cache" rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache"
if exist "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache" rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache"
echo [*] Cleaning Opera...
if exist "%AppData%\Opera Software\Opera Stable\Cache" rd /s /q "%AppData%\Opera Software\Opera Stable\Cache"
echo [*] Cleaning Edge...
if exist "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache"
echo [*] Browsers Cleaned Successfully >> "%logfile%"
echo [OK] Browsers cleaned!
pause
goto menu

:: ====================================================
:: Clean Temp
:: ====================================================
:clean_temp
cls
echo [*] System Temp Cleanup Started... >> "%logfile%"
echo.
echo [*] Cleaning User Temp...
del /s /f /q "%temp%\*.*" >nul 2>&1
echo [*] Cleaning Windows Temp...
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
echo [*] Cleaning Prefetch...
del /s /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1
echo [*] System Temp Cleaned Successfully >> "%logfile%"
echo [OK] System temp cleaned!
pause
goto menu

:: ====================================================
:: Clean Windows Update
:: ====================================================
:clean_update
cls
echo [*] Windows Update Cleanup Started... >> "%logfile%"
echo.
echo [*] Stopping services...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
echo [*] Cleaning downloads...
if exist "C:\Windows\SoftwareDistribution\Download" (
    rd /s /q "C:\Windows\SoftwareDistribution\Download"
    md "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
    echo   - Cleaned SoftwareDistribution >> "%logfile%"
)
echo [*] Cleaning error logs...
del /s /f /q "C:\Windows\Logs\CBS\*.*" >nul 2>&1
del /s /f /q "%LocalAppData%\Microsoft\Windows\WER\*.*" >nul 2>&1
echo [*] Restarting services...
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo [*] Windows Update Cleaned Successfully >> "%logfile%"
echo [OK] Windows Update cleaned!
pause
goto menu

:: ====================================================
:: Clean DNS
:: ====================================================
:clean_dns
cls
echo [*] DNS Cleanup Started... >> "%logfile%"
echo.
echo [*] Flushing DNS...
ipconfig /flushdns >nul 2>&1
echo [*] Cleaning thumbnails...
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo [*] Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo [*] DNS Cleaned Successfully >> "%logfile%"
echo [OK] DNS and Thumbnails cleaned!
pause
goto menu

:: ====================================================
:: Clean Recycle Bin
:: ====================================================
:clean_bin
cls
echo [*] Recycle Bin Cleanup Started... >> "%logfile%"
echo.
echo [*] Emptying Recycle Bin...
rd /s /q %systemdrive%\$Recycle.bin >nul 2>&1
echo [*] Recycle Bin Emptied Successfully >> "%logfile%"
echo [OK] Recycle Bin emptied!
pause
goto menu

:: ====================================================
:: Full Clean (Option 9)
:: ====================================================
:clean_all
cls
echo.
echo [!] WARNING: This will clean EVERYTHING!
echo [!] سڵاو! ئەمە هەموو شتێک دەسڕێتەوە!
set /p confirm="Continue? (Y/N): "
if /i not "%confirm%"=="Y" goto menu

echo. >> "%logfile%"
echo ========================================== >> "%logfile%"
echo [*] FULL CLEAN STARTED >> "%logfile%"
echo [*] Time: %time% >> "%logfile%"
echo ========================================== >> "%logfile%"

echo.
echo [*] Starting full clean... Please wait...
echo.

call :do_vmix
call :do_adobe
call :do_chat
call :do_browser
call :do_temp
call :do_update
call :do_dns
call :do_bin

echo. >> "%logfile%"
echo ========================================== >> "%logfile%"
echo [*] FULL CLEAN COMPLETED >> "%logfile%"
echo [*] Time: %time% >> "%logfile%"
echo ========================================== >> "%logfile%"

echo.
echo ==========================================
echo    [SUCCESS] Full clean completed!
echo ==========================================
echo.
echo [*] Log saved to Desktop:
echo     Cleanup_Log_%logdate%.txt
echo.
echo [V] View log now?
set /p viewlog="(Y/N): "
if /i "%viewlog%"=="Y" goto view_log
goto menu

:: ====================================================
:: Silent Functions for Full Clean
:: ====================================================
:do_vmix
echo [1/8] Cleaning vMix...
taskkill /f /im vMix.exe >nul 2>&1
taskkill /f /im vMix64.exe >nul 2>&1
rd /s /q "C:\Program Files (x86)\vMix" >nul 2>&1
rd /s /q "%AppData%\vMix" >nul 2>&1
reg delete "HKCU\Software\StudioCoast\vMix" /f >nul 2>&1
echo   [OK] vMix >> "%logfile%"
timeout /t 1 >nul
goto :eof

:do_adobe
echo [2/8] Cleaning Adobe...
taskkill /f /im "Adobe Desktop Service.exe" >nul 2>&1
rd /s /q "%LocalAppData%\Adobe\Common\Media Cache Files" >nul 2>&1
rd /s /q "%AppData%\Adobe\Common\Media Cache Files" >nul 2>&1
rd /s /q "%LocalAppData%\Adobe\CameraRaw\Cache" >nul 2>&1
echo   [OK] Adobe >> "%logfile%"
goto :eof

:do_chat
echo [3/8] Cleaning Discord/Telegram...
taskkill /f /im Discord.exe >nul 2>&1
taskkill /f /im Telegram.exe >nul 2>&1
rd /s /q "%AppData%\discord\Cache" >nul 2>&1
rd /s /q "%AppData%\Telegram Desktop\tdata\user_data\cache" >nul 2>&1
echo   [OK] Chat Apps >> "%logfile%"
goto :eof

:do_browser
echo [4/8] Cleaning Browsers...
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im opera.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
rd /s /q "%AppData%\Opera Software\Opera Stable\Cache" >nul 2>&1
echo   [OK] Browsers >> "%logfile%"
goto :eof

:do_temp
echo [5/8] Cleaning System Temp...
del /s /f /q "%temp%\*.*" >nul 2>&1
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
del /s /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1
echo   [OK] System Temp >> "%logfile%"
goto :eof

:do_update
echo [6/8] Cleaning Windows Update...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
md "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo   [OK] Windows Update >> "%logfile%"
goto :eof

:do_dns
echo [7/8] Flushing DNS...
ipconfig /flushdns >nul 2>&1
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo   [OK] DNS >> "%logfile%"
goto :eof

:do_bin
echo [8/8] Emptying Recycle Bin...
rd /s /q %systemdrive%\$Recycle.bin >nul 2>&1
echo   [OK] Recycle Bin >> "%logfile%"
goto :eof

:: ====================================================
:: Exit
:: ====================================================
:end
cls
echo ==========================================
echo  Thank you for using KAMALBLBAS TOOLBOX!
echo  Log saved: Desktop\Cleanup_Log_%logdate%.txt
echo ==========================================
echo.
timeout /t 3 >nul
exit
