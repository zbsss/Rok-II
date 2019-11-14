--Cwiczenie 1
--1
select sum(UnitPrice*Quantity - (1 - Discount)) as total_value, orderid from [Order Details] group by orderid order by total_value desc;
--2
select top 10 sum(UnitPrice*Quantity - (1 - Discount)) as total_value, orderid from [Order Details] group by orderid order by total_value desc;
--3
select top 10 with ties sum(UnitPrice*Quantity - (1 - Discount)) as total_value, orderid from [Order Details] group by orderid order by total_value desc;

--Cwiczenie 2
--1
select sum(quantity) as total_quantity, productid from [Order Details] where productid < 3 group by productid;
--2
select sum(quantity) as total_quantity, productid from [Order Details] group by productid order by productid;
--3
select sum(quantity) as total_quantity, productid from [Order Details]  group by productid having sum(quantity) > 250 order by productid;

--Cwiczenie 3
--1
select sum(quantity), productid from [Order Details] group by productid ;
