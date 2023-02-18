create database Museo_Metropolitano

use Museo_Metropolitano

create table Piezas(
id_piezas varchar(5) primary key not null,
nombre_piezas char(50)
)

create table Pintores(
id_pintor varchar(5) primary key not null,
nombre_pintor char(50)
)

create table Exposicion(
id_piezas varchar(5) primary key not null,
id_pintor varchar(5),
precio float

)

ALTER TABLE Exposicion add constraint fk_pieza_exposicion
foreign key (id_piezas) references Piezas(id_piezas)

ALTER TABLE Exposicion add constraint fk_pintor_exposicion
foreign key (id_pintor) references Pintores(id_pintor)

insert into Piezas values('PA001' , 'La ultima Cena')
insert into Piezas values('PA002' , 'La Gioconda')
insert into Piezas values('PA003' , 'La noche estrellada')
insert into Piezas values('PA004' , 'Las tres gracias')
insert into Piezas values('PA005' , 'El grito')
insert into Piezas values('PA006' , 'El guernica')
insert into Piezas values('PA007' , 'La creacion de Adan')
insert into Piezas values('PA008' , 'Los Girasoles')
insert into Piezas values('PA009' , 'La tentacion de San Antonio')
insert into Piezas values('PA010' , 'La ultima Cena')
insert into Piezas values('PA011' , 'El taller de BD')

insert into Pintores values ('NA001','Goya')
insert into Pintores values ('NA002','Dalí')
insert into Pintores values ('NA003','Van Gogh')
insert into Pintores values ('NA004','Miguel Angel')
insert into Pintores values ('NA005','Pablo Picasso')
insert into Pintores values ('NA006','Rubens')
insert into Pintores values ('NA007','Da Vinci')
insert into Pintores values ('NA008','Kevin')

insert into exposicion values ('PA001','NA007',12000.80)
insert into exposicion values ('PA002','NA007',13500.70)
insert into exposicion values ('PA003','NA003',18000.13)
insert into exposicion values ('PA004','NA006',25000.00)
insert into exposicion values ('PA005','NA003',30879.00)
insert into exposicion values ('PA006','NA005',25000.25)
insert into exposicion values ('PA007','NA004',50000.75)
insert into exposicion values ('PA008','NA003',10000.80)
insert into exposicion values ('PA009','NA002',13000.10)
insert into exposicion values ('PA010','NA001',9000.05)
insert into exposicion values ('PA011','NA008', null)

--1

select nombre_piezas as [Nombre de las piezas] from Piezas

--2

select * from pintores

--3

select ROUND( (SUM(precio)/11), 2) as [Promedio de los precios] from exposicion

--4

select nombre_pintor as [Autor de El Grito] from pintores where id_pintor = (select id_pintor from exposicion where id_piezas = 'PA005')

--5


select id_piezas from exposicion where id_pintor = 'NA003'

select nombre_piezas [De Vangho]from Piezas where id_piezas in ('PA003','PA005', 'PA008')

--6
select nombre_piezas as [Mayor valor] from Piezas where id_piezas = (select id_piezas from Exposicion where precio = (select MAX(precio) as [Obra mas cara] from exposicion))

--7

 select top 3
    (select nombre_pintor from Pintores where id_pintor = E.id_pintor) as Pintor,
    (select nombre_piezas from Piezas where id_piezas = E.id_piezas) as Obra,
    E.precio as Precio
from Exposicion E
order by E.precio desc


--8

select Pintores.nombre_pintor as [Nombre], COUNT(Exposicion.id_pintor) as [Cantidad de obras] from Pintores
Pintores left join Exposicion Exposicion on Pintores.id_pintor = Exposicion.id_pintor group by Pintores.nombre_pintor

--9

select nombre_piezas [Pizas que pertenecen a Van Gogh y Da Vinci]from Exposicion a, Pintores b, Piezas c where a.id_piezas = c.id_piezas and a.id_pintor = b.id_pintor and nombre_pintor in ('Van Gogh','Da Vinci')
select * from Pintores
--10

update Exposicion set precio = precio + 1;




--11
select nombre_pintor from Pintores 
update Pintores set nombre_pintor = 'Vicente Van Gogh' where nombre_pintor = 'Van Gogh'
select nombre_pintor from Pintores


--12


select nombre_pintor from Pintores
update Pintores set nombre_pintor = 'Leonardo Da Vinci ' where nombre_pintor = 'Da Vinci '
select nombre_pintor from Pintores

--13

select * from Exposicion
delete from Exposicion where id_pintor = 'NA008';
select * from Exposicion

--14

select top 1 id_pintor from Exposicion group by id_pintor order by COUNT(*)


declare @eliminacion varchar(5)
set @eliminacion = (select top 1 id_pintor from Exposicion group by id_pintor order by COUNT(*) )

begin transaction
delete from Exposicion where id_pintor = @eliminacion
delete from Pintores where id_pintor = @eliminacion

commit

