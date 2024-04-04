@echo off
setlocal

set DATALOADER_DIR=C:\Users\david\OneDrive\Documentos\WiseWolves\Bamboo\dataloader_v60.0.2
set CONFIG_DIR=%DATALOADER_DIR%\Bamboo\Conf

"%DATALOADER_DIR%\bin\process.bat" -c "%CONFIG_DIR%" upsertAccount

endlocal
pause


