SET client_encoding = 'UTF8';

INSERT INTO animals.ESPECIE (Nombre, IDFamilia, IDEstadoConservacion) VALUES
-- Felidae
('León', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Felidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Tigre', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Felidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),
('Jaguar', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Felidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'NT')),
('Leopardo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Felidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Pantera', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Felidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Guepardo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Felidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),

-- Canidae
('Lobo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Canidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Coyote', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Canidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Zorro Rojo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Canidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Licaón', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Canidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),
('Perro Salvaje Africano', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Canidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),

-- Ursidae
('Oso Pardo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Ursidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Oso Polar', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Ursidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Oso Negro Americano', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Ursidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Panda Gigante', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Ursidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),
('Oso Perezoso', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Ursidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),

-- Cercopithecidae
('Babuino', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Cercopithecidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Macaco Rhesus', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Cercopithecidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Colobo Guereza', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Cercopithecidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Mandril', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Cercopithecidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Mono Gelada', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Cercopithecidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'NT')),

-- Hominidae
('Gorila de Montaña', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Hominidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'CR')),
('Chimpancé', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Hominidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),
('Orangután de Borneo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Hominidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'CR')),
('Ser Humano', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Hominidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Bonobo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Hominidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),

-- Elephantidae
('Elefante Africano', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Elephantidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Elefante Asiático', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Elephantidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),
('Elefante de Selva Africano', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Elephantidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),

-- Psittacidae
('Guacamayo Rojo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Psittacidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),
('Loro Amazónico', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Psittacidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Kea', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Psittacidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'NT')),
('Loro Gris Africano', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Psittacidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),
('Periquito Común', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Psittacidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),

-- Testudinidae
('Tortuga Gigante de Galápagos', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Testudinidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'CR')),
('Tortuga Sulcata', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Testudinidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Tortuga Gigante de Aldabra', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Testudinidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Tortuga de Gopher', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Testudinidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'NT')),
('Tortuga Estrellada de Madagascar', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Testudinidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),

-- Delphinidae
('Delfín', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Delphinidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Orca', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Delphinidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),

-- Balaenopteridae
('Ballena', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Balaenopteridae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'CR')),

-- Phocidae
('Foca', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Phocidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),

-- Insectos
('Hormiga Gigante', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Formicidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Escarabajo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Coleoptera'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Escarabajo Rinoceronte', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Coleoptera'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Abejorro', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Apidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'NT')),
('Mariposa Monarca', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Nymphalidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN')),
('Mariposa Azul', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Nymphalidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'NT')),
('Grillo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Gryllidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Luciérnaga', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Lampyridae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Avispa', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Vespidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),

-- Animales Nocturnos
('Murciélago Vampiro', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Vespertilionidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Lince Boreal', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Felidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),
('Lechuza', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Strigidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Zorro Volador', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Pteropodidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'VU')),

-- Crocodylidae
('Cocodrilo Marino', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Crocodylidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Cocodrilo del Nilo', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Crocodylidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Crocodylus niloticus', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Crocodylidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Crocodylus porosus', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Crocodylidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Aligátor Americano', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Crocodylidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Caimán de Anteojos', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Crocodylidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'LC')),
('Gavial', (SELECT ID FROM animals.FAMILIA WHERE NombreCientifico = 'Crocodylidae'), (SELECT ID FROM animals.ESTADO_CONSERVACION WHERE Codigo = 'EN'));
