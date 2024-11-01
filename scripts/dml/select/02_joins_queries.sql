-- INNER JOIN
-- Mostrar el nombre comun de la familia y el estado de conservacion de la especie Delfín.
SELECT  E.NOMBRE AS ESPECIE, 
        EC.NOMBRE AS "ESTADO CONSERVACION",
        FA.NOMBRECOMUN AS FAMILIA
FROM ESPECIE E
INNER JOIN ESTADO_CONSERVACION EC ON E.IDEstadoConservacion = EC.ID
INNER JOIN FAMILIA FA ON E.IDFamilia = FA.ID
WHERE E.Nombre LIKE '%Delfín%';

-- RIGTH JOIN
-- MOSTRAR LOS CUIDADORES, ASI NO TENGAN ANIMAL ASIGNADO.
SELECT  CU.NOMBRE AS CUIDADOR, 
        A.NOMBRE AS ANIMAL
FROM ANIMALES A
RIGHT JOIN CUIDADOR CU ON A.IDCuidador = CU.ID;

-- LEFT JOIN
-- MOSTRAR LOS VISITANTES QUE NO HAYAN VISITADO NINGUN HABITAT
SELECT   V.NOMBRE AS VISITANTE
FROM VISITANTES V
LEFT JOIN HABITAT_VISITANTES HV ON HV.IDVisitantes = V.ID
WHERE HV.IDVisitantes IS NULL;

-- NATURAL JOIN
-- Mostrar las especialidades de los Cuidadores.
SELECT  CUIDADOR.NOMBRE AS CUIDADOR, 
        ESPECIALIDAD.NOMBRE AS ESPECIALIDAD
FROM CUIDADOR
NATURAL JOIN ESPECIALIDAD;

-- FULL JOIN
--Mostrar todos los animales, tengan cuidador o no.
SELECT  CU.NOMBRE AS CUIDADOR, 
        A.NOMBRE AS ANIMAL
FROM ANIMALES A
FULL JOIN CUIDADOR CU ON A.IDCuidador = CU.ID;

-- SELF JOIN
-- Encontrar todos los animales que comparten 
-- el mismo cuidador, para el cuidador con el id 1.
SELECT 
    a1.nombre AS animal_1, 
    a2.nombre AS animal_2, 
    a1.idcuidador
FROM animales a1
JOIN animales a2 ON a1.idcuidador = a2.idcuidador
WHERE a1.id <> a2.id
AND a1.idcuidador = 1;
