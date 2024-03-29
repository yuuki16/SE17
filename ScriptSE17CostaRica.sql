USE master
IF EXISTS(select * from sys.databases where name='COSTARICA')
DROP DATABASE COSTARICA

CREATE DATABASE COSTARICA;    

Use COSTARICA;

--Tablas

set dateformat ymd;

create table persona(
 	pr_cedula numeric(9),
	pr_codelec numeric(6),
	pr_sexo numeric(1),
	pr_fechaCaduc date,
	pr_junta numeric(5),
	pr_nombre varchar(30),
	pr_apellido1 varchar(26),
	pr_apellido2 varchar(26)
);                       

bulk insert persona from 'C:\Users\Michelle\Desktop\UIA\III Cuatrimestre 2015\Implementación y Mantenimiento de Software\PADRON_COMPLETO.txt' with (FIELDTERMINATOR = ',');                                                                                                                                                                                       
