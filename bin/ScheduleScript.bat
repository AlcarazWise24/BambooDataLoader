@echo off
setlocal EnableDelayedExpansion

set "sourceDir=C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2\Bamboo\Data\ToUpdate"
set "destinationDir=C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2\Bamboo\Data\Updated"
set "scriptToRun=C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2\bin\DataLoaderScript.bat"
set "logDir=C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2\Bamboo\Logs"

:: Generate a timestamp for the log file
set "timestamp=%DATE:~-4%%DATE:~4,2%%DATE:~7,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
:: Replace any spaces with zeros (for single-digit hours)
set "timestamp=!timestamp: =0!"

set "logFile=ScriptLog_!timestamp!.txt"

:: Ensure log directory exists
if not exist "%logDir%" mkdir "%logDir%"

:: Execute the main script logic and redirect output to log file
(
    echo Checking for files to update...
    dir "%sourceDir%" /b /a-d >nul 2>&1
    if errorlevel 1 (
        echo No files found in %sourceDir%.
    ) else (
        echo Files found. Executing script...
        call "%scriptToRun%"
        
        echo Moving files to the Updated folder...
        move "%sourceDir%\*.*" "%destinationDir%"
    )
) > "%logDir%\%logFile%" 2>&1

:: Output a message to the console to indicate that the script output was saved to the log file
echo The script output was saved to %logDir%\%logFile%

endlocal
