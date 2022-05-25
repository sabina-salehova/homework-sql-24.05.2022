create database Market
use Market

create table Position
(
	[Position_id] int primary key identity,
	[Position_name] nvarchar(30)
)

insert into Position
values('director'),
('seller')

create table Employee
(
	[Employee_id] int primary key identity,
	[Name] nvarchar(20),
	[Surname] nvarchar(25),
	[Father_name] nvarchar(20),
	[Position_id] int foreign key references Position([Position_id])
)

insert into Employee
values('Mammad','Salimli','Qabil',1),
('Gulnar','Haciyeva','Farid',2),
('Safar','Safarli','Nuru',2)

create table Branch
(
	[Branch_id] int primary key identity,
	[Branch_name] nvarchar(20)
)

insert into Branch
values('Baku branch'),
('Ganja branch')

create table Product
(
	[Product_id] int primary key identity,
	[Product_name] nvarchar(20),
	[Buying_price] int,
	[Sale_price] int,	
	[Branch_id] int foreign key references Branch([Branch_id])
)

insert into Product
values('milk',12,17,1),
('Bread',1,3,1),
('water',3,5,2)



create table Sales
(
	[Sales_id] int primary key identity,
	[Product_id] int foreign key references Product([Product_id]),
	[Employee_id] int foreign key references Employee([Employee_id]),
	[Sales_time] date
)

insert into Sales
values (1,2,'10.10.2020'),
(1,3,'05.05.2022'),
(3,3,'08.08.2015'),
(2,2,'07.04.2016')

select * from Employee

-- 1) Satış cədvəlində işçilərin , satılan məhsulların, satışın olduğu filialın, məhsulun alış və satış qiyməti yazılsın.--

select (e.Name+' '+e.Surname+''+e.Father_name) as Fullname, p.Product_name, p.Buying_price,p.Sale_price, b.Branch_name from Sales as s
inner join Product as p
on p.Product_id=s.Product_id
join Branch as b
on p.Branch_id=b.Branch_id
inner join Employee as e
on  s.Employee_id=e.Employee_id

-- 2) Bütün satışların cəmini tap. -- 

select sum(p.Sale_price) as 'Satişların cəmi' from Sales as s
inner join Product as p
on p.Product_id=s.Product_id
join Branch as b
on p.Branch_id=b.Branch_id
inner join Employee as e
on  s.Employee_id=e.Employee_id

-- 3) Hər işçinin satdığı məhsul sayını tap --

select s.Employee_id, count(s.Product_id) as 'Satılmış məhsul sayı' from Sales as s
left join Employee as e on s.Employee_id=e.Employee_id
group by s.Employee_id; 
