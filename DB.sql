


CREATE TABLE actividad(
    id serial  PRIMARY KEY ,
    nombre VARCHAR(450) not null,
    optimista numeric not null,
    probable numeric not null,
    pesimista numeric not null,
    predecesor integer[] ,
    hora time not null ,
    fecha date not null ,
    idcliente integer not null
);

CREATE TABLE estado(
    id serial PRIMARY key,
    descripcion VARCHAR(200) not null
);

create table actividadEstado(
    id serial PRIMARY key,
    idactividad integer not null,
    idestado integer not null ,
    hora time not null
);

create table empleadoActividad(
    id serial PRIMARY key ,
    idempleado integer not null,
    idactividad integer not null,
    estado bit not null
);


create table empleado(
   id serial PRIMARY key ,
   nombre varchar(450) not null,
   ci integer null, 
   rol varchar(250) not null
);

  create table cliente(
    idcliente serial PRIMARY KEY,
    nombre VARCHAR(250) not null,
    telefono integer not null
);


create table ruta(
   id serial PRIMARY KEY,
   latitud text not null,
   longitud text not null,
   descripcion text not null ,
   idactividad integer not null
);

create table usuario(
    id serial PRIMARY key ,
    nombre  varchar(250) not null,
    contrasena text not null ,
    idempleado integer not null 
);






  CREATE OR REPLACE FUNCTION actividad_mostrar(IN pfecha date)
  RETURNS TABLE(id integer, nombre character varying, optimista numeric, probable numeric, pesimista numeric, predecedor integer[], hora time without time zone, fecha date , idcliente integer) AS
$BODY$
begin
  return query ( select a.* from actividad a where a.fecha = pfecha ) ; 
end;
$BODY$
  LANGUAGE plpgsql VOLATILE;

  CREATE OR REPLACE FUNCTION actividad_insertar(
    pnombre character varying,
    poptimista numeric,
    pprobable numeric,
    ppesimista numeric,
    ppredecedor integer[],
    phora time without time zone,
    pfecha date ,
    pidcliente integer)
  RETURNS integer AS
$BODY$
declare 
result integer = -1;
begin
    insert into actividad(nombre,optimista,probable,pesimista,predecesor,hora,fecha,idcliente )
    values(pnombre,poptimista,pprobable,ppesimista,ppredecedor,phora,pfecha,pidcliente) returning id into result;
    return result;
    
end;
$BODY$
  LANGUAGE plpgsql VOLATILE;

create or replace function ruta_insertar(platitud text, plongitud text , pdescripcion text,pidactividad integer)
returns integer as 
$$
declare 
result integer = -1;
begin 
   insert into ruta(latitud,longitud,descripcion,idactividad) values (platitud,plongitud,pdescripcion,pidactividad) returning 
   id into result ;
   return result;
end;
$$
language plpgsql;




create or replace function actividadestado_insertarp(pidActividad integer,pidEstado integer , phora time)
returns integer as
$$
declare 
result integer := -1;
begin
   insert into actividadestado(idactividad,idestado,hora) values(pidActividad,pidEstado,phora) returning id into result;
   return result;
end;
$$
language plpgsql;



create or replace function ruta_mostrar(pfecha date)
returns table(id integer,latitud text , longitud text , descripcion text ,idactividad integer,hora time , estado varchar) as
$$
begin
   return query (  select r.* , (select ae.hora  from estado e , actividadestado ae where e.id = ae.idestado and ae.idactividad =a.id order by ae.id desc limit 1) , (select e.descripcion from estado e , actividadestado ae where e.id = ae.idestado and ae.idactividad =a.id order by ae.id desc limit 1)from ruta r, actividad a  where r.idactividad = a.id and
  
     a.fecha = pfecha);
end;
$$
language plpgsql;



create or replace function estado_mostrar()
returns table(id integer , descripcion varchar) as
$$
begin
	 return query(select * from estado order by id asc);
end;
$$
language plpgsql;







CREATE OR REPLACE FUNCTION empleado_mostrar()
  RETURNS TABLE(id integer, nombre character varying, ci integer, rol varchar) AS
$BODY$
begin
   return query(select * from empleado);
end;
$BODY$
  LANGUAGE plpgsql VOLATILE;


create or replace function empleado_insertar(pnombre varchar,pci integer,prol varchar)
returns integer as
$$
declare 
   result integer = -1;
begin
    insert into empleado(nombre,ci,rol) values(pnombre,pci,prol) returning id into result;
    return result;
end;
$$
language plpgsql;





create or replace function cliente_listar()
returns table(idcliente integer , nombre varchar , telefono integer) as
$$
begin
	return query (select * from cliente);
end;
$$
language plpgsql;

create or replace function cliente_insertar(pnombre varchar,ptelefono integer)
returns integer as
$$
declare 
result integer = -1;
begin
    insert into cliente(nombre,telefono) values(pnombre,ptelefono) returning idcliente into result;
    return result;
end;
$$
language plpgsql;







CREATE TABLE actividad(
    id serial  PRIMARY KEY ,
    nombre VARCHAR(450) not null,
    optimista numeric not null,
    probable numeric not null,
    pesimista numeric not null,
    predecesor integer[] ,
    hora time not null ,
    fecha date not null ,
    idcliente integer not null
);

CREATE TABLE estado(
    id serial PRIMARY key,
    descripcion VARCHAR(200) not null
);

create table actividadEstado(
    id serial PRIMARY key,
    idactividad integer not null,
    idestado integer not null ,
    hora time not null
);

create table empleadoActividad(
    id serial PRIMARY key ,
    idempleado integer not null,
    idactividad integer not null,
    estado bit not null
);


create table empleado(
   id serial PRIMARY key ,
   nombre varchar(450) not null,
   ci integer null, 
   rol varchar(250) not null
);

  create table cliente(
    idcliente serial PRIMARY KEY,
    nombre VARCHAR(250) not null,
    telefono integer not null
);


create table ruta(
   id serial PRIMARY KEY,
   latitud text not null,
   longitud text not null,
   descripcion text not null ,
   idactividad integer not null
);

create table usuario(
    id serial PRIMARY key ,
    nombre  varchar(250) not null,
    contrasena text not null ,
    idempleado integer not null 
);






  CREATE OR REPLACE FUNCTION actividad_mostrar(IN pfecha date)
  RETURNS TABLE(id integer, nombre character varying, optimista numeric, probable numeric, pesimista numeric, predecedor integer[], hora time without time zone, fecha date) AS
$BODY$
begin
  return query ( select a.* from actividad a where a.fecha = pfecha ) ; 
end;
$BODY$
  LANGUAGE plpgsql VOLATILE;

  CREATE OR REPLACE FUNCTION actividad_insertar(
    pnombre character varying,
    poptimista numeric,
    pprobable numeric,
    ppesimista numeric,
    ppredecedor integer[],
    phora time without time zone,
    pfecha date ,
    pidcliente integer)
  RETURNS integer AS
$BODY$
declare 
result integer = -1;
begin
    insert into actividad(nombre,optimista,probable,pesimista,predecesor,hora,fecha,idcliente )
    values(pnombre,poptimista,pprobable,ppesimista,ppredecedor,phora,pfecha,pidcliente) returning id into result;
    return result;
    
end;
$BODY$
  LANGUAGE plpgsql VOLATILE;

create or replace function ruta_insertar(platitud text, plongitud text , pdescripcion text,pidactividad integer)
returns integer as 
$$
declare 
result integer = -1;
begin 
   insert into ruta(latitud,longitud,descripcion,idactividad) values (platitud,plongitud,pdescripcion,pidactividad) returning 
   id into result ;
   return result;
end;
$$
language plpgsql;




create or replace function actividadestado_insertarp(pidActividad integer,pidEstado integer , phora time)
returns integer as
$$
declare 
result integer := -1;
begin
   insert into actividadestado(idactividad,idestado,hora) values(pidActividad,pidEstado,phora) returning id into result;
   return result;
end;
$$
language plpgsql;



create or replace function ruta_mostrar(pfecha date)
returns table(id integer,latitud text , longitud text , descripcion text ,idactividad integer,hora time , estado varchar) as
$$
begin
   return query (  select r.* , (select ae.hora  from estado e , actividadestado ae where e.id = ae.idestado and ae.idactividad =a.id order by ae.id desc limit 1) , (select e.descripcion from estado e , actividadestado ae where e.id = ae.idestado and ae.idactividad =a.id order by ae.id desc limit 1)from ruta r, actividad a  where r.idactividad = a.id and
  
     a.fecha = pfecha);
end;
$$
language plpgsql;



create or replace function estado_mostrar()
returns table(id integer , descripcion varchar) as
$$
begin
	 return query(select * from estado order by id asc);
end;
$$
language plpgsql;







CREATE OR REPLACE FUNCTION empleado_mostrar()
  RETURNS TABLE(id integer, nombre character varying, ci integer, rol varchar) AS
$BODY$
begin
   return query(select * from empleado);
end;
$BODY$
  LANGUAGE plpgsql VOLATILE;


create or replace function empleado_insertar(pnombre varchar,pci integer,prol varchar)
returns integer as
$$
declare 
   result integer = -1;
begin
    insert into empleado(nombre,ci,rol) values(pnombre,pci,prol) returning id into result;
    return result;
end;
$$
language plpgsql;





create or replace function cliente_listar()
returns table(idcliente integer , nombre varchar , telefono integer) as
$$
begin
	return query (select * from cliente);
end;
$$
language plpgsql;

create or replace function cliente_insertar(pnombre varchar,ptelefono integer)
returns integer as
$$
declare 
result integer = -1;
begin
    insert into cliente(nombre,telefono) values(pnombre,ptelefono) returning idcliente into result;
    return result;
end;
$$
language plpgsql;

select * from actividad

select * from cliente_insertar('Carlos',75090642);

select * from ruta_mostrar('2020-10-05');

select * from actividad_mostrar('2020-10-05');
select * from actividad;
DROP FUNCTION actividad_mostrar(date)
  CREATE OR REPLACE FUNCTION actividad_mostrar(IN pfecha date)
  RETURNS TABLE(id integer, nombre character varying, optimista numeric, probable numeric, pesimista numeric, predecedor integer[], hora time without time zone, fecha date , idcliente integer) AS
$BODY$
begin
  return query ( select a.* from actividad a where a.fecha = pfecha ) ; 
end;
$BODY$
  LANGUAGE plpgsql VOLATILE;