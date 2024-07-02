create database DemoApp
use DemoApp

create table Countries(
Id int primary key identity(1,1),
Name nvarchar(50) not null,
Area decimal not null,
)

create table Cities(
Id int primary key identity(1,1),
Name nvarchar(50) not null,
Area decimal not null,
CountryId int foreign key references Countries(Id)

)
create table people(
Id int primary key identity(1,1),
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
PhoneNumber nvarchar(50) not null,
Email nvarchar(50) not null unique,
BirthDate Date not null ,
Gender Bit not null,
HasCitizenship Bit not null,
CityId int foreign key references Cities(Id)

)



insert into Countries values('Azerbaycan',1234),('Colombia',900)
insert into Countries values('Iran',30000)
insert into Countries values('Iraq',555)

insert into Cities values ('Baku',60, 1),('Kali',30,1)

insert into People values('Raksana','Allahverdiyeva','0553998977','raksanall@gmail.com','2004-04-07',1,0,1)
insert into People values('Memmed','Allahverdiyev','0553998979','memmed@gmail.com','2001-04-07',0,1,1)
insert into People values('Someone','Someonov','054998979','someone@gmail.com','2001-04-07',0,1,2)



select people.name,people.surname ,cities.name as "city name" , countries.name as "country name" from People
Inner join cities on cityid=cities.Id
inner join countries on CountryId=Countries.Id

select * from Countries order by Area asc
select * from Cities order by [Name] desc

select COUNT(Area) from Countries Where Area>1000

select Max(Area) from Countries 
where Name like 'i%'



select count(Name) from people group by CityId


--select * from people
-- inner join cities on CityId=People.Id

select count(People.Name) as population ,cities.name as 'cityName' 
from  people
inner join cities on People.cityId=Cities.Id 
group by cities.name


select id,name,area from countries
union
select id,name,area from cities

select count(People.Name) as population ,cities.name as 'cityName' 
from  people
inner join cities on People.cityId=Cities.Id 
group by cities.name
having count(People.Name)>30000



select * from people
select * from cities

