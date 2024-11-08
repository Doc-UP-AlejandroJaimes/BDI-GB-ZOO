-- Función para calcular el descuento sobre el costo base
CREATE OR REPLACE FUNCTION animals.calcular_descuento(
    p_costo_base NUMERIC,
    p_descuento NUMERIC
) RETURNS NUMERIC AS $$
DECLARE
    v_costo_final NUMERIC;
BEGIN
    -- Calcular el costo final aplicando el descuento
    v_costo_final := p_costo_base * (1 - p_descuento / 100);
    RETURN v_costo_final;
END;
$$ LANGUAGE plpgsql;
