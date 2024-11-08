-- LIKE
-- % The percent sign represents zero, one, or multiple characters
-- _ The underscore sign represents one, single character


-- UNION
-- Obtener los animales que empiecen por B 
-- y los animales que empiecen por C, sin duplicados.

SELECT A.NOMBRE AS ANIMALES
FROM ANIMALES A
WHERE A.NOMBRE ILIKE 'B%'
UNION
SELECT A.NOMBRE AS ANIMALES
FROM ANIMALES A
WHERE A.NOMBRE ILIKE 'C%';

-- UNION ALL
-- Mostrar los visitantes que visitaron dos veces o mas 
-- distintos habitats y que su nombre empiece por J, 
-- unido a los visitantes que su nombre empiece por 
-- He con tilde o sin tilde.
SELECT V.NOMBRE AS visitante,
       COUNT(DISTINCT HV.IDHabitat) AS habitats_visitados
FROM HABITAT_VISITANTES HV
JOIN VISITANTES V ON HV.IDVisitantes = V.ID
WHERE V.NOMBRE LIKE 'J%'
GROUP BY V.NOMBRE
HAVING COUNT(DISTINCT HV.IDHabitat) >= 2
UNION ALL
SELECT V.NOMBRE AS visitante,
       COUNT(DISTINCT HV.IDHabitat) AS habitats_visitados
FROM HABITAT_VISITANTES HV
JOIN VISITANTES V ON HV.IDVisitantes = V.ID
WHERE V.NOMBRE LIKE 'He%' OR V.NOMBRE LIKE 'Hé%'
GROUP BY V.NOMBRE
HAVING COUNT(DISTINCT HV.IDHabitat) >= 2;

-- INTERSECT
-- Mostrar los cuidadores que están a cargo 
-- tanto de animales en preocupacion menor como 
-- de animales vulnerables.
SELECT C.NOMBRE
FROM CUIDADOR C
JOIN ANIMALES A ON C.ID = A.IDCuidador
JOIN ESPECIE E ON A.IDEspecie = E.ID
JOIN ESTADO_CONSERVACION EC ON E.IDEstadoConservacion = EC.ID
WHERE EC.CODIGO = 'LC' -- Preocupacion menor
INTERSECT
SELECT C.NOMBRE
FROM CUIDADOR C
JOIN ANIMALES A ON C.ID = A.IDCuidador
JOIN ESPECIE E ON A.IDEspecie = E.ID
JOIN ESTADO_CONSERVACION EC ON E.IDEstadoConservacion = EC.ID
WHERE EC.CODIGO = 'VU'; -- Vulnerable


-- EXCEPT
-- Contar los visitantes que han visitado algún hábitat, 
--excluyendo aquellos que han visitado el 
-- hábitat de las "Costa Rocosa".
SELECT COUNT(*) AS visitantes_excluidos
FROM (
    SELECT DISTINCT V.ID
    FROM VISITANTES V
    JOIN HABITAT_VISITANTES HV ON V.ID = HV.IDVisitantes
    JOIN HABITAT H ON HV.IDHabitat = H.ID
    EXCEPT
    SELECT DISTINCT V.ID
    FROM VISITANTES V
    JOIN HABITAT_VISITANTES HV ON V.ID = HV.IDVisitantes
    JOIN HABITAT H ON HV.IDHabitat = H.ID
    WHERE H.NOMBRE = 'Costa Rocosa'
) AS visitantes_filtrados;


-- Cuenta el número de visitantes que ha tenido un hábitat 
-- específico basado en su nombre. La función toma el nombre 
-- del hábitat como parámetro y devuelve la cantidad de visitantes.

-- 1. Build query
-- Related tables: Habitat_visitantes, habitat
SELECT
    H.nombre as HABITAT,
    COUNT(HV.*) AS VISITAS_HABITAT
FROM HABITAT_VISITANTES HV
INNER JOIN HABITAT H ON HV.IdHabitat = H.ID
WHERE H.nombre = 'Exhibición de biomas'
GROUP BY H.nombre;

-- 2. Build function
CREATE OR REPLACE FUNCTION contar_visitas_habitat(
    habitat_q VARCHAR
)
    RETURNS INT
    LANGUAGE plpgsql
    AS
$$
DECLARE
    -- DECLARE
    contador_visitantes INT;
BEGIN
    -- BODY FUNCTION
    -- 1. Query statement
    SELECT
    COUNT(HV.*) AS VISITAS_HABITAT
    INTO contador_visitantes
    FROM HABITAT_VISITANTES HV
    INNER JOIN HABITAT H ON HV.IdHabitat = H.ID
    -- 2. Apply condition statement
    WHERE H.nombre = habitat_q;
    -- 2. storage value into declare variable.
    -- 3. returns value;
    RETURN contador_visitantes;
END;
$$;

SELECT V.NOMBRE AS VISITANTE,
       TV.NOMBRE AS TIPO_VISITANTE,
       TV.DESCUENTO AS DESCUENTO
FROM VISITANTES V
INNER JOIN TIPO_VISITANTES TV ON V.IDTipoVisitante = TV.ID
LIMIT 4;