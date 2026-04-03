@echo off
chcp 65001 >nul
title KAMALBLBAS CLEANUP TOOLBOX - ULTIMATE VERSION
color 0B

:: --- Check Admin ---
net session >nul 2>&1 || (echo ❌ Error: Run as Admin! & pause & exit)

set "owner=Kamal Blbas"

echo.
echo ######################################################
echo #                                                    #
echo #         🚀  KAMALBLBAS CLEANUP TOOLBOX  🚀         #
echo #       -----------------------------------          #
echo #          👤 Developed by: %owner%               #
echo #          🛠️  Version: 5.0 (Ultimate)            #
echo #                                                    #
echo ######################################################
echo.

:: --- 1. vMix Clean ---
echo [🛡️] 1. Removing vMix Registry u Folders...
taskkill /f /im vMix.exe /im vMix64.exe /t >nul 2>&1
rd /s /q "C:\Program Files (x86)\vMix" >nul 2>&1
rd /s /q "%AppData%\vMix" >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\StudioCoast\vMix" /f >nul 2>&1

:: --- 2. Adobe Cleanup (NEW) ---
echo [🎨] 2. Cleaning Adobe Cache u Common Files...
taskkill /f /im "Adobe Desktop Service.exe" /t >nul 2>&1
rd /s /q "%LocalAppData%\Adobe\Common\Media Cache Files" >nul 2>&1
rd /s /q "%AppData%\Adobe\Common\Media Cache Files" >nul 2>&1
rd /s /q "%LocalAppData%\Adobe\CameraRaw\Cache" >nul 2>&1
del /s /f /q "%temp%\Adobe*" >nul 2>&1

:: --- 3. Discord & Telegram (NEW) ---
echo [💬] 3. Cleaning Discord u Telegram Cache...
taskkill /f /im Discord.exe /t >nul 2>&1
taskkill /f /im Telegram.exe /t >nul 2>&1
rd /s /q "%AppData%\discord\Cache" >nul 2>&1
rd /s /q "%AppData%\discord\Code Cache" >nul 2>&1
rd /s /q "%AppData%\Telegram Desktop\tdata\user_data" >nul 2>&1

:: --- 4. System Cleanup ---
echo [🧹] 4. Cleaning System Temp u Logs...
del /s /f /q %temp%\*.* >nul 2>&1
rd /s /q %temp% >nul 2>&1 & mkdir %temp%
del /s /f /q C:\Windows\Temp\*.* >nul 2>&1

:: --- 5. Browser Cleanup ---
echo [🌐] 5. Cleaning Chrome u Opera Cache...
del /q /s /f "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
del /q /s /f "%AppData%\Opera Software\Opera Stable\Cache\*.*" >nul 2>&1

:: --- 6. Final Steps ---
echo [🗑️] 6. Flushing DNS u Recycle Bin...
ipconfig /flushdns >nul 2>&1
rd /s /q %systemdrive%\$Recycle.bin >nul 2>&1

echo.
echo ######################################################
echo ✅  DONE! %owner% Gian, Adobe u Media are Clean!
echo ######################################################
pause
