@echo off
chcp 65001
setlocal

:: Configura las variables de conexión
set "PGHOST=*******"
set "PGPORT=****"
set "PGUSER=*******"
set "PGPASSWORD=*******"
set "PGDATABASE=******"

:: Configura el directorio de backups
set "BACKUP_DIR=*******\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\data\backups"

:: Obtiene la fecha en formato ddMMyyyy y la hora en formato HHmm
for /f "tokens=2-4 delims=/ " %%a in ('echo %date%') do (
    set "DAY=%%a"
    set "MONTH=%%b"
    set "YEAR=%%c"
)

for /f "tokens=1-2 delims=:" %%a in ("%time: =0%") do (
    set "HOUR=%%a"
    set "MINUTE=%%b"
)

:: Crea el nombre del archivo de backup con el formato deseado
set "BACKUP_FILE=%BACKUP_DIR%\bk_zoo_%DAY%%MONTH%%YEAR%%HOUR%%MINUTE%.sql"

:: Ejecuta el backup
echo Iniciando backup de la base de datos: %PGDATABASE%
"pg_dump" -U %PGUSER% -h %PGHOST% -p %PGPORT% -F c -b -v -f "%BACKUP_FILE%" %PGDATABASE%

:: Verifica si el comando fue exitoso
if %errorlevel% neq 0 (
    echo Error al realizar el backup.
    exit /b %errorlevel%
) else (
    echo Backup completado exitosamente. Archivo creado: %BACKUP_FILE%
)

endlocal
pause
