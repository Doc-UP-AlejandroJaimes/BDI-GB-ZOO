--Contar el número de animales por hábitat 
-- y mostrar solo aquellos hábitats que tienen 
-- más de 5 animales
SELECT H.NOMBRE AS HABITAT, 
       COUNT(A.ID) AS TOTAL_ANIMALES
FROM ANIMALES A
JOIN HABITAT H ON A.IDHABITAT = H.ID
GROUP BY H.NOMBRE
HAVING COUNT(A.ID) > 5;

-- Calcular el salario promedio por 
-- especialidad de cuidador y mostrar solo las 
-- especialidades con un salario promedio 
-- superior a $3,000,000
SELECT E.NOMBRE AS ESPECIALIDAD, 
       ROUND(AVG(C.SALARIO), 2) AS SALARIO_PROMEDIO
FROM CUIDADOR C
JOIN ESPECIALIDAD E ON C.IDESPECIALIDAD = E.ID
GROUP BY E.NOMBRE
HAVING AVG(C.SALARIO) > 3000000;

-- Calcular el promedio de edad de los animales 
-- en cada hábitat y mostrar solo los hábitats donde 
-- el promedio de edad supera los 5 años
SELECT 
       HA.NOMBRE AS HABITAT,
       ROUND(AVG(EXTRACT(YEAR FROM AGE(A.FechaNac))),2) AS EDAD_PROMEDIO_ANIMALES
FROM ANIMALES A
INNER JOIN HABITAT HA ON A.IDHabitat = HA.ID
GROUP BY HA.NOMBRE
HAVING AVG(EXTRACT(YEAR FROM AGE(A.FechaNac))) > 5;