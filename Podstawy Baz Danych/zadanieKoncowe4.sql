--Cw 1

--1 
select distinct c.companyname, c.phone, c.CustomerID
from customers as c
where c.customerid in 
	(select customerid from orders
	where shipVia = (select shipperId from shippers where CompanyName='United Package') and year(shippeddate)=1997);

select distinct c.companyname, c.phone, c.CustomerID
from customers as c
join orders as o on c.CustomerID=o.CustomerID
join shippers as s on s.ShipperID = o.ShipVia
where s.CompanyName='United Package' and year(o.shippeddate)=1997;

--2
select distinct c.companyname, c.phone
from customers as c
join orders as o on c.CustomerID=o.CustomerID
join [Order Details] as od on od.OrderID = o.OrderID
join Products as p on p.ProductID = od.ProductID
where p.CategoryID = (select categoryid from Categories where categoryname='Confections');

select distinct c.companyname, c.phone
from customers as c
join orders as o on c.CustomerID=o.CustomerID
join [Order Details] as od on od.OrderID = o.OrderID
join Products as p on p.ProductID = od.ProductID
join Categories as ca on ca.categoryid = p.CategoryID
where ca.CategoryName = 'Confections';

--3
select distinct c.companyname, c.phone
from customers as c
where c.CustomerID not in
	(select o.CustomerID from orders as o 
	join [Order Details] as od on od.OrderID = o.OrderID
	join Products as p on p.ProductID = od.ProductID
	join Categories as ca on ca.categoryid = p.CategoryID
	where ca.CategoryName = 'Confections');

select companyname, phone from customers
except
select distinct c.companyname, c.phone
from customers as c
join orders as o on c.CustomerID=o.CustomerID
join [Order Details] as od on od.OrderID = o.OrderID
join Products as p on p.ProductID = od.ProductID
where p.CategoryID = (select categoryid from Categories where categoryname='Confections');


--Cw 2

--1
select p.productid, p.productname, (select max(quantity) from [order details] as od 
									where od.productid = p.productid)
from Products as p;

select p.productid, p.productname, max(od.quantity)
from products as p
join [Order Details] as od on od.ProductID=p.ProductID
group by p.ProductID, p.ProductName;

--2
select p.productid, p.productname 
from Products as p 
where p.UnitPrice < (select avg(unitprice) from products);

--3
select p.productid, p.productname 
from Products as p 
where p.UnitPrice < (select avg(unitprice) from products 
					 where CategoryID=p.CategoryID);

--Cw 3

--1
select p.productname, p.unitprice, 
(select avg(unitprice) as 'avg all' from products),
abs((select avg(unitprice) from products) - p.unitprice)
from Products as p

--2
select ca.categoryname, p.productname, p.unitprice, 
(select avg(unitprice) from products 
where categoryid = p.CategoryID) as 'avg price per category',
abs((select avg(unitprice) from products 
where categoryid = p.CategoryID) - p.UnitPrice)
from products as p
join Categories as ca on ca.CategoryID = p.CategoryID;


--Cw 4

--1
select sum(od.unitprice * od.quantity * (1-od.discount)) + 
(select freight from orders where orderid = 10250)
from [Order Details] as od
where od.OrderID = 10250

select sum(od.unitprice * od.quantity * (1-od.discount)) + o.freight
from [Order Details] as od 
join orders as o on o.OrderID=od.OrderID
where od.OrderID = 10250
group by o.OrderID, o.Freight;

--2
select od.orderid, sum(od.unitprice * od.quantity * (1-od.discount)) + 
(select freight from orders where orderid = od.OrderID)
from [Order Details] as od
group by od.OrderID;

select od.OrderID, sum(od.unitprice * od.quantity * (1-od.discount)) + o.freight
from [Order Details] as od 
join orders as o on o.OrderID=od.OrderID
group by od.orderid, o.Freight;

--3
select c.address 
from customers as c
where c.CustomerID not in 
(select customerid from orders where year(orderdate)=1997
group by customerid);

select distinct address
from customers
except
select distinct c.address
from customers as c
right outer join orders as o on o.CustomerID = c.CustomerID
where year(o.OrderDate)=1997;


--4
select p.productid, p.productname
from products as p
where (select count(*) from  [Order Details] as od 
	   where od.ProductID = p.ProductID) > 1;

select p.productid, p.productname, count(distinct o.CustomerID)
from products as p
join [Order Details] as od on od.ProductID=p.ProductID
join orders as o on o.OrderID=od.OrderID
group by p.ProductID, p.Productname
having  count(distinct o.CustomerID) > 1;

--Cw 5

--1
select distinct e.firstname, e.LastName, 
(select sum( unitprice * quantity * (1-discount)) from [Order Details] as od join orders as o on o.OrderID = od.OrderID where o.EmployeeID=e.EmployeeID)
+
(select sum(freight) from orders where EmployeeID = e.EmployeeID)
from Employees as e
group by e.EmployeeID, e.FirstName, e.LastName;


--2
--?? czemu to jest zle
select top 1 e.FirstName, e.LastName, 
(sum( unitprice * quantity * (1-discount))
+
(select sum(freight) from orders 
where EmployeeID=e.EmployeeID 
and year(orderdate)=1997 and orderid=o.OrderID))
from [Order Details] as od 
join orders as o on o.OrderID = od.OrderID 
join Employees as e on e.EmployeeID=o.EmployeeID
where o.EmployeeID=e.EmployeeID and year(o.OrderDate)=1997
group by o.OrderID, e.EmployeeID, e.FirstName, e.LastName 
order by sum( unitprice * quantity * (1-discount)) desc;

select top 1 E.firstname, E.lastname,
(select sum( unitprice * quantity * (1-discount)) 
 from orders as O join [Order Details] as OD on O.OrderID=OD.OrderID
 where O.EmployeeID=E.employeeid and year(orderdate)=1997 )
 +
(select sum(freight) from orders 
 where EmployeeID=E.employeeid and year(orderdate) = 1997)
as total
from Employees as E
order by total desc

--3
select E.firstname, E.lastname,
(select sum(unitprice * quantity * (1 -discount))
from [Order Details] as od join orders as o on o.OrderID=od.OrderID
where o.EmployeeID = E.EmployeeID)
+
(select sum(freight) from orders where employeeid=E.EmployeeID)
from Employees as E
where E.EmployeeID in (select distinct ReportsTo from Employees
						where ReportsTo is not null);

--b)
select E.firstname, E.lastname,
(select sum(unitprice * quantity * (1 -discount))
from [Order Details] as od join orders as o on o.OrderID=od.OrderID
where o.EmployeeID = E.EmployeeID)
+
(select sum(freight) from orders where employeeid=E.EmployeeID)
from Employees as E
where E.EmployeeID not in (select distinct ReportsTo from Employees
							where ReportsTo is not null);

--4
select E.firstname, E.lastname,
(select sum(unitprice * quantity * (1 -discount))
from [Order Details] as od join orders as o on o.OrderID=od.OrderID
where o.EmployeeID = E.EmployeeID)
+
(select sum(freight) from orders where employeeid=E.EmployeeID) as total_orders,
(select top 1 shippedDate from orders where EmployeeID=E.EmployeeID
order by ShippedDate desc) as last_order
from Employees as E
where E.EmployeeID in (select distinct ReportsTo from Employees
							where ReportsTo is not null);


