@echo off
setlocal enabledelayedexpansion
title Ultimate Hotspot Bypass (V1.0)

:: ========================================================
:: [CORE] ADMIN PRIVILEGES CHECK
:: ========================================================
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )

:: ========================================================
:: [CORE] MAIN MENU
:: ========================================================
:mainMenu
cls
echo ========================================================
echo          ULTIMATE HOTSPOT BYPASS TOOL (V1.0)
echo        https://github.com/hajimAIM/hotspot-bypass
echo ========================================================
echo.
echo   [ STATUS CHECK ]
echo   1. View Current Global Network Settings
echo.
echo   [ MANUAL BYPASS + DATA VERIFICATION ]
echo   2. Apply TTL 129 (Desktop-heavy plans)
echo   3. Apply TTL 65  (Mobile-heavy plans)
echo.
echo   [ UTILITIES ]
echo   4. Reset to Windows Default (TTL 128)
echo   5. AUTO-SCANNER (Find working TTL automatically)
echo.
echo ========================================================
set /p choice=Select an option (1-5): 

if '%choice%'=='1' goto checkSettings
if '%choice%'=='2' call :checkIPv6 & call :applyAndTest 129 & pause & goto mainMenu
if '%choice%'=='3' call :checkIPv6 & call :applyAndTest 65 & pause & goto mainMenu
if '%choice%'=='4' call :resetDefault & pause & goto mainMenu
if '%choice%'=='5' call :checkIPv6 & goto autoScanner
echo Invalid option. & pause & goto mainMenu

:: ========================================================
:: FUNCTION: View Settings
:: ========================================================
:checkSettings
echo.
echo Current Global IPv4 Configuration:
netsh int ipv4 show global | findstr "Default Hop Limit"
echo.
echo Current Global IPv6 Configuration:
netsh int ipv6 show global | findstr "Default Hop Limit"
pause
goto mainMenu

:: ========================================================
:: FUNCTION: Apply Manual TTL & Verify
:: ========================================================
:applyAndTest
set val=%1
echo.
echo --------------------------------------------------------
echo [ACTION] Applying TTL %val%...
netsh int ipv4 set global defaultcurhoplimit=%val% >nul
netsh int ipv6 set global defaultcurhoplimit=%val% >nul
echo [INFO] TTL set to %val%.
call :downloadTest
exit /b

:: ========================================================
:: FUNCTION: Reset Default
:: ========================================================
:resetDefault
echo.
echo [ACTION] Resetting to Windows default (128)...
netsh int ipv4 set global defaultcurhoplimit=128 >nul
netsh int ipv6 set global defaultcurhoplimit=128 >nul

echo [ACTION] Re-enabling IPv6 on all adapters (if disabled)...
powershell -Command "Get-NetAdapterBinding -ComponentID ms_tcpip6 | Enable-NetAdapterBinding"

echo [INFO] Reset complete.
exit /b

:: ========================================================
:: FUNCTION: Check IPv6
:: ========================================================
:checkIPv6
echo.
echo [CHECK] Verifying IPv6 status...
:: Check if any active adapter has IPv6 enabled
powershell -Command "$x = Get-NetAdapter | Where-Object Status -eq Up | Get-NetAdapterBinding -ComponentID ms_tcpip6 | Where-Object Enabled -eq True; if ($x) { exit 1 } else { exit 0 }"
if %errorlevel% equ 1 (
    echo [WARNING] IPv6 is currently ENABLED.
    echo IPv6 can leak data and cause the hotspot bypass to fail.
    echo It is HIGHLY RECOMMENDED to disable it.
    
    set /p "ipv6_choice=Disable IPv6 now? [Y/N]: "
    if /i "!ipv6_choice!"=="Y" (
        echo [ACTION] Disabling IPv6 on all adapters...
        powershell -Command "Get-NetAdapterBinding -ComponentID ms_tcpip6 | Disable-NetAdapterBinding"
        echo [INFO] IPv6 Disabled.
    ) else (
        echo [INFO] Proceeding with IPv6 Enabled.
    )
) else (
    echo [INFO] IPv6 is already disabled or not active.
)
echo.
exit /b

:: ========================================================
:: FUNCTION: Auto Scanner
:: ========================================================
:autoScanner
echo.
echo ========================================================
echo [AUTO-SCANNER] Testing common TTL values...
echo ========================================================
echo.

:: Range 1: 50-70
for /L %%t in (50,1,70) do (
    echo [TEST] Testing TTL %%t...
    netsh int ipv4 set global defaultcurhoplimit=%%t >nul
    netsh int ipv6 set global defaultcurhoplimit=%%t >nul
    
    call :downloadTest
    if !errorlevel! equ 0 (
        echo.
        echo [SUCCESS] Working TTL found: %%t
        echo [INFO] Keeping these settings.
        pause
        goto mainMenu
    )
    echo.
)

:: Range 2: 110-130
for /L %%t in (110,1,130) do (
    echo [TEST] Testing TTL %%t...
    netsh int ipv4 set global defaultcurhoplimit=%%t >nul
    netsh int ipv6 set global defaultcurhoplimit=%%t >nul
    
    call :downloadTest
    if !errorlevel! equ 0 (
        echo.
        echo [SUCCESS] Working TTL found: %%t
        echo [INFO] Keeping these settings.
        pause
        goto mainMenu
    )
    echo.
)

echo [FAIL] No working TTL found in common list.
echo Resetting to default...
call :resetDefault
pause
goto mainMenu

:: ========================================================
:: FUNCTION: Download Test
:: ========================================================
:downloadTest
echo [VERIFY] Attempting 15MB download test...
set "test_url=https://link.testfile.org/15MB"
set "temp_file=%temp%\network_test.tmp"

:: Using curl for download (Standard in Win 10/11)
curl --connect-timeout 5 --max-time 30 -L -o "%temp_file%" "%test_url%"
set dl_error=%errorlevel%

if %dl_error% equ 0 (
    echo [PASS] Download completed successfully.
    del "%temp_file%" >nul 2>&1
    exit /b 0
) else (
    echo [FAIL] Download failed or timed out. (Error Code: %dl_error%)
    if exist "%temp_file%" del "%temp_file%" >nul 2>&1
    exit /b 1
)