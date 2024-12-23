PGDMP  8    	            
    |         	   zoologico    17.0    17.0 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    24582 	   zoologico    DATABASE     u   CREATE DATABASE zoologico WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es_CO.UTF-8';
    DROP DATABASE zoologico;
                     postgres    false            �           0    0    DATABASE zoologico    ACL     -   GRANT ALL ON DATABASE zoologico TO adminzoo;
                        postgres    false    5002                        2615    24737    animals    SCHEMA        CREATE SCHEMA animals;
    DROP SCHEMA animals;
                     adminzoo    false            �            1259    24742    animales    TABLE     �   CREATE TABLE animals.animales (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    fechanac date,
    idcuidador integer NOT NULL,
    idhabitat integer NOT NULL,
    idespecie integer NOT NULL
);
    DROP TABLE animals.animales;
       animals         heap r       adminzoo    false    6            �            1259    24738    animales_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.animales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE animals.animales_id_seq;
       animals               adminzoo    false    6    222            �           0    0    animales_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE animals.animales_id_seq OWNED BY animals.animales.id;
          animals               adminzoo    false    218            �            1259    24739    animales_idcuidador_seq    SEQUENCE     �   CREATE SEQUENCE animals.animales_idcuidador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE animals.animales_idcuidador_seq;
       animals               adminzoo    false    6    222            �           0    0    animales_idcuidador_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE animals.animales_idcuidador_seq OWNED BY animals.animales.idcuidador;
          animals               adminzoo    false    219            �            1259    24741    animales_idespecie_seq    SEQUENCE     �   CREATE SEQUENCE animals.animales_idespecie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE animals.animales_idespecie_seq;
       animals               adminzoo    false    6    222            �           0    0    animales_idespecie_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE animals.animales_idespecie_seq OWNED BY animals.animales.idespecie;
          animals               adminzoo    false    221            �            1259    24740    animales_idhabitat_seq    SEQUENCE     �   CREATE SEQUENCE animals.animales_idhabitat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE animals.animales_idhabitat_seq;
       animals               adminzoo    false    6    222            �           0    0    animales_idhabitat_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE animals.animales_idhabitat_seq OWNED BY animals.animales.idhabitat;
          animals               adminzoo    false    220            �            1259    24811    clima    TABLE     c   CREATE TABLE animals.clima (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);
    DROP TABLE animals.clima;
       animals         heap r       adminzoo    false    6            �            1259    24810    clima_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.clima_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE animals.clima_id_seq;
       animals               adminzoo    false    243    6            �           0    0    clima_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE animals.clima_id_seq OWNED BY animals.clima.id;
          animals               adminzoo    false    242            �            1259    24753    cuidador    TABLE     �   CREATE TABLE animals.cuidador (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    fechacontratacion date NOT NULL,
    idespecialidad integer NOT NULL,
    salario numeric(10,2)
);
    DROP TABLE animals.cuidador;
       animals         heap r       adminzoo    false    6            �            1259    24751    cuidador_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.cuidador_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE animals.cuidador_id_seq;
       animals               adminzoo    false    6    225            �           0    0    cuidador_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE animals.cuidador_id_seq OWNED BY animals.cuidador.id;
          animals               adminzoo    false    223            �            1259    24752    cuidador_idespecialidad_seq    SEQUENCE     �   CREATE SEQUENCE animals.cuidador_idespecialidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE animals.cuidador_idespecialidad_seq;
       animals               adminzoo    false    6    225            �           0    0    cuidador_idespecialidad_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE animals.cuidador_idespecialidad_seq OWNED BY animals.cuidador.idespecialidad;
          animals               adminzoo    false    224            �            1259    24761    especialidad    TABLE     j   CREATE TABLE animals.especialidad (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);
 !   DROP TABLE animals.especialidad;
       animals         heap r       adminzoo    false    6            �            1259    24760    especialidad_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.especialidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE animals.especialidad_id_seq;
       animals               adminzoo    false    227    6            �           0    0    especialidad_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE animals.especialidad_id_seq OWNED BY animals.especialidad.id;
          animals               adminzoo    false    226            �            1259    24770    especie    TABLE     �   CREATE TABLE animals.especie (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    idfamilia integer NOT NULL,
    idestadoconservacion integer NOT NULL
);
    DROP TABLE animals.especie;
       animals         heap r       adminzoo    false    6            �            1259    24767    especie_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.especie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE animals.especie_id_seq;
       animals               adminzoo    false    231    6            �           0    0    especie_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE animals.especie_id_seq OWNED BY animals.especie.id;
          animals               adminzoo    false    228            �            1259    24769     especie_idestadoconservacion_seq    SEQUENCE     �   CREATE SEQUENCE animals.especie_idestadoconservacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE animals.especie_idestadoconservacion_seq;
       animals               adminzoo    false    6    231            �           0    0     especie_idestadoconservacion_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE animals.especie_idestadoconservacion_seq OWNED BY animals.especie.idestadoconservacion;
          animals               adminzoo    false    230            �            1259    24768    especie_idfamilia_seq    SEQUENCE     �   CREATE SEQUENCE animals.especie_idfamilia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE animals.especie_idfamilia_seq;
       animals               adminzoo    false    231    6            �           0    0    especie_idfamilia_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE animals.especie_idfamilia_seq OWNED BY animals.especie.idfamilia;
          animals               adminzoo    false    229            �            1259    24786    estado_conservacion    TABLE     �   CREATE TABLE animals.estado_conservacion (
    id integer NOT NULL,
    codigo character varying(2) NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(50) NOT NULL
);
 (   DROP TABLE animals.estado_conservacion;
       animals         heap r       adminzoo    false    6            �            1259    24785    estado_conservacion_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.estado_conservacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE animals.estado_conservacion_id_seq;
       animals               adminzoo    false    235    6            �           0    0    estado_conservacion_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE animals.estado_conservacion_id_seq OWNED BY animals.estado_conservacion.id;
          animals               adminzoo    false    234            �            1259    24779    familia    TABLE     �   CREATE TABLE animals.familia (
    id integer NOT NULL,
    nombrecientifico character varying(50) NOT NULL,
    nombrecomun character varying(50) NOT NULL
);
    DROP TABLE animals.familia;
       animals         heap r       adminzoo    false    6            �            1259    24778    familia_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.familia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE animals.familia_id_seq;
       animals               adminzoo    false    6    233            �           0    0    familia_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE animals.familia_id_seq OWNED BY animals.familia.id;
          animals               adminzoo    false    232            �            1259    24795    habitat    TABLE     �   CREATE TABLE animals.habitat (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    idubicacion integer NOT NULL,
    idclima integer NOT NULL,
    costobase numeric(10,2) NOT NULL
);
    DROP TABLE animals.habitat;
       animals         heap r       adminzoo    false    6            �            1259    24792    habitat_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.habitat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE animals.habitat_id_seq;
       animals               adminzoo    false    239    6            �           0    0    habitat_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE animals.habitat_id_seq OWNED BY animals.habitat.id;
          animals               adminzoo    false    236            �            1259    24794    habitat_idclima_seq    SEQUENCE     �   CREATE SEQUENCE animals.habitat_idclima_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE animals.habitat_idclima_seq;
       animals               adminzoo    false    239    6            �           0    0    habitat_idclima_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE animals.habitat_idclima_seq OWNED BY animals.habitat.idclima;
          animals               adminzoo    false    238            �            1259    24793    habitat_idubicacion_seq    SEQUENCE     �   CREATE SEQUENCE animals.habitat_idubicacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE animals.habitat_idubicacion_seq;
       animals               adminzoo    false    6    239            �           0    0    habitat_idubicacion_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE animals.habitat_idubicacion_seq OWNED BY animals.habitat.idubicacion;
          animals               adminzoo    false    237            �            1259    24827    habitat_visitantes    TABLE     �   CREATE TABLE animals.habitat_visitantes (
    id integer NOT NULL,
    idhabitat integer NOT NULL,
    idvisitantes integer NOT NULL
);
 '   DROP TABLE animals.habitat_visitantes;
       animals         heap r       adminzoo    false    6            �            1259    24824    habitat_visitantes_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.habitat_visitantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE animals.habitat_visitantes_id_seq;
       animals               adminzoo    false    6    249            �           0    0    habitat_visitantes_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE animals.habitat_visitantes_id_seq OWNED BY animals.habitat_visitantes.id;
          animals               adminzoo    false    246            �            1259    24825     habitat_visitantes_idhabitat_seq    SEQUENCE     �   CREATE SEQUENCE animals.habitat_visitantes_idhabitat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE animals.habitat_visitantes_idhabitat_seq;
       animals               adminzoo    false    6    249            �           0    0     habitat_visitantes_idhabitat_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE animals.habitat_visitantes_idhabitat_seq OWNED BY animals.habitat_visitantes.idhabitat;
          animals               adminzoo    false    247            �            1259    24826 #   habitat_visitantes_idvisitantes_seq    SEQUENCE     �   CREATE SEQUENCE animals.habitat_visitantes_idvisitantes_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE animals.habitat_visitantes_idvisitantes_seq;
       animals               adminzoo    false    6    249            �           0    0 #   habitat_visitantes_idvisitantes_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE animals.habitat_visitantes_idvisitantes_seq OWNED BY animals.habitat_visitantes.idvisitantes;
          animals               adminzoo    false    248            �            1259    24887    tipo_visitantes    TABLE     
  CREATE TABLE animals.tipo_visitantes (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descuento numeric(5,2) NOT NULL,
    CONSTRAINT tipo_visitantes_descuento_check CHECK (((descuento >= (0)::numeric) AND (descuento <= (100)::numeric)))
);
 $   DROP TABLE animals.tipo_visitantes;
       animals         heap r       adminzoo    false    6            �            1259    24886    tipo_visitantes_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.tipo_visitantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE animals.tipo_visitantes_id_seq;
       animals               adminzoo    false    251    6            �           0    0    tipo_visitantes_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE animals.tipo_visitantes_id_seq OWNED BY animals.tipo_visitantes.id;
          animals               adminzoo    false    250            �            1259    24804 	   ubicacion    TABLE     g   CREATE TABLE animals.ubicacion (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);
    DROP TABLE animals.ubicacion;
       animals         heap r       adminzoo    false    6            �            1259    24803    ubicacion_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.ubicacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE animals.ubicacion_id_seq;
       animals               adminzoo    false    6    241            �           0    0    ubicacion_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE animals.ubicacion_id_seq OWNED BY animals.ubicacion.id;
          animals               adminzoo    false    240            �            1259    24818 
   visitantes    TABLE     ~   CREATE TABLE animals.visitantes (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    fechavisita date
);
    DROP TABLE animals.visitantes;
       animals         heap r       adminzoo    false    6            �            1259    24817    visitantes_id_seq    SEQUENCE     �   CREATE SEQUENCE animals.visitantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE animals.visitantes_id_seq;
       animals               adminzoo    false    6    245            �           0    0    visitantes_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE animals.visitantes_id_seq OWNED BY animals.visitantes.id;
          animals               adminzoo    false    244            �           2604    24745    animales id    DEFAULT     l   ALTER TABLE ONLY animals.animales ALTER COLUMN id SET DEFAULT nextval('animals.animales_id_seq'::regclass);
 ;   ALTER TABLE animals.animales ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    222    218    222            �           2604    24746    animales idcuidador    DEFAULT     |   ALTER TABLE ONLY animals.animales ALTER COLUMN idcuidador SET DEFAULT nextval('animals.animales_idcuidador_seq'::regclass);
 C   ALTER TABLE animals.animales ALTER COLUMN idcuidador DROP DEFAULT;
       animals               adminzoo    false    222    219    222            �           2604    24747    animales idhabitat    DEFAULT     z   ALTER TABLE ONLY animals.animales ALTER COLUMN idhabitat SET DEFAULT nextval('animals.animales_idhabitat_seq'::regclass);
 B   ALTER TABLE animals.animales ALTER COLUMN idhabitat DROP DEFAULT;
       animals               adminzoo    false    222    220    222            �           2604    24748    animales idespecie    DEFAULT     z   ALTER TABLE ONLY animals.animales ALTER COLUMN idespecie SET DEFAULT nextval('animals.animales_idespecie_seq'::regclass);
 B   ALTER TABLE animals.animales ALTER COLUMN idespecie DROP DEFAULT;
       animals               adminzoo    false    222    221    222            �           2604    24814    clima id    DEFAULT     f   ALTER TABLE ONLY animals.clima ALTER COLUMN id SET DEFAULT nextval('animals.clima_id_seq'::regclass);
 8   ALTER TABLE animals.clima ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    242    243    243            �           2604    24756    cuidador id    DEFAULT     l   ALTER TABLE ONLY animals.cuidador ALTER COLUMN id SET DEFAULT nextval('animals.cuidador_id_seq'::regclass);
 ;   ALTER TABLE animals.cuidador ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    223    225    225            �           2604    24757    cuidador idespecialidad    DEFAULT     �   ALTER TABLE ONLY animals.cuidador ALTER COLUMN idespecialidad SET DEFAULT nextval('animals.cuidador_idespecialidad_seq'::regclass);
 G   ALTER TABLE animals.cuidador ALTER COLUMN idespecialidad DROP DEFAULT;
       animals               adminzoo    false    225    224    225            �           2604    24764    especialidad id    DEFAULT     t   ALTER TABLE ONLY animals.especialidad ALTER COLUMN id SET DEFAULT nextval('animals.especialidad_id_seq'::regclass);
 ?   ALTER TABLE animals.especialidad ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    227    226    227            �           2604    24773 
   especie id    DEFAULT     j   ALTER TABLE ONLY animals.especie ALTER COLUMN id SET DEFAULT nextval('animals.especie_id_seq'::regclass);
 :   ALTER TABLE animals.especie ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    231    228    231            �           2604    24774    especie idfamilia    DEFAULT     x   ALTER TABLE ONLY animals.especie ALTER COLUMN idfamilia SET DEFAULT nextval('animals.especie_idfamilia_seq'::regclass);
 A   ALTER TABLE animals.especie ALTER COLUMN idfamilia DROP DEFAULT;
       animals               adminzoo    false    229    231    231            �           2604    24775    especie idestadoconservacion    DEFAULT     �   ALTER TABLE ONLY animals.especie ALTER COLUMN idestadoconservacion SET DEFAULT nextval('animals.especie_idestadoconservacion_seq'::regclass);
 L   ALTER TABLE animals.especie ALTER COLUMN idestadoconservacion DROP DEFAULT;
       animals               adminzoo    false    230    231    231            �           2604    24789    estado_conservacion id    DEFAULT     �   ALTER TABLE ONLY animals.estado_conservacion ALTER COLUMN id SET DEFAULT nextval('animals.estado_conservacion_id_seq'::regclass);
 F   ALTER TABLE animals.estado_conservacion ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    234    235    235            �           2604    24782 
   familia id    DEFAULT     j   ALTER TABLE ONLY animals.familia ALTER COLUMN id SET DEFAULT nextval('animals.familia_id_seq'::regclass);
 :   ALTER TABLE animals.familia ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    233    232    233            �           2604    24798 
   habitat id    DEFAULT     j   ALTER TABLE ONLY animals.habitat ALTER COLUMN id SET DEFAULT nextval('animals.habitat_id_seq'::regclass);
 :   ALTER TABLE animals.habitat ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    236    239    239            �           2604    24799    habitat idubicacion    DEFAULT     |   ALTER TABLE ONLY animals.habitat ALTER COLUMN idubicacion SET DEFAULT nextval('animals.habitat_idubicacion_seq'::regclass);
 C   ALTER TABLE animals.habitat ALTER COLUMN idubicacion DROP DEFAULT;
       animals               adminzoo    false    237    239    239            �           2604    24800    habitat idclima    DEFAULT     t   ALTER TABLE ONLY animals.habitat ALTER COLUMN idclima SET DEFAULT nextval('animals.habitat_idclima_seq'::regclass);
 ?   ALTER TABLE animals.habitat ALTER COLUMN idclima DROP DEFAULT;
       animals               adminzoo    false    238    239    239            �           2604    24830    habitat_visitantes id    DEFAULT     �   ALTER TABLE ONLY animals.habitat_visitantes ALTER COLUMN id SET DEFAULT nextval('animals.habitat_visitantes_id_seq'::regclass);
 E   ALTER TABLE animals.habitat_visitantes ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    246    249    249            �           2604    24831    habitat_visitantes idhabitat    DEFAULT     �   ALTER TABLE ONLY animals.habitat_visitantes ALTER COLUMN idhabitat SET DEFAULT nextval('animals.habitat_visitantes_idhabitat_seq'::regclass);
 L   ALTER TABLE animals.habitat_visitantes ALTER COLUMN idhabitat DROP DEFAULT;
       animals               adminzoo    false    249    247    249            �           2604    24832    habitat_visitantes idvisitantes    DEFAULT     �   ALTER TABLE ONLY animals.habitat_visitantes ALTER COLUMN idvisitantes SET DEFAULT nextval('animals.habitat_visitantes_idvisitantes_seq'::regclass);
 O   ALTER TABLE animals.habitat_visitantes ALTER COLUMN idvisitantes DROP DEFAULT;
       animals               adminzoo    false    248    249    249            �           2604    24890    tipo_visitantes id    DEFAULT     z   ALTER TABLE ONLY animals.tipo_visitantes ALTER COLUMN id SET DEFAULT nextval('animals.tipo_visitantes_id_seq'::regclass);
 B   ALTER TABLE animals.tipo_visitantes ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    251    250    251            �           2604    24807    ubicacion id    DEFAULT     n   ALTER TABLE ONLY animals.ubicacion ALTER COLUMN id SET DEFAULT nextval('animals.ubicacion_id_seq'::regclass);
 <   ALTER TABLE animals.ubicacion ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    241    240    241            �           2604    24821    visitantes id    DEFAULT     p   ALTER TABLE ONLY animals.visitantes ALTER COLUMN id SET DEFAULT nextval('animals.visitantes_id_seq'::regclass);
 =   ALTER TABLE animals.visitantes ALTER COLUMN id DROP DEFAULT;
       animals               adminzoo    false    244    245    245            g          0    24742    animales 
   TABLE DATA           [   COPY animals.animales (id, nombre, fechanac, idcuidador, idhabitat, idespecie) FROM stdin;
    animals               adminzoo    false    222   K�       |          0    24811    clima 
   TABLE DATA           ,   COPY animals.clima (id, nombre) FROM stdin;
    animals               adminzoo    false    243   "�       j          0    24753    cuidador 
   TABLE DATA           [   COPY animals.cuidador (id, nombre, fechacontratacion, idespecialidad, salario) FROM stdin;
    animals               adminzoo    false    225   ��       l          0    24761    especialidad 
   TABLE DATA           3   COPY animals.especialidad (id, nombre) FROM stdin;
    animals               adminzoo    false    227   ��       p          0    24770    especie 
   TABLE DATA           O   COPY animals.especie (id, nombre, idfamilia, idestadoconservacion) FROM stdin;
    animals               adminzoo    false    231   ��       t          0    24786    estado_conservacion 
   TABLE DATA           O   COPY animals.estado_conservacion (id, codigo, nombre, descripcion) FROM stdin;
    animals               adminzoo    false    235   ��       r          0    24779    familia 
   TABLE DATA           E   COPY animals.familia (id, nombrecientifico, nombrecomun) FROM stdin;
    animals               adminzoo    false    233   Ȱ       x          0    24795    habitat 
   TABLE DATA           O   COPY animals.habitat (id, nombre, idubicacion, idclima, costobase) FROM stdin;
    animals               adminzoo    false    239   8�       �          0    24827    habitat_visitantes 
   TABLE DATA           J   COPY animals.habitat_visitantes (id, idhabitat, idvisitantes) FROM stdin;
    animals               adminzoo    false    249   K�       �          0    24887    tipo_visitantes 
   TABLE DATA           A   COPY animals.tipo_visitantes (id, nombre, descuento) FROM stdin;
    animals               adminzoo    false    251   ��       z          0    24804 	   ubicacion 
   TABLE DATA           0   COPY animals.ubicacion (id, nombre) FROM stdin;
    animals               adminzoo    false    241   ��       ~          0    24818 
   visitantes 
   TABLE DATA           >   COPY animals.visitantes (id, nombre, fechavisita) FROM stdin;
    animals               adminzoo    false    245   �       �           0    0    animales_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('animals.animales_id_seq', 95, true);
          animals               adminzoo    false    218            �           0    0    animales_idcuidador_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('animals.animales_idcuidador_seq', 1, false);
          animals               adminzoo    false    219            �           0    0    animales_idespecie_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('animals.animales_idespecie_seq', 1, false);
          animals               adminzoo    false    221            �           0    0    animales_idhabitat_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('animals.animales_idhabitat_seq', 1, false);
          animals               adminzoo    false    220            �           0    0    clima_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('animals.clima_id_seq', 15, true);
          animals               adminzoo    false    242            �           0    0    cuidador_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('animals.cuidador_id_seq', 20, true);
          animals               adminzoo    false    223            �           0    0    cuidador_idespecialidad_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('animals.cuidador_idespecialidad_seq', 1, false);
          animals               adminzoo    false    224            �           0    0    especialidad_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('animals.especialidad_id_seq', 15, true);
          animals               adminzoo    false    226            �           0    0    especie_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('animals.especie_id_seq', 63, true);
          animals               adminzoo    false    228            �           0    0     especie_idestadoconservacion_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('animals.especie_idestadoconservacion_seq', 1, false);
          animals               adminzoo    false    230            �           0    0    especie_idfamilia_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('animals.especie_idfamilia_seq', 1, false);
          animals               adminzoo    false    229            �           0    0    estado_conservacion_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('animals.estado_conservacion_id_seq', 9, true);
          animals               adminzoo    false    234            �           0    0    familia_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('animals.familia_id_seq', 22, true);
          animals               adminzoo    false    232            �           0    0    habitat_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('animals.habitat_id_seq', 23, true);
          animals               adminzoo    false    236            �           0    0    habitat_idclima_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('animals.habitat_idclima_seq', 1, false);
          animals               adminzoo    false    238            �           0    0    habitat_idubicacion_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('animals.habitat_idubicacion_seq', 1, false);
          animals               adminzoo    false    237            �           0    0    habitat_visitantes_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('animals.habitat_visitantes_id_seq', 800, true);
          animals               adminzoo    false    246            �           0    0     habitat_visitantes_idhabitat_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('animals.habitat_visitantes_idhabitat_seq', 1, false);
          animals               adminzoo    false    247            �           0    0 #   habitat_visitantes_idvisitantes_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('animals.habitat_visitantes_idvisitantes_seq', 1, false);
          animals               adminzoo    false    248            �           0    0    tipo_visitantes_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('animals.tipo_visitantes_id_seq', 5, true);
          animals               adminzoo    false    250            �           0    0    ubicacion_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('animals.ubicacion_id_seq', 20, true);
          animals               adminzoo    false    240            �           0    0    visitantes_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('animals.visitantes_id_seq', 300, true);
          animals               adminzoo    false    244            �           2606    24750    animales animales_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY animals.animales
    ADD CONSTRAINT animales_pkey PRIMARY KEY (id);
 A   ALTER TABLE ONLY animals.animales DROP CONSTRAINT animales_pkey;
       animals                 adminzoo    false    222            �           2606    24816    clima clima_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY animals.clima
    ADD CONSTRAINT clima_pkey PRIMARY KEY (id);
 ;   ALTER TABLE ONLY animals.clima DROP CONSTRAINT clima_pkey;
       animals                 adminzoo    false    243            �           2606    24759    cuidador cuidador_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY animals.cuidador
    ADD CONSTRAINT cuidador_pkey PRIMARY KEY (id);
 A   ALTER TABLE ONLY animals.cuidador DROP CONSTRAINT cuidador_pkey;
       animals                 adminzoo    false    225            �           2606    24766    especialidad especialidad_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY animals.especialidad
    ADD CONSTRAINT especialidad_pkey PRIMARY KEY (id);
 I   ALTER TABLE ONLY animals.especialidad DROP CONSTRAINT especialidad_pkey;
       animals                 adminzoo    false    227            �           2606    24777    especie especie_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY animals.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY animals.especie DROP CONSTRAINT especie_pkey;
       animals                 adminzoo    false    231            �           2606    24791 ,   estado_conservacion estado_conservacion_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY animals.estado_conservacion
    ADD CONSTRAINT estado_conservacion_pkey PRIMARY KEY (id);
 W   ALTER TABLE ONLY animals.estado_conservacion DROP CONSTRAINT estado_conservacion_pkey;
       animals                 adminzoo    false    235            �           2606    24784    familia familia_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY animals.familia
    ADD CONSTRAINT familia_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY animals.familia DROP CONSTRAINT familia_pkey;
       animals                 adminzoo    false    233            �           2606    24802    habitat habitat_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY animals.habitat
    ADD CONSTRAINT habitat_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY animals.habitat DROP CONSTRAINT habitat_pkey;
       animals                 adminzoo    false    239            �           2606    24834 *   habitat_visitantes habitat_visitantes_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY animals.habitat_visitantes
    ADD CONSTRAINT habitat_visitantes_pkey PRIMARY KEY (id);
 U   ALTER TABLE ONLY animals.habitat_visitantes DROP CONSTRAINT habitat_visitantes_pkey;
       animals                 adminzoo    false    249            �           2606    24893 $   tipo_visitantes tipo_visitantes_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY animals.tipo_visitantes
    ADD CONSTRAINT tipo_visitantes_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY animals.tipo_visitantes DROP CONSTRAINT tipo_visitantes_pkey;
       animals                 adminzoo    false    251            �           2606    24809    ubicacion ubicacion_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY animals.ubicacion
    ADD CONSTRAINT ubicacion_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY animals.ubicacion DROP CONSTRAINT ubicacion_pkey;
       animals                 adminzoo    false    241            �           2606    24823    visitantes visitantes_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY animals.visitantes
    ADD CONSTRAINT visitantes_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY animals.visitantes DROP CONSTRAINT visitantes_pkey;
       animals                 adminzoo    false    245            �           2606    24835 !   animales animales_idcuidador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY animals.animales
    ADD CONSTRAINT animales_idcuidador_fkey FOREIGN KEY (idcuidador) REFERENCES animals.cuidador(id);
 L   ALTER TABLE ONLY animals.animales DROP CONSTRAINT animales_idcuidador_fkey;
       animals               adminzoo    false    222    4787    225            �           2606    24845     animales animales_idespecie_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY animals.animales
    ADD CONSTRAINT animales_idespecie_fkey FOREIGN KEY (idespecie) REFERENCES animals.especie(id);
 K   ALTER TABLE ONLY animals.animales DROP CONSTRAINT animales_idespecie_fkey;
       animals               adminzoo    false    4791    222    231            �           2606    24840     animales animales_idhabitat_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY animals.animales
    ADD CONSTRAINT animales_idhabitat_fkey FOREIGN KEY (idhabitat) REFERENCES animals.habitat(id);
 K   ALTER TABLE ONLY animals.animales DROP CONSTRAINT animales_idhabitat_fkey;
       animals               adminzoo    false    222    239    4797            �           2606    24850 %   cuidador cuidador_idespecialidad_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY animals.cuidador
    ADD CONSTRAINT cuidador_idespecialidad_fkey FOREIGN KEY (idespecialidad) REFERENCES animals.especialidad(id);
 P   ALTER TABLE ONLY animals.cuidador DROP CONSTRAINT cuidador_idespecialidad_fkey;
       animals               adminzoo    false    4789    227    225            �           2606    24860 )   especie especie_idestadoconservacion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY animals.especie
    ADD CONSTRAINT especie_idestadoconservacion_fkey FOREIGN KEY (idestadoconservacion) REFERENCES animals.estado_conservacion(id);
 T   ALTER TABLE ONLY animals.especie DROP CONSTRAINT especie_idestadoconservacion_fkey;
       animals               adminzoo    false    4795    235    231            �           2606    24855    especie especie_idfamilia_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY animals.especie
    ADD CONSTRAINT especie_idfamilia_fkey FOREIGN KEY (idfamilia) REFERENCES animals.familia(id);
 I   ALTER TABLE ONLY animals.especie DROP CONSTRAINT especie_idfamilia_fkey;
       animals               adminzoo    false    231    4793    233            �           2606    24870    habitat habitat_idclima_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY animals.habitat
    ADD CONSTRAINT habitat_idclima_fkey FOREIGN KEY (idclima) REFERENCES animals.clima(id);
 G   ALTER TABLE ONLY animals.habitat DROP CONSTRAINT habitat_idclima_fkey;
       animals               adminzoo    false    239    4801    243            �           2606    24865     habitat habitat_idubicacion_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY animals.habitat
    ADD CONSTRAINT habitat_idubicacion_fkey FOREIGN KEY (idubicacion) REFERENCES animals.ubicacion(id);
 K   ALTER TABLE ONLY animals.habitat DROP CONSTRAINT habitat_idubicacion_fkey;
       animals               adminzoo    false    241    239    4799            �           2606    24875 4   habitat_visitantes habitat_visitantes_idhabitat_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY animals.habitat_visitantes
    ADD CONSTRAINT habitat_visitantes_idhabitat_fkey FOREIGN KEY (idhabitat) REFERENCES animals.habitat(id);
 _   ALTER TABLE ONLY animals.habitat_visitantes DROP CONSTRAINT habitat_visitantes_idhabitat_fkey;
       animals               adminzoo    false    4797    239    249            �           2606    24880 7   habitat_visitantes habitat_visitantes_idvisitantes_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY animals.habitat_visitantes
    ADD CONSTRAINT habitat_visitantes_idvisitantes_fkey FOREIGN KEY (idvisitantes) REFERENCES animals.visitantes(id);
 b   ALTER TABLE ONLY animals.habitat_visitantes DROP CONSTRAINT habitat_visitantes_idvisitantes_fkey;
       animals               adminzoo    false    4803    249    245            g   �  x�}V�r�F<c�"?�Լ9s���S�#��U�l�2���D4風ݲ�>�<H咓- ��C�a��K�p���I؄�C�B�L#d�S�p>Έ��QD��UL�]���)
 ���6�݉������=�f)_��Y�a?�J��rp���|�&�,fk�ZXx��0���)
