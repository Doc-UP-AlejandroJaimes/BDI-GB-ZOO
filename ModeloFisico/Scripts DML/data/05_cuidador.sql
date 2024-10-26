SET client_encoding = 'UTF8';

INSERT INTO CUIDADOR (Nombre, FechaContratacion, IDEspecialidad) VALUES
('Juan Pérez', '2021-05-10', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Manejo de Grandes Felinos')),
('María López', '2019-03-15', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Cuidados de Reptiles')),
('Carlos Gómez', '2020-08-01', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Aves Exoticas')),
('Ana Rivas', '2022-02-18', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Mamiferos Marinos')),
('Pedro Sánchez', '2018-12-22', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Primates')),
('Laura Torres', '2023-06-11', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Animales de Clima Frio')),
('Miguel Díaz', '2020-09-03', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Animales en Peligro de Extincion')),
('Lucía Ortega', '2017-11-28', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Animales Nocturnos')),
('Roberto Castro', '2019-10-15', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Grandes Herbivoros')),
('Carmen Suárez', '2022-04-30', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Manejo de Veneno y Antidotos')),
('Elena Martínez', '2018-01-09', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Cuidados de Insectos')),
('Tomás Romero', '2021-07-23', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Animales del Desierto')),
('Daniela Méndez', '2023-03-05', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Acuario')),
('Javier Ruiz', '2022-09-14', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Animales Domesticos')),
('Sofía Morales', '2019-06-27', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Cria en Cautiverio')),
('Luis Fernández', '2020-10-12', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Manejo de Grandes Felinos')),
('Patricia Navarro', '2018-08-06', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Cuidados de Reptiles')),
('Francisco Herrera', '2021-05-30', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Aves Exoticas')),
('Clara Jiménez', '2019-12-20', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Mamiferos Marinos')),
('José García', '2023-01-15', (SELECT ID FROM ESPECIALIDAD WHERE Nombre = 'Primates'));
