-- Cuenta el número de visitantes que ha tenido un hábitat específico 
-- basado en su nombre. La función toma el nombre del hábitat como 
-- parámetro y devuelve la cantidad de visitantes.

CREATE OR REPLACE FUNCTION count_assistants_habitat(
    habitat_q VARCHAR
) 
    RETURNS INT
    LANGUAGE plpgsql
    AS 
$$
DECLARE
   assitants_count INT;
BEGIN
   -- 1. Query to search assistants by specific habitat
   SELECT COUNT(HV.*) total_assistants
   -- 2. save result in variable asssitants_count
   into assitants_count
   FROM HABITAT_VISITANTES HV
   INNER JOIN HABITAT H ON HV.IdHabitat = H.ID
   WHERE H.NOMBRE = habitat_q;
   -- 3. return result
   RETURN assitants_count;
END;
$$;