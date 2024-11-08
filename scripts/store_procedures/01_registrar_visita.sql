-- Procedimiento almacenado para registrar una visita y calcular el costo final
CREATE OR REPLACE PROCEDURE animals.registrar_visita(
    p_id_habitat INT,
    p_id_visitante INT,
    p_fecha_visita DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_costo_base NUMERIC;
    v_descuento NUMERIC;
    v_costo_final NUMERIC;
BEGIN
    -- Obtener el costo base del hábitat
    SELECT CostoBase 
    INTO v_costo_base 
    FROM animals.Habitat 
    WHERE ID = p_id_habitat;

    -- Obtener el descuento del tipo de visitante
    SELECT 
            Descuento 
    INTO    v_descuento 
    FROM animals.TIPO_VISITANTES TV
    JOIN animals.VISITANTES V ON V.IDTipoVisitante = TV.ID
    WHERE V.ID = p_id_visitante;

    -- Llamar a la función para calcular el costo final
    v_costo_final := animals.calcular_descuento(v_costo_base, v_descuento);

    -- Insertar la visita en la tabla Habitat_Visitantes con el costo calculado
    INSERT INTO animals.HABITAT_VISITANTES (IDHabitat, IDVisitantes, FechaVisita, CostoFinal)
    VALUES (p_id_habitat, p_id_visitante, p_fecha_visita, v_costo_final);
END;
$$;
