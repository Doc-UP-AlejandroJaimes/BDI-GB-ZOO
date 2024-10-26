DO
$$
DECLARE
    tabla RECORD;
BEGIN
    -- Desactiva temporalmente las restricciones de clave externa
    PERFORM 'SET session_replication_role = replica';

    -- Itera sobre cada tabla en el esquema público y ejecuta TRUNCATE
    FOR tabla IN
        SELECT tablename FROM pg_tables
        WHERE schemaname = 'public'
    LOOP
        EXECUTE 'TRUNCATE TABLE public.' || quote_ident(tabla.tablename) || ' RESTART IDENTITY CASCADE';
    END LOOP;

    -- Reactiva las restricciones de clave externa
    PERFORM 'SET session_replication_role = DEFAULT';
END;
$$;


-- TABLES
--  public  | animales            | tabla | adminzoo
--  public  | clima               | tabla | adminzoo
--  public  | cuidador            | tabla | adminzoo
--  public  | especialidad        | tabla | adminzoo
--  public  | especie             | tabla | adminzoo
--  public  | estado_conservacion | tabla | adminzoo
--  public  | familia             | tabla | adminzoo
--  public  | habitat             | tabla | adminzoo
--  public  | habitat_visitantes  | tabla | adminzoo
--  public  | ubicacion           | tabla | adminzoo
--  public  | visitantes          | tabla | adminzoo