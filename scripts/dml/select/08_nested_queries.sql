-- 1. Subquery 
-- Obtener el hábitat con el costo base más alto junto con su ubicación y tipo de clima.

SELECT h.Nombre AS Habitat, u.Nombre AS Ubicacion, c.Nombre AS Clima, h.CostoBase
FROM animals.HABITAT h
JOIN animals.UBICACION u ON h.IDUbicacion = u.ID
JOIN animals.CLIMA c ON h.IDClima = c.ID
WHERE h.CostoBase = (SELECT MAX(CostoBase) FROM animals.HABITAT);

-- 2. Subquery
-- Listar los cuidadores cuyo salario está por encima del promedio.
SELECT Nombre, Salario
FROM animals.CUIDADOR
WHERE Salario > (SELECT AVG(Salario) FROM animals.CUIDADOR);

-- 3. CTE
-- Calcular el número total de visitantes y el recaudo total por hábitat.
WITH RecaudoPorHabitat AS (
    SELECT hv.IDHabitat, COUNT(hv.IDVisitantes) AS TotalVisitantes, SUM(hv.CostoFinal) AS RecaudoTotal
    FROM animals.HABITAT_VISITANTES hv
    GROUP BY hv.IDHabitat
)
SELECT h.Nombre AS Habitat, rph.TotalVisitantes, rph.RecaudoTotal
FROM RecaudoPorHabitat rph
JOIN animals.HABITAT h ON rph.IDHabitat = h.ID;

-- 4. CTE
-- Encontrar el número de especies por familia taxonómica.
WITH EspeciesPorFamilia AS (
    SELECT f.NombreCientifico, COUNT(e.ID) AS TotalEspecies
    FROM animals.FAMILIA f
    JOIN animals.ESPECIE e ON f.ID = e.IDFamilia
    GROUP BY f.NombreCientifico
)
SELECT NombreCientifico AS Familia, TotalEspecies
FROM EspeciesPorFamilia
ORDER BY TotalEspecies DESC;


-- 5. Combinando Subquery y CTE
-- Calcular el hábitat más visitado en el último año y mostrar el nombre del hábitat,
-- la cantidad de visitas y el recaudo total.
WITH VisitasRecientes AS (
    SELECT IDHabitat, COUNT(IDVisitantes) AS TotalVisitas, SUM(CostoFinal) AS RecaudoTotal
    FROM animals.HABITAT_VISITANTES
    WHERE FechaVisita >= CURRENT_DATE - INTERVAL '1 year'
    GROUP BY IDHabitat
),
HabitatMasVisitado AS (
    SELECT IDHabitat
    FROM VisitasRecientes
    WHERE TotalVisitas = (SELECT MAX(TotalVisitas) FROM VisitasRecientes)
)
SELECT h.Nombre AS Habitat, vr.TotalVisitas, vr.RecaudoTotal
FROM VisitasRecientes vr
JOIN HabitatMasVisitado hmv ON vr.IDHabitat = hmv.IDHabitat
JOIN animals.HABITAT h ON hmv.IDHabitat = h.ID;
