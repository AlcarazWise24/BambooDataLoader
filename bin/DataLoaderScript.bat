@echo off

:: Define directories
set "outputDir=C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2\Bamboo\Logs"
set "successDir=C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2\Bamboo\Logs\Success"
set "errorDir=C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2\Bamboo\Logs\Errors"
set "processPath=C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2\bin\process.bat"

:: Ensure directories exist
if not exist "%successDir%" mkdir "%successDir%"
echo Created Success Directory
if not exist "%errorDir%" mkdir "%errorDir%"
echo Created Error Directory

echo Running Upsert Patient
call :runAndMove "upsertPatient" "Patient"
echo Running Upsert EncounterOrg
call :runAndMove "upsertEncounterOrg" "EncounterOrg"
echo Running Upsert ProviderContact
call :runAndMove "upsertProviderContact" "ProviderContact"
echo Running Upsert Clinical Encounter
call :runAndMove "upsertClinicalEncounter" "ClinicalEncounter"
echo All processes completed successfully.
goto :eof

:runAndMove
call "%processPath%" "C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2\Bamboo\Conf" %1
if %ERRORLEVEL% neq 0 (
    echo An error occurred during %2. Check DataLoader logs for details.
    exit /b
)
call :moveFiles %2
goto :eof

:moveFiles
PowerShell -Command "& {$sourceDir='%outputDir%';$successDir='%successDir%';$errorDir='%errorDir%';$operation='%1';$currentDateTime=Get-Date -Format 'yyyyMMddHHmmss';$successFile=Get-ChildItem -Path $sourceDir -Filter '*success.csv';$errorFile=Get-ChildItem -Path $sourceDir -Filter '*error.csv';if($successFile){$newSuccessName=$operation+'Success_'+$currentDateTime+'.csv';Move-Item $successFile.FullName -Destination (Join-Path $successDir $newSuccessName)};if($errorFile){$newErrorName=$operation+'Error_'+$currentDateTime+'.csv';Move-Item $errorFile.FullName -Destination (Join-Path $errorDir $newErrorName)}}"
goto :eof
