SET client_encoding = 'UTF8';

INSERT INTO HABITAT (Nombre, IDUbicacion, IDClima) VALUES
-- Habitats tropicales
('Selva densa tropical', (SELECT ID FROM UBICACION WHERE Nombre = 'Zona Tropical'), (SELECT ID FROM CLIMA WHERE Nombre = 'Tropical')),
('Llanura africana', (SELECT ID FROM UBICACION WHERE Nombre = 'Sabana Africana'), (SELECT ID FROM CLIMA WHERE Nombre = 'Tropical')),
('Humedal tropical', (SELECT ID FROM UBICACION WHERE Nombre = 'Bosque Lluvioso'), (SELECT ID FROM CLIMA WHERE Nombre = 'Lluvioso')),

-- Habitats deserticos
('Desierto arenoso', (SELECT ID FROM UBICACION WHERE Nombre = 'Zona Desertica'), (SELECT ID FROM CLIMA WHERE Nombre = 'Desertico')),
('Cañón seco', (SELECT ID FROM UBICACION WHERE Nombre = 'Zona de Reptiles'), (SELECT ID FROM CLIMA WHERE Nombre = 'Arido')),

-- Habitats montañosos
('Pico nevado', (SELECT ID FROM UBICACION WHERE Nombre = 'Zona de Montaña'), (SELECT ID FROM CLIMA WHERE Nombre = 'Alpino')),
('Bosque templado alto', (SELECT ID FROM UBICACION WHERE Nombre = 'Zona de Montaña'), (SELECT ID FROM CLIMA WHERE Nombre = 'Templado')),

-- Habitats acuaticos
('Reef coralino', (SELECT ID FROM UBICACION WHERE Nombre = 'Acuario'), (SELECT ID FROM CLIMA WHERE Nombre = 'Marino')),
('Manglares costeros', (SELECT ID FROM UBICACION WHERE Nombre = 'Acuario'), (SELECT ID FROM CLIMA WHERE Nombre = 'Humedo')),

-- Aviarios
('Santuario de aves tropicales', (SELECT ID FROM UBICACION WHERE Nombre = 'Aviario'), (SELECT ID FROM CLIMA WHERE Nombre = 'Tropical')),
('Páramo de aves rapaces', (SELECT ID FROM UBICACION WHERE Nombre = 'Aviario'), (SELECT ID FROM CLIMA WHERE Nombre = 'Seco')),

-- Habitats de clima frio
('Tundra ártica', (SELECT ID FROM UBICACION WHERE Nombre = 'Habitat Artico'), (SELECT ID FROM CLIMA WHERE Nombre = 'Polar')),
('Bosque de coníferas', (SELECT ID FROM UBICACION WHERE Nombre = 'Zona de Montaña'), (SELECT ID FROM CLIMA WHERE Nombre = 'Polar')),

-- Otros Habitats especificos
('Vivero tropical', (SELECT ID FROM UBICACION WHERE Nombre = 'Jardin Botanico'), (SELECT ID FROM CLIMA WHERE Nombre = 'Humedo')),
('Estepa continental', (SELECT ID FROM UBICACION WHERE Nombre = 'Pradera'), (SELECT ID FROM CLIMA WHERE Nombre = 'Continental')),
('Refugio crepuscular', (SELECT ID FROM UBICACION WHERE Nombre = 'Habitat Nocturno'), (SELECT ID FROM CLIMA WHERE Nombre = 'Nuboso')),
('Costa rocosa', (SELECT ID FROM UBICACION WHERE Nombre = 'Playa Artificial'), (SELECT ID FROM CLIMA WHERE Nombre = 'Marino')),

-- Zonas de exhibicion y conservacion
('Exhibición de biomas', (SELECT ID FROM UBICACION WHERE Nombre = 'Area de Exhibicion'), (SELECT ID FROM CLIMA WHERE Nombre = 'Templado')),
('Reserva de fauna', (SELECT ID FROM UBICACION WHERE Nombre = 'Centro de Conservacion'), (SELECT ID FROM CLIMA WHERE Nombre = 'Templado')),

-- Areas especificas para grupos de animales
('Territorio felino', (SELECT ID FROM UBICACION WHERE Nombre = 'Recinto de Grandes Felinos'), (SELECT ID FROM CLIMA WHERE Nombre = 'Tropical')),
('Insectario tropical', (SELECT ID FROM UBICACION WHERE Nombre = 'Zona de Insectos'), (SELECT ID FROM CLIMA WHERE Nombre = 'Humedo')),
('Valle de aves', (SELECT ID FROM UBICACION WHERE Nombre = 'Zona de Aves'), (SELECT ID FROM CLIMA WHERE Nombre = 'Lluvioso')),
('Llanura de mamíferos', (SELECT ID FROM UBICACION WHERE Nombre = 'Zona de Mamiferos'), (SELECT ID FROM CLIMA WHERE Nombre = 'Continental'));