Y��8>��%�3dt�����!�hq �}8J=̊]+��߫���ވ�\�4���mG�T��H��S��t�#�9L1a�m�Pƥh\��k�&C��i(c�������w�$n��RN0̾9t}�Q�a�֓��)�e,��ni��4�0�4Q�QsP�S9^$D*��d���.�%�ܕ@������o�@�Ĥ�lc�����0Τ��8�O��!��Z��kl]�KZr�d����4k�&��r��9��Zi�5�?��:Ӗ����)w�1qթ�NZb���n��]Q��5���dJ�u�N��7�<�Z�4�~~{�c�K$�4p5f,�q�e����V�u�M������&JQqx��©��J��i�<��>,C6P�h���-�2Vi�����q�O�QI7���ӎi�J��,�i�@	�L�r��<'�P�����a�(d/�j�\Oq{�梐���kQ]^t��H6L���\�/��e�n낔K�Qϴ��~�Q4���媂�U[�$��/&����q��c$�kñ�ō�`�2F��~�"Q��4��k��%2�Y�w°�s��f,�N��3��I'�ִ�O}����s��},*�%}2��I��f�i9�5��"h!��V��t��%��2S-���k�V�����a^4�iQ
�bV��9�kʊ��fŇ�vi�ٚ�E��>~_<��ےQ죅��JQj��%3>Y3�}%����˸e�_r./�Z�������­��q;�j��IB.�Jx�^�}��Z�U��"R�^jxð�;�@��e��_�AUkG�Xk�'o,���s�����Z^���>&q�����-i4*9Bt�ϧcޘO��k��g�ױjV���k�Jt�P�uږ��=s��0����V�Ĩ���V�`/�7����U��m����v�	Q䂛@H2��ힺ��aXFz��<�u�),_!�'e6�s���Ut�����n��§0!�y��R+�[,��B��ve���&�2��Z꣟. ���e��}���>�xz/��b����3c�_�.�      |   �   x�5�?�@���0���Hdpc���-)w~z�g�����t��,���,�XBO���x��&�d�+xj��G��D��oOХ!�KghU>*[��qθ=��L�<ҠkV����s	�����dUP�e�k��_�4%      j   �  x�U�MnAF��)�muU��2±#	/��@�i��z�K^�s�T�i0�ҧ��=����Z����Bmr�(7��`̄`�a|c5���sXkc5�@`M�Y�rh}�����e�Ѧ���)����ժ9p3�i� �R&���������<Zi$M9XJ��<V/>w�g�)4"@E���h^תG9�Z�J�:�*��xꏰw�_-e��
*��r5��/�^M��a�&2����e�:���e�8�V(��-��uBFh�Ƿ�z��Rj�O� ��ߍ�^��Νߏݕ�,�R��#w�ke�x궗l��䀱�<e3��qA��溩���|w��ȵ�1-|���=*Qh*!ZQ�FJ?Cӫ':�r{�"���Y}����}h6��|�p�Z�*�j7���S�n����9�>p�W���i��Ȭ�	���Q&#�YJ+����Ǔz�5�@����^����?k4�,      l   �   x�U��N�@����'@li�9Fi�*��,Y%6�n���x#���e3�	���'�9a�{�%�ʵ#��$��+~�1Ík&�vg)��k��j�!�,ݸ���ᷮaMY]��f�W�[��hO?uα;⎄�~A^�+�V���	��&���/��!#���JR�=�+���y�����-fB-�jvc�A�za�2`��U�q�R���8����W ��qv      p   �  x�mT;n�@����	�/����HlǈA����Xr�%i���K)�tiy��!IR�3o��f�Tï�J���t��c/��\�� �^#۰+�h��םr<J)m{u3��;K!eޒ6��vjV��:g�/�qB�]�%y��A@7Jn�<���pm'4�ϭ�o�4�Ѥ�5��xT\�1֕��#�4\��ե%"�S �ԋm�������oIW�s������I�BW-�h�-F��i]8m&1�+[�D.�"��8���v<�dJ(�6{]5\��4���u�w�k-�g���N�	�*�_������0�3$���7�s����S�iy�zx�t.\VG�n�o���1����f ���/X���PO�'��M�(�,�N�ǈ�o,���{�Yc��w=9'tg]ח�mII[6�kåmi�D���79w5����6��l�<XHT���BW��2��qS����,v�/�2�\�� ��yB��UCPf�+�08��ºJ��@�'t.�y�k ����t̕����+�h�S�rMj�<��N7�ea��b��X��F���`� ���
�l�����jtJ�l!	i����RĈ�z'6;��j4�����8�:9��LD�#��8\l����q��u�c�U�Kʭ���NPc,hy�/���3!�='г�[���]
�.N��k�"��.Ax�N^�
iú��l��۳WD[~��h�I~{�y��{      t   *  x�m�MN1���)r ��?,K;�j�
l��-�2�(Ɍ�^�#p1���Y�s��~�%P�C����-���ݡbi�)�����Y

e\�M�{�<�׃,"��SvY��b�`<�*ؖ<��X9��a��9R#vI�����+�k��#��)���s�W�w>Pą'����C֢mhɨ�Z�{1�P��[l(�^��Q�L�՞�؅�׊����"��Z<��a�����-��d̒��b}��)A-�w��Jbs\��ӵy��*���]16Rj&�N�u5��?T�IH��.�qn��a䥛      r   `  x�-PKN$1];�� ��/��#$`#6��t���I��s�Yp
.���"��l?�����Tc��V��P�9�M�ѐsX�9O4��Vl��w{���%��.�Afnl��H�K<�Q\�8aȵj�w�)�+xL�36ލ�5_�3���G�gѼ�0u�T�`���Ze���ԬK��m�?����t����3���葂D��%�{
��<N�����3�:s�Jj�]o>��J�p�T|Ï��ncm�}3;���/��a6���-*GI��
68�C;b�L�.��?��D{N�`7f��������im$��Y�������+=<e�][Aô�3��	��%�X��^<�R\}=q�}4ٻ�      x     x�M�Mn�@��է�	Z�c�ϖ	$�"eŦ�iKv�жG\��@a.Ƴ!yc�_U��Ui�OӅ�S�7k-����9c�TA�0q�*7<T<g&�w�K�9�xz-�ik;%;'Zz��1յ4\S.K!�O��z���膯?��r�����H1(+���ƾ49]�TȒ�`˅(u+<�)��-5k�����]dɣ��Q�������4�B�n)Z�XJD���y���eM�,�B����`��9�ױ Q�h_R���S��Ȩ��tw�^y~�V>s�G�{��� ��-����vW�x(-���}���?�TyA.���Z��@��x�������Aa� �[�:��cs��.� �M���@h؞���-� f�/����7 �M- �����p�	t����4��Cx~��0�ԡS^Z4���z[3��3�(Z�:��0�R��Zv�C:V�2M]��0��g�z,�5�;��6:�2��Ӕ^�p�!����
c��33�_�>�L�Q�;�,��Յ�p      �   -  x�E��q�6���b2<���_G�[�wƞ1͛8�?����������k����m�����O>#���Q����պ������gͷ�G?��]��W�jK��j����՞�L[Cɉck��~N{�F;�w�G�s�:H���w���C[�W��;�6��~�6�j�o��Â�YWWMOnO�s��3��w�흺���\j�ޓ{w=sj�Эޙ�gi�����΋hzo�j\��w�Go�x���wYԳ�K׻���w�wW��]�Ph��%�͟}��4G�߾�Х�@��ݓ�y�ma��m�滃���Iii�6b_Ľ�E)�D{,��F�R�zcx����JQ��h��t��~�(�K��,�RV����}t�{�l޶�7;�҅�"�����B=޽����>l����Ѵ�ud��&/R���=�>��}�-s��z��ْƱ�����xV�ߴ2uף�������|o�khtt�����P]@#�����N�7x���MKW׼�k5�oȉ��I�zk<�EˢS��$,��b'����fr��jY�,�\S+zI_���19	�w�gi�����Î��T;��^L��2��tx����������8�(es��]��[��u��a�5�S����my�����;t踞�4�G�ʅ镁�Y���ō�_n���˓Y4$K|��a���&��q(��BCᗱIȥ�p�˧q���S���֮���<��!|[��X^_q�nV&�K;:s��ɚ�.��;�.�m���!��ћ� B�����~����+A��N��?w׼����Z�6�:��QWb�.i����a��r�S����J�8��r|���\��йm�B��������{�ٌqL�Ö�h����q0��; �H� x���V��PG�9a���UGg�r#6P���f����\HjZ�w=��9�E9�Zz$wm�8� /���֡�����'L@�����Pt��i�I1�C�^#p�� ��R:���Q������u��� (��#��a��4�OV��9v�d�g�:g�
V�0Jb�^�b�k���<�K�CU8��I�BD�'8��,p8g牋�\�$�QղN�vP�ꘆ���lXgL�ٕ�&$\a���IP��H���Xc�}-�E�ՋJ�l�B��Ew�Y `2�n���
�����A�o�~����ז�'�����k��%��f�Wnxчh�r%sY���e��.����k�K�w�29mV>�I���܊�^Qx�����!��I�DjG���x}F�Ag�NH���(�.3��
����hŊ�m
��wu�^�\�����(�|э��7
p$LzQ�|#e��:���ƞDy�_��+��3;�a"���6=(#�Τwm��cD,(��� 0?�4+�5����r����6�!�e�b$���.3�p��� 5�)}�߄ߡ�$s�ȭ����6,��b��i���C'�e�8��	�0ǝ�É�H�]�,�^<���8��)����S-D�
d@3�wА���q�9+l��&t�ӢY�3`��*M+8��3/Mc���D������"�X��c�b}'in1|�
��\�ǲ��MD�Y<?�;u%:��R0 mV�)B=��[���
�,�cLss�bb������D�����g�D�1ftj��QRў��3�ظ_��b��H!2�"�7ll(�8 ���P�W	�� `��i���*Zό���̬��V�sG�-��� �锏�#�3~�gn���c[�l �ʱ��la�qBxЊh���f�g�[���I���)Ľ)�=�h�D����a��R8`�0�U#}���G��܎��R�1��AN�-� 9�2�f��`�f~I�j����[��nj+�.cv��Nx��g��J�3}РE��V�g@�W/��ɦ�r�}ר����%���D��9�BZ�s�b��I�ᓔ�	 ǌ��Q�g)GeM�Z��DJ�� ;܂�[��@>-�Ύ�y�e���Y�t��$d�:Ff�V���Z&�ꚅ`�]e/̅@ת��ʊ�4�7(m9���`�3�s栯�	.��Qu���J��"��9�E�r(�n��Q,M���W�ScT�c��A���<8�Ѐڅl/�Բ�k#:�������V�b��T �����-� v�3�f�Z��QTH����ޕk\�l�W1�Y+�-� �X_2@��+x���;�U��!�b�瘋�����,SN*�#��[0���V�Xº�i����k�ͯ)�b�x�H�" ��w�F��n����\}�̪tc�iS�.���h��!��P��nN�(#���n�I��M��������f�"�j��(lmg$t۶�,FO�W��(@l.��V�ԧ@<�${�v������u4$�=�և���Tm@��%;{9}~7(���R�gU�h9�*�����ک(ʰ�S��=3��UdpP{���w�b���� 
ZE�8p�D��E9�Ώ�n� �?{W�A}��M�)r�]Q+�N�yX���o�������,Gd��vUnRw@7�i;zE0-	��箂 �xG僘JT�	Q�a�?݄'p�Q�FY2��Z��J�;�9�⃺F��в_�Oe�;�w@v��`-�F�k�f��U���#���Q�3���R�b^QN�wlc4�֢�*l�]��Ky>�q<@��oA���63l���fUP0� �L���ubK����.�h�Fb���Y�	�$�U�s�~��NƷI�P+ʯ�����CF�v��* 7$�������^��UUHaJ�i�v�_	X[W�$�7�B`<UGƕ\�a��b��M�IZҢ�!D ����'8!�Z��6�0���ÄC�U�g��I����pV�IH�X�|W��YЙL��Y2�Up��0���r|����7�UvN��UFә�� ˊ_�.V~��X6 +V��������]�=tb:y;Y��vI�؅��^�hE�pE���K�cۢe|_�V>\pC��'�x���%�z�P&�����?��3h�-�}�Sdj$��2�P5�hv-�I���+:&�Ϡ�LSTf֗ �Td�!S�*�MKC;�ԡ��A ŝ�3����V1h�v
�Y���>Ǟr+������m�V��F���_D*��tV��w� ~��ؙ鲀�![���T8Sg},���5�Jc�`���?��Yg0|�mtJw�I�E���W.}Ed,�]��&ݟ�ؤ @GT.����6��U��bR3Yp ��o�\z��Z�c�����s�)r{�T�.��5��sV���Oj��QGM)%'��gѿ�Ǩ��3�\p�Y�Y>���̛�����3��\@��d.�?�0��'�P�W\�l�� �]*G�:뫡�U��r���䶅q��}�L��ݥ��@/�.q��O�I_9��:����g4��" TU�+pǠ��Ψx�s�"��I��"��+�Ek=�г����M �,X��r�{s�Ú]<<�e4�-�����1k��Ȫ�C���%�pI������>��)�D.�5z������_1��l����s��:ذ
��<�)�� Ny���j������}&T�\e����}�����      �   f   x�-�1� �Ṝ�'0�z G���$J������������*��Z�a��YP�\��R�����4�3���nn8�.�h"��c	tS������1��      z   �   x�E�Kn� @��)8A��I�$���������=VG"L
�j��3�bŶ����Fţ~r�
���"��	�GP�~���a�l�X`�l���iہΉEX�7,1Cۄl�k���Ւ~vm�6;��� �L�@����+ƨ���;��q��$�������) ��z��&m����D^�Jm�]���J}�J=a���$��ѵ�;��A���]f�T�OC�}@_S�w��gI1��9>�����
 ��z      ~      x�M�[��8҆��Wp7W�a0�p�:���\�����Ƞ�5��Z�~��fJ��蘙!���'�N�ۨ/�����N�ze�4=�egYgѽ���ˮ�ɵ�JSKZ����tϣW�odr��x����3<�.�<z�R�]r!t�QX̲�YI����~+#���l-Vf�dE\D�q��"Ym�8(�rvF�x�Zc��C�3;ᚎ��g3�)�2���<�z'�Il��,����a����f#�6fAۦ��^��PF&��Ro�p�)�4���!YKqn/�[f�8͢����ɽ�l�i�=9[��<���}���PR7�H9���w�`to�l����"Z5��I�K�5�x-��"�ji�kC9�3�ל��2zR�`�\j-�ޗ)�2-�㼈���^?cO�U��Ni�)����U�Ǚ�+q�l=���Dr�cw����i��ъ_�憮=�@x2�΅���9HѰ�l�Y�ͧէ��	9y��Q ��Ȱ�8x�2�(z��.��W�̊�BKk`7}�n:&L�-����{���]��9z�KgT-�W��J�FQ��U�c���� g�.�2'��g�,P&w_�H���泳���i���>կ�z�Z�;΃x���(K�SϑU9��[񹵶	O���<zp��'`�N��)j�x��֝0�5�9�k��O�||gA��<*�q��x����A���F%7�3�@�ٌ�2�v�������V4�B��q�*z�_	~V���?�,�X>��!�Pv���n����y�����A�>���p���<n�'뜒�t���YcX���%Q�9�8'���Ʃt��$,��8�Pj�0&y��;LR���^8M���A�Υ|ݵb=ھ��yN�_q^F7J7P7I�_I1�g��u�kh�t�kd��E+�D��vtϜ<�H�s�ʐ�+�)qW�y
�"^@��Vm+�n�R�x�N�$
/$9;K9b^tN}�ǍS�v��߸�hq*�F�}��-�E!v�<�"2�T(^,J#z����e��$�\����H9_O�4U��L�8�M�ڍu���,��@BT'7b�N�2T�ыD^\�r�
��`	j �;/���,.�8�u[�>�^6G��T4h�<z�f5�ȓ�Uq��.�Jɳ���>�I���������.��2.�ѕF��Pu]��S��9��(qu�D�\���F�R �EE�����x����x9�.�k�lr��jY�2�}D�2���������IN
:�2��{�⓬�������b�^�DJ�r��������l E����s����"z�`BP��z-JYĳxYP9�84�6,W$�KT2�A�ȶS^̹&#Ȗeto��{D9���\Q$@���Q���� �׳��d�p�O��=B�f�+S�!r�-^��T���ҧ���aw��+P��-�r��c�~�7�?lλK��d3����,�p.я��' {��걘� �$.f�P������Y�T��nH.�Q�X*a�V���q��t�0e���d��F=�$��+*ep�Iޭ���9�*Eu E" �lP���ʢ7{����!��S�e�#՜R�|���>F���Vh���׫T�ZD�����}T{��+�Z����^�H)�k�2�֠D�(L�|�"Ļ��.h�g=��8�ŜX���Ky@���Q*g3h�nze�K�z"�[5Y)���r
6G �Ԏڃo:V�t����h۔���`7�Gk��5��3��Z�|�l�y�\l�`QT0'�r?ڰ�\Hg=�l�%/}Ө�lr���%������S� �����A�S�9N3Z��X�N~�J�4���R ��uLhO��Iq�iJr��^5ͩ�`�K���N~�(xCud*N��PH�d�=�BJ짂E�R�k��CoD�Ò����x/41��D�t��� -���� ������k7A�sf[�B���c	���Q���ݓ6��%	~�q����Ԛ��	�B'���ζ(�d���IT��Ȱ�܈��/A:�K1w� ��N9�<���� �ap�3<#�Kgw\JJU�����J����*�N1�Vk�	1�M�h�z��E��Z��l�F�k8�)�6���?����M"D�ۆP�|�D"��]7�F k�]���'���)(� ��Pʸ@��P����ˢ��j��1��,){�tP��>
g���c�e�h�x��nwz�w�ۀ�+��5�NXױ6����MM�ߥCeRcY��K4Z��Nh��8��B=��  ���>u�0���!y�M�����RV-D����*N�5��{��Z�	I9�^Mp�E���d��# ���:�OdΨ�����������.�z3��~�y�X���+T-�����ľ�"�� !�X �&�9	yrD�I���c��h� �D	���a
�Z��`������;ZEߍ��y��=C6����Rڄ����Z���}�DB&����؅z���x���Hم�%�ۂ��d��^Ny;�/������g�Q����� � ���n�s�Wٲ"��é�HA���@�&�����n(g�DX{��T��gߴ�/
�y{!5�2�hۃ�&P�ƜZ
4�-��V�j���Q��Gרf�g���L6)��DWC�߄2a�d�!��=��}����@�h��_��޹�)q�F2Nt�Β��(��S֓�
*��?�MH�t|�Nwc�M@߅�Y �
*����A=3S��tl����̶M�e��On����.����<Gi��]ȱZ|�5<�GC��op��.ؤ`� ��r#����;��
���~o�sw�;_���^�ПԖ�kЅ�t�����[��E��xl�tb�3%	�Rpk $Ñ�����w�o U9L}�8�GC�~8�b��_��B���3x�}-�u�/�c>>��rP:վP��+�d��oEC3����]
���]F謉��GK��7�M$ݤ$���&o�(����݇Ŋ�@"s)8�Cх6�WFl���Bw��<@�\��Kc����:���@u�n����������`�a��DP����ں�1T�aoP����ni��!�9�"��	5���OHOA�h�������,�fqF6���WrL2,��f��J:���yl����@�Ļl���������)�ۭ4��e��2��5����~�F�^�x�8 R��}�MM?�%A�`����4ѝ�d��;l��(���=��h@	T_�4�}��l<�����4�I��[�u�5E7D$��m��b����Gyz�n�r�Q�qO�F� v�4�mB�uNa^�)����xz�w��1W\�� %1Bl�����Նv�GiH��~#�+��zo�����5��rh� �?���;�z��%����;B�)�ɥ��kt/<��!?g!3��߂K����kD�FP���9?��� �:}#�4V�sk��+n!Ԃ�tq��e�*7:	��ZRp���(�(#4U�ڞ�� ���z�\㔆��!j�hX�&�S�QOć#Y^w����i������]�j�nƢj�Z��S�&ۀ�o����8����\���5͑���:z�P�.��K#M���vDʀ����5}kaȀ�4����0���G&����QHМ_����N���
�~%��Kь�J6����4��i�	��2�[z��J^�r�O��fs�oD��ԝ�Mv�������pA�g\}2�;�h��|�H���ɠ��+��� W�:�r�M�AJ2y��������y�=�$�k�����`�B`�:�N짰��Lt�_���"��}��9�N#Ke��K�����4����`dG���g �"�y�S|m��DOˀ�YN*�k��y$�n_Cz��D���K��<��jp[x�F�GU�3{����ow�F���� �gw.��nd_�nG�~�l$*"��HA�Z���Ə1=����F��ˣ����%}钇���yb�7F��UH�,���Qt�co�������w��e�x8
5�<�ijk^i�S�.�G�� ^  �L�H�y<u뾺���g��"�O�l��x�b��q���f��>%��y�C3�h���ߜ�L~�u-ݶo�X��+hJ���'{A��(�.�q��0�3�K��qK(5�d>8d@�s����]XZ�'�Ӈ�D���e �@�o�d�ʺ�c��b��9{i�t��	��8X�^y�PgI�y8��8~%ρů^@H)�����h�ZH��*YS��o.TV������(���/0�����c��9��!X�B'M��2��J�ѧ�q�γ:>������:��9g{I�)�[�� ��G�2E�4g���F�~�0�� �k��Zꉠ#JJC�h��*�W(�� �Y|~�WZ�����Y駠�Cn����7@�.��/Vu�8���"��� �V]'j��T'����%P��K��[r�	C� +���Sr�� u�N��H.� >�?Y�'��]�B]�Ut�Р�4]�/�q�>å��h�n��>��r�����a�j�yO�#ZC��xĊ	d�O٨�Oo]P����?��?nQ���Q�?���=O4�4Ȕ<V�P܄>��t���l̪9��J����#����8���+w     