USE master
IF EXISTS(select * from sys.databases where name='CONSUMO')
DROP DATABASE CONSUMO

CREATE DATABASE CONSUMO;

USE CONSUMO;
--Tablas

--Usuario
create table usuario(
	us_cedula numeric(9) not null,
	us_usuario varchar(20) not null,
	us_clave varchar(20) not null,
	us_fechaCreacion date not null,
	us_activo char(1) not null, --Y/N
	us_tipoDeRol integer not null
);
alter table usuario
add constraint PK_us_cedula_usuario primary key(us_cedula);

alter table usuario
add constraint UQ_us_usuario_usuario unique(us_usuario);

alter table usuario
add constraint CH_us_activo_usuario check(us_activo in ('Y','N'));

--Rol
create table rol(
	rl_id integer identity(1,1) not null,
	rl_nombre varchar(20) not null
);

alter table rol
add constraint PK_rl_id_rol primary key(rl_id);

--Cliente
create table cliente(
	cl_cedula numeric(9) not null,
	cl_fechaCreacion date not null,
	cl_activo char(1) not null
);

alter table cliente
add constraint PK_cl_cedula_cliente primary key(cl_cedula);

alter table cliente
add constraint CH_cl_activo_cliente check(cl_activo in ('Y','N'));

--Direccion
create table direccion(
	dr_id integer identity(1,1) not null,
	dr_provincia varchar(15) not null,
	dr_canton varchar(50) not null,
	dr_distrito varchar(50) not null,
	dr_otras varchar(50),
	dr_persona numeric(9) not null
);

alter table direccion
add constraint PK_dr_id_direccion primary key(dr_id);

--Telefono
create table telefono(
	tl_id integer identity (1,1) not null,
	tl_telefono varchar(15) not null,
	tl_tipo varchar(20) not null,
	tl_persona numeric(9) not null
);

alter table telefono
add constraint PK_tl_id_telefono primary key(tl_id);

--Factura
create table factura(
	ft_numero integer identity(1,1) not null,
	ft_cliente numeric(9) not null,
ft_fecha date not null,
	ft_estampa timestamp not null,
	ft_total float not null,
	ft_estado varchar(10) not null,
	ft_facturadoPor numeric(9) not null
);

alter table factura
add constraint PK_ft_numero_factura primary key(ft_numero);

alter table factura
add constraint CH_ft_estado_factura check(ft_estado in ('Pendiente','Cancelado', 'Anulado'));
--Detalle_Factura
create table detalle_factura(
	df_factura integer not null,
	df_numeroLinea integer not null,
	df_codArticulo integer not null,
	df_cantidad integer not null,
	df_precio float not null,
	df_subtotal float not null,
	df_descuento float,
	df_total float not null
);

--Inventario
create table inventario(
	in_codArticulo integer identity(1,1) not null,
	in_descripcion varchar(50),
	in_cantidad integer not null,
	in_costo float not null,
in_precio float not null,
);

alter table inventario
add constraint PK_in_codArticulo_inventario primary key(in_codArticulo);

--Bitacora
create table bitacora(
	bt_id integer identity(1,1) not null,
	bt_fecha datetime not null,
	bt_tipo varchar(50) not null,
	bt_usuario numeric(9) not null,
bt_ip varchar(50) not null
);

alter table bitacora
add constraint PK_bt_id_bitacora primary key(bt_id);


--Relaciones
--Usuario
alter table usuario
add constraint FK_us_tipoDeRol_usuario_rol foreign key(us_tipoDeRol)
references rol(rl_id);

--Bitacora
alter table bitacora
add constraint FK_bt_usuario_bitacora_usuario foreign key(bt_usuario)
references usuario(us_cedula);

--Factura
alter table factura
add constraint FK_ft_cliente_factura_cliente foreign key(ft_cliente)
references cliente(cl_cedula);

alter table factura
add constraint FK_ft_facturadoPor_factura_usuario foreign key(ft_facturadoPor)
references usuario(us_cedula);

--Detalle_Factura
alter table detalle_factura
add constraint FK_df_factura_detalle_factura_factura foreign key(df_factura)
references factura(ft_numero);

alter table detalle_factura
add constraint FK_df_codArticulo_detalle_factura_inventario foreign key(df_codArticulo)
references inventario(in_codArticulo);