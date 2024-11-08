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
echo Ejecutando 01_separate_tables.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "C:\Users\PERSONAL\Documents\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\scripts\dml\insert\01_separate_tables.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 01_separate_tables.sql
    exit /b %errorlevel%
)

echo Ejecutando 02_visitantes.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "C:\Users\PERSONAL\Documents\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\scripts\dml\insert\02_visitantes.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 02_visitantes.sql
    exit /b %errorlevel%
)

echo Ejecutando 03_habitat.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "C:\Users\PERSONAL\Documents\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\scripts\dml\insert\03_habitat.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 03_habitat.sql
    exit /b %errorlevel%
)

echo Ejecutando 04_especies.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "C:\Users\PERSONAL\Documents\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\scripts\dml\insert\04_especies.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 04_especies.sql
    exit /b %errorlevel%
)

echo Ejecutando 05_cuidador.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "C:\Users\PERSONAL\Documents\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\scripts\dml\insert\05_cuidador.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 05_cuidador.sql
    exit /b %errorlevel%
)

echo Ejecutando 06_animales.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "C:\Users\PERSONAL\Documents\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\scripts\dml\insert\06_animales.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 06_animales.sql
    exit /b %errorlevel%
)

echo Ejecutando 07_habitat_visitantes.sql...
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "C:\Users\PERSONAL\Documents\GitHub - Projects\Doc-UP-AlejandroJaimes\BDI-GB-ZOO\scripts\dml\insert\07_habitat_visitantes.sql"
if %errorlevel% neq 0 (
    echo Error ejecutando 07_habitat_visitantes.sql
    exit /b %errorlevel%
)

echo Todos los scripts SQL se ejecutaron correctamente.
endlocal
pause
