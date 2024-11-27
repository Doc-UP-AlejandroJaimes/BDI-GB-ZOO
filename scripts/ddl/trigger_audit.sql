-- 1. Crear una tabla auditoria, que registre las 
-- actualizaciones en la tabla animales.
CREATE TABLE animals.AUDITORIA_ANIMALES (
    ID SERIAL PRIMARY KEY,
    IDAnimal INT,
    NombreAnterior VARCHAR(50),
    NombreNuevo VARCHAR(50),
	FechaNacAnterior DATE,
	FechaNacNueva DATE,
	ActualizadoPor VARCHAR(50),
    FechaCambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Crear función para registrar auditoría
CREATE OR REPLACE FUNCTION registrar_cambios_animales()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO animals.AUDITORIA_ANIMALES (IDAnimal, NombreAnterior, NombreNuevo, FechaNacAnterior, FechaNacNueva, ActualizadoPor)
    VALUES (
        OLD.ID,
        OLD.Nombre, --Nombre antes del cambio.
        NEW.Nombre, -- Nombre despúes del cambio.
        CASE WHEN OLD.FechaNac IS DISTINCT FROM New.FechaNac 
        THEN OLD.FechaNac ELSE NULL END, -- Fecha de nacimiento anterior si cambia
        CASE WHEN OLD.FechaNac IS DISTINCT FROM New.FechaNac 
        THEN NEW.FechaNac ELSE NULL END,  -- Fecha de nacimiento nueva si cambia
        SESSION_USER -- Usuario que realiza la actualización.
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- Crear un trigger que permita registrar la auditoría.
CREATE TRIGGER trigger_auditoria_animales
AFTER UPDATE ON animals.ANIMALES
FOR EACH ROW
EXECUTE FUNCTION registrar_cambios_animales();
SELECT * FROM ANIMALES;
-- Ejemplos
UPDATE ANIMALES
SET Nombre = 'Nerón'
WHERE id = 1;

UPDATE animales
SET Nombre = 'Nagini',
FechaNac = '1980-03-18'
WHERE id = 1;

-- Validar tabla auditoria
SELECT * FROM AUDITORIA_ANIMALES;


-- 2. Calcular automáticamente el costo final en la tabla HABITAT_VISITANTES 
-- según el costo base del hábitat y el descuento del tipo de visitante.

-- Crear función para calcular costo final
CREATE OR REPLACE FUNCTION calcular_costo_final()
RETURNS TRIGGER AS $$
BEGIN
    NEW.CostoFinal := (
        SELECT h.CostoBase * (1 - (tv.Descuento / 100))
        FROM animals.HABITAT h, animals.TIPO_VISITANTES tv
        WHERE h.ID = NEW.IDHabitat AND tv.ID = (SELECT IDTipoVisitante FROM animals.VISITANTES WHERE ID = NEW.IDVisitantes)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear trigger
CREATE TRIGGER trigger_calculo_costo
BEFORE INSERT ON animals.HABITAT_VISITANTES
FOR EACH ROW
EXECUTE FUNCTION calcular_costo_final();

SELECT * FROM HABITAT_VISITANTES ORDER BY ID DESC;

INSERT INTO habitat_visitantes (idhabitat,idvisitantes,fechavisita) VALUES 
(4,251,'2024-11-26'),
(10,681,'2024-11-26'),
(14,285,'2024-11-26'),
(1,887,'2024-11-26'),
(2,664,'2024-11-26'),
(11,601,'2024-11-26'),
(8,647,'2024-11-26'),
(9,497,'2024-11-26'),
(3,630,'2024-11-26'),
(2,665,'2024-11-26'),
(12,577,'2024-11-26');
-- Ejemplo de habitat
SELECT * FROM HABITAT_VISITANTES WHERE FechaVisita = '2024-11-26';

