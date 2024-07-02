create database ORDERManagement

CREATE TABLE SELLERS (
Id int primary key identity(1,1),
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
City nvarchar(50) not null
)

CREATE TABLE Customers(
Id int primary key identity(1,1),
Name nvarchar(50) not null,
Surname nvarchar(50) not null,
City nvarchar(50) not null
)
CREATE TABLE Orders(
Id int primary key identity(1,1),
OrderDate DateTime not null,
Amount int not null,
State bit not null,
CustomerId int foreign key references Customers(Id),
SellerId int foreign key references Sellers(Id)
)


insert into customers values('Raksana','Allahverdiyeva','Baku')
insert into customers values('Nuray','Pashayeva','Xachmaz')
insert into customers values('Nigar','Shirinova','Sumqayit')
insert into customers values('Samira','Ismayilova','Quba')

insert into sellers values('Kanan','Tapdiqli','Sumqayit')
insert into sellers values ('Ali','Ibrahimli','Baku')
insert into sellers values ('Terane','Rehimli','Quba')

insert into orders values('1900-01-01 00:00:00',200,0,3,1)
insert into orders values('1900-02-01 22:33:24',500,1,2,2)
insert into orders values('1900-10-09 12:25:36',100,0,1,2)
insert into orders values('1900-10-09 12:25:36',990,1,1,1)
insert into orders values('2024-02-19 10:25:36',990,1,3,1)
insert into orders values('2024-03-07 09:20:36',600,1,1,2)
insert into orders values('2024-06-17 09:20:36',600,1,2,1)
insert into orders values('2024-07-01 09:20:36',330,1,1,2)

--a. Umumi sifaris meblegleri 1000manatdan yuxari olan musterilerin meblegle birlikde siyahisi

select customers.Name,customers.Surname, Sum(Orders.Amount) as 'OrderAmount' from Customers
Inner join Orders on Customers.Id=Orders.CustomerId
group by customers.Name,customers.Surname
having  Sum(Orders.Amount)>1000


--b. Eyni seherde qalan musteri ve saticilarin siyahisi


select * from customers
inner join sellers on customers.city=sellers.city

--c. Sifaris tarixi 2024-01-04 den bugune kimi olan ve tamamlanmis sifarislerin siyahisi

select * from Orders
where orders.State=1 and OrderDate> 2024-01-04

--d. 10 dan cox sifaris tamamlayan saticilarin siyahisi (men 2 yoxladim)

select customers.Name, customers.Surname,count(orders.CustomerId) as Order_Count from customers
inner join orders on orders.CustomerId=customers.Id
Group by customers.Name, customers.Surname
having count(CustomerId)>2

--e. En cox sifarisi olan musterilerin siyahisi

select top 5 customers.Name,customers.Surname,count(orders.customerId) as order_count from customers
inner join orders on orders.CustomerId=Customers.Id
Group by customers.Name, customers.Surname
Order by order_count desc;

--f. Sifaris tarixi en evvel olan ve tamamlanmamis sifarislerin satici melumatlari ile birge tarixe gore siyahisi 

select customers.Name,customers.Surname, orders.state, orders.OrderDate from customers
inner join orders on orders.customerid=customers.id
where orders.state=0 
order by orders.orderdate asc

--g. Son 1 ayda tamamlanmislarin siyahisi


select customers.Name,customers.Surname, orders.state, orders.OrderDate from customers
inner join orders on orders.customerid=customers.id
where orders.state=1 and orders.orderdate between DATEADD(month,-1,getdate()) and getdate()


