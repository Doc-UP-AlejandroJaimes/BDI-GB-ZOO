@echo off
chcp 65001
setlocal

:: Configura las variables de conexión
set "PGHOST=*******"
set "PGPORT=****"
set "PGUSER=*******"
set "PGPASSWORD=*******"
set "PGDATABASE=******"

:: Ejecuta cada archivo SQL en orden

echo Ejecutando FUNCTION-CalcularCostoTotal.sql ...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "C:\Users\PERSONAL\Documents\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\scripts\functions\01_calcular_costo_total.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 01_calcular_costo_total.sql
    exit /b %errorlevel%
)

echo Ejecutando STOREPROCEDURE-RegistrarVisita.sql ...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "C:\Users\PERSONAL\Documents\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\scripts\store_procedures\01_registrar_visita.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 01_registrar_visita.sql
    exit /b %errorlevel%
)

echo Script ejecutado correctamente.
endlocal
pause