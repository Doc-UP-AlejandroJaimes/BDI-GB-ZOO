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
echo Ejecutando 01_tablas_independientes.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "01_tablas_independientes.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 01_tablas_independientes.sql
    exit /b %errorlevel%
)

echo Ejecutando 02_habitat.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "02_habitat.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 02_habitat.sql
    exit /b %errorlevel%
)

echo Ejecutando 03_especies.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "03_especies.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 03_especies.sql
    exit /b %errorlevel%
)

echo Ejecutando 04_habitat_visitantes.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "04_habitat_visitantes.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 04_habitat_visitantes.sql
    exit /b %errorlevel%
)

echo Ejecutando 05_cuidador.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "05_cuidador.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 05_cuidador.sql
    exit /b %errorlevel%
)

echo Ejecutando 06_animales.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "06_animales.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 06_animales.sql
    exit /b %errorlevel%
)

echo Todos los scripts SQL se ejecutaron correctamente.
endlocal
pause
