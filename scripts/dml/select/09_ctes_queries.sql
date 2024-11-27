-- Calcular cuales fueron los habitats con más visitas
-- de los ultimos 5 años y cual es su recaudo total.
-- CTE1: Filtrar Visitas de los ultimos 5 años -> FilterPeriodVisits
-- CTE2: Contar visitas y recaudo total por habitat y año -> CountVisitedHabitat
-- CTE3: Seleccionar el habitat mas visitado por cada año -> MostVisitedHabitat
-- CTE4: Obtener los nombres de los hábitats y sus datos agrupados por año -> HabitatMapping
WITH FilterPeriodVisits AS (
	SELECT fp.idhabitat,
	       fp.costofinal,
		   EXTRACT(YEAR FROM fp.fechavisita) as anio
	FROM habitat_visitantes fp
	WHERE fp.fechavisita >= CURRENT_DATE - INTERVAL '5 years'
),
CountVisitedHabitat AS (
	SELECT fp.idhabitat,
	       fp.anio,
		   COUNT(*) AS total_visitas,
		   SUM(fp.costofinal) AS total_recaudado
    FROM FilterPeriodVisits fp
	GROUP BY fp.idhabitat, fp.anio
	ORDER BY fp.anio DESC, total_visitas DESC
),
MostVisitedHabitat AS (
	SELECT 	cv.idhabitat,
	       	cv.anio,
		   	cv.total_visitas,
		   	cv.total_recaudado
    FROM 
			CountVisitedHabitat cv
	WHERE cv.total_visitas = (
		-- Seleccionar el maximo de visitas por año
		SELECT MAX(subq.total_visitas)
		FROM CountVisitedHabitat subq
		WHERE cv.anio = subq.anio
	)  
),
HabitatMapping AS (
	SELECT h.Nombre AS Habitat,
		   h.costobase,
		   mv.anio,
		   mv.total_visitas,
		   mv.total_recaudado
	FROM habitat h
	INNER JOIN MostVisitedHabitat mv ON h.id = mv.idhabitat
)

SELECT * FROM HabitatMapping;