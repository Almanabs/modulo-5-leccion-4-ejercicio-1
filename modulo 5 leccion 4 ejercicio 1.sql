-- 1. crear tablas
CREATE TABLE facturas(
	id serial primary key,
	rut_comprador varchar(15),
	rut_vendedor varchar(15)
);

-- RUT VENDEDOR 1: 1.111.111-1
-- RUT VENDEDOR 2: 2.222.222-2

create table detalle_facturas(
	id serial primary key,
	id_producto int not null,
	id_factura int not null,
	FOREIGN KEY(id_producto) REFERENCES productos(id),
	FOREIGN KEY(id_factura) REFERENCES facturas(id)
);

CREATE TABLE productos(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	descripcion VARCHAR(255)
)

create table existencias(
	id serial primary key,
	id_producto int not null UNIQUE,
	cantidad int not null default 0,
	precio int not null default 0 check(precio >=0),
	pesoKg int,
	FOREIGN KEY(id_producto) REFERENCES productos(id)
);

-- 2. INSERTAR 10 PRODUCTOS

INSERT INTO productos(nombre, descripcion) VALUES('Televisor 58 pulgadas Samasung', 'Televisor 4k');
INSERT INTO productos(nombre, descripcion) VALUES('Lavadora LG 12 kilos', 'Lavadora de carga frontal');
INSERT INTO productos(nombre, descripcion) VALUES('Sofá Cama CIC', 'Sofá de 3 cuerpos con apoya brazos');
INSERT INTO productos(nombre, descripcion) VALUES ('Rasuradora Philps', 'máquina de pelo');
INSERT INTO productos(nombre , descripcion) VALUES ('Celular Xiaomi redmi note 8 pro','6gb ram 128gb de alamacenamiento');
INSERT INTO productos(nombre, descripcion) VALUES('ventilador', 'aspa de aluminio');
INSERT INTO productos(nombre, descripcion) VALUES ('Bata', 'Bata de baño');
insert into productos(nombre, descripcion) values('notebook acer','17 pulgadas');
insert into productos(nombre, descripcion) values ('Refrigerador LG', 'Refrigerador con dispensador de agua');
INSERT INTO productos(nombre, descripcion) VALUES('nevera', 'sin escarcha de dos puertas');

select * from productos;

-- 3. INSERT EXISTENCIA PARA LOS 10 PRODUCTOS
INSERT INTO existencias(id_producto, cantidad, precio, pesoKg) VALUES(1, 5, 350000, 5);
INSERT INTO existencias(id_producto, cantidad, precio, pesoKg) VALUES(2, 8, 550000, 40);
INSERT INTO existencias(id_producto, cantidad, precio, pesoKg) VALUES(3, 15, 120000, 30);
INSERT INTO existencias(id_producto, cantidad, precio, pesoKg) VALUES(4, 5, 350000, 5);
INSERT INTO existencias(id_producto, cantidad, precio, pesoKg) VALUES(5, 8, 550000, 40);
INSERT INTO existencias(id_producto, cantidad, precio, pesoKg) VALUES(6, 15, 120000, 30);
insert into existencias (id_producto, cantidad, precio, pesoKg) values(7, 5, 300000, 3);
insert into existencias (id_producto, cantidad, precio, pesoKg) values(8, 5, 300000, 3);
INSERT INTO existencias(id_producto, cantidad, precio, pesokg) values(9,40,20000,6);
INSERT INTO existencias(id_producto, cantidad, precio, pesoKg) VALUES (10, 11, 9990,180)

SELECT * FROM EXISTENCIAS order by id_producto;

-- 4. INSERTAR 5 FACTURAS

--ALTER TABLE facturas RENAME COLUMN rut_vendedir TO rut_vendedor;
select * from facturas;

INSERT INTO facturas(rut_comprador, rut_vendedor) VALUES ('4.444.444-4', '1.111.111-1');
INSERT INTO facturas(rut_comprador, rut_vendedor) VALUES ('16.166.166-6', '2.222.222-2');
INSERT INTO facturas (rut_comprador, rut_vendedor) VALUES ('11.222.333-5','2.222.222-2');
insert into facturas(rut_comprador, rut_vendedor) values ('7.777.777-7','2.222.222');
INSERT INTO facturas(rut_comprador, rut_vendedor) VALUES ('16.466.797-6', '1.111.111-1');

-- 5. INSERTAR DE 3 A 5 DETALLES DE FACTURA POR FACTURA.
SELECT * FROM DETALLE_FACTURAS;
INSERT INTO detalle_facturas(id_producto, id_factura) VALUES
(1,1),
(5,1),
(10,1);

INSERT INTO detalle_facturas(id_producto, id_factura) VALUES
(3,2),
(5,2),
(7,2);

INSERT INTO detalle_facturas(id_producto, id_factura) VALUES
(8,3),
(9,3),
(10,3);
INSERT INTO detalle_facturas(id_producto, id_factura) VALUES
(1,4),
(6,4),
(4,4);

INSERT INTO detalle_facturas(id_producto, id_factura) VALUES
(2,5),
(3,5),
(7,5),
(1,5),
(8,5);

-- 6. ACTUALIZAR LA EXISTENCIA DE TODOS LOS PRODUCTOS A 10

select * from existencias;
UPDATE existencias set cantidad = 10;

-- 7. AGREGAR LA COLUMNA FECHA A LA TABLA facturas
select * from facturas order by id;
alter table facturas add fecha date;

-- 8. ACTUALIZAR CAMPO FECHA A LAS FACTURAS
UPDATE facturas SET fecha = '20/01/2023' WHERE id = 1;
UPDATE facturas SET fecha = '21/01/2023' WHERE id = 2;
UPDATE facturas SET fecha = '22/01/2023' WHERE id = 3;
UPDATE facturas set fecha = '23/01/2023' where id = 4;
UPDATE facturas SET fecha = '27-01-2023' Where id = 5;

-- 9. ELIMINAR LA COLUMNA PESOKG DE EXISTENCIAS
select * from existencias;

ALTER TABLE existencias DROP COLUMN pesoKg;

-- 10. CONSULTAR UNA FACTURA EN PARTICULAR JUNTO A SU DETALLE,
-- EL NOMBRE DE CADA PRODUCTO Y SU PRECIO

select f.id as n_factura, f.fecha, pd.nombre, e.precio from facturas f
join detalle_facturas df
ON f.id = df.id_factura
join productos pd
ON df.id_producto = pd.id
join existencias e
ON pd.id = e.id_producto;

-- 11. CALCULAR EL PRECIO FINAL DE CADA FACTURA.

select f.id as n_factura, f.fecha, SUM(e.precio) as subtotal, (SUM(e.precio)*1.19) as total  from facturas f
join detalle_facturas df
ON f.id = df.id_factura
join productos pd
ON df.id_producto = pd.id
join existencias e
ON pd.id = e.id_producto
group by f.id, f.fecha
order by fecha;

-- 12 ELIMINAR TODOS LOS PRODUCTOS;

TRUNCATE productos CASCADE;