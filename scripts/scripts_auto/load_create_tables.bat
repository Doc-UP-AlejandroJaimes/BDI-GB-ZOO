@echo off
chcp 65001
setlocal

:: Configura las variables de conexión
set "PGHOST=localhost"
set "PGPORT=5432"
set "PGUSER=*******"
set "PGPASSWORD=*******"
set "PGDATABASE=*******"

:: Ejecuta cada archivo SQL en orden

echo Ejecutando TableDefinitions.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "TableDefinitions.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando TableDefinitions.sql
    exit /b %errorlevel%
)

echo Script ejecutado correctamente.
endlocal
pause