------------------------------------------------------------------------------
7 Fevrier
------------------------------------------------------------------------------
SELECT  categoryname, count(*)
FROM  products 
JOIN categories USING (categoryid)
GROUP BY categoryname
ORDER BY COUNT(*) DESC
;

select productname, ROUND(avg(quantity))
from products
join order_details using (productid)
group by productname
order by avg(quantity) DESC
;

SELECT COUNTRY, COUNT(*)
FROM suppliers
GROUP BY COUNTRY
ORDER BY COUNT(*) DESC
;

SELECT PRODUCTNAME, SUM(order_details.unitprice*quantity) 
FROM PRODUCTS
JOIN ORDER_DETAILS USING (PRODUCTID)
JOIN ORDERS USING (ORDERID)
WHERE orderdate between '1997-01-01' AND '1997-12-31'
GROUP BY PRODUCTNAME
HAVING SUM(order_details.unitprice*quantity)>35000
ORDER BY SUM(order_details.unitprice*quantity) DESC LIMIT 4
;

SELECT companyname, sum(order_details.unitprice*quantity)
FROM customers
JOIN orders USING (customerid)
JOIN order_details USING (orderid)
GROUP BY companyname
HAVING sum(order_details.unitprice*quantity)>5000
ORDER BY sum(order_details.unitprice*quantity) DESC LIMIT 10
;

SELECT companyname, sum(order_details.unitprice*quantity)
FROM customers
JOIN orders USING (customerid)
JOIN order_details USING (orderid)
WHERE orderdate between '1997-01-01' and '1997-06-30'
GROUP BY companyname
HAVING sum(order_details.unitprice*quantity)>5000
ORDER BY sum(order_details.unitprice*quantity) DESC LIMIT 100
;

SELECT  categoryname,productname, sum(order_details.unitprice*order_details.quantity)
FROM  categories 
JOIN products USING (categoryid)
JOIN order_details USING (productid)
GROUP BY GROUPING SETS ((categoryname),(categoryname,productname))
ORDER BY categoryname,productname 
;

SELECT  categoryname,productname, sum(order_details.unitprice*order_details.quantity)
FROM  categories 
NATURAL JOIN products 
NATURAL JOIN order_details 
GROUP BY GROUPING SETS ((categoryname),(categoryname,productname))
ORDER BY categoryname,productname 
;

SELECT  c.companyname, s.contactname, sum(od.unitprice*quantity)
FROM  customers as c
NATURAL JOIN orders
NATURAL JOIN order_details as od
JOIN products USING (productid)
JOIN suppliers as s USING (supplierid)
GROUP BY GROUPING SETS ((c.companyname),(c.companyname,s.contactname))
ORDER BY c.companyname,s.contactname 
;

SELECT  companyname,categoryname,productname, sum(order_details.unitprice*order_details.quantity)
FROM  customers 
NATURAL JOIN orders 
NATURAL JOIN order_details 
JOIN products USING (productid)
JOIN categories USING (categoryid)
GROUP BY ROLLUP (companyname,categoryname,productname)
ORDER BY companyname,categoryname,productname 
;

SELECT  companyname,categoryname,productname, sum(order_details.unitprice*order_details.quantity)
FROM  customers 
JOIN products USING (productid)
JOIN suppliers USING (supplierid)
GROUP BY ROLLUP (companyname,categoryname,productname)
ORDER BY companyname,categoryname,productname 
;

select count(*) from (
SELECT city
from customers
intersect all
select city
from suppliers ) as together;

select count(*) from (
select city from customers
except all
select city from suppliers ) as lonely_customers_city;


where companyname like 'B%' order by companyname asc limit 8

------------------------------------------------------------------------------
8 Fevrier
------------------------------------------------------------------------------
select companyname
from customers
where exists ( select customerid from orders 
			  where orders.customerid = customers.customerid
			  and orderdate between '1997-04-01' and '1997-04-30')

select productname
from products
where not exists ( select productid from order_details
				  join orders on orders.orderid=order_details.orderid
			  where order_details.productid = products.productid
			  and orderdate between '1997-04-01' and '1997-04-30')


select companyname
from suppliers
where exists (select productid from products
			 where products.supplierid=suppliers.supplierid
			 and unitprice>200)
			 

			 
select companyname
from customers
where customerid = any (select customerid from orders
					   join order_details using (orderid)
					   where quantity >50)
					   
select companyname
from suppliers
where supplierid = any (select supplierid from order_details
					   join products using (productid)
					   where quantity =1)					   
					  
					  
select distinct companyname
from customers
join orders using (customerid)
join order_details using (orderid)
where  unitprice*quantity > all (select avg(unitprice*quantity) from order_details
					   join orders using (orderid)
					   group by customerid);
					   
select companyname from suppliers
where city IN (select city from customers)

insert into order_details
 (orderid, productid,unitprice, quantity, discount)
values (11078,11,14, 20, 0);

select * from products
where productname like '%Cabrales%';

insert into products (productname, uniteprice, quantity)
values ('mortadela', 20, 10)
returning productid;

update products
set productname= 'queso'
where productid = 1
returning productid, productname;

create table suscribers(
first_name varchar(25),
last_name varchar(25),
email varchar(25),
signup_date timestamp,
frecuency int,
iscustomerid boolean) 

create table returns(
returnsid serial,
customerid char(5) ,
datereturned timestamp,
productid INT,
quantity SMALLINT,
orderid integer
	
)

Alter table suscribers
rename first_name to firstname;

alter table returns
rename datereturned to return_date;




alter TABLE suscribers
rename to email_suscribers;


alter table returns 
rename to bad_orders;





alter table email_suscribers
add column last_visit_date TIMESTAMP;

alter table bad_orders
add column reason text;



alter table email_suscribers
drop COLUMN last_visit_date;

alter table bad_orders
drop column reason;



alter table email_suscribers
alter column email  SET DATA TYPE VARCHAR(225);

ALTER TABLE bad_orders
ALTER COLUMN quantity SET DATA TYPE int;

DROP TABLE bad_orders;

create table practices(
practicesid integer NOT NULL,
practice_field varchar(50) NOT NULL
)


alter table products
alter column unitprice set not null;


alter table employees
alter column lastname set not null;



create table practices(
practiceid serial unique ,
fieldname varchar(50) not null
)

drop table practices;


create table pets (
petid integer unique,
name varchar(25) not null
)

alter table region
add constraint region_description UNIQUE(regiondescription);

alter table shippers
add constraint shippers_companyname unique (companyname);

create table practices(
practiceid integer primary key ,
fieldname varchar(50) not null
)

insert into practices (practiceid, fieldname)values(2, 'red');

drop table pets;

create table pets (
petid integer primary key,
	name varchar(25) not null
)


alter table practices
drop CONSTRAINT practices_pkey;

alter table practices
add primary key (practiceid);


alter table pets
drop CONSTRAINT pets_pkey;

alter TABLE pets
add primary key(petid);



create table practices (
 practiceid integer primary key,
fieldname varchar(50) not null,
employeeid integer not null,
	foreign key (employeeid) references employees(employeeid)
)


create table pets (
	petid integer primary key,
	name varchar(25) not null,
	customerid char(5) not null,
	foreign key (customerid) references customers (customerid)
)

alter table practices
drop constraint practices_employeeid_fkey;

alter table practices
add constraint practices_employeeid_fkey 
FOREIGN key (employeeid) references employees (employeeid);


drop table practices;


alter table pets
drop CONstraint pets_customerid_fkey;

alter table pets
add constraint pets_customerid_fkey
foreign key (customerid) references customers (customerid);




create table practices (
 practiceid integer primary key,
fieldname varchar(50) not null,
employeeid integer not null,
cost integer constraint practices_cost CHECK (cost>0 and cost <=100),
	foreign key (employeeid) references employees(employeeid)
)

insert into practices (practiceid, fieldname, employeeid, cost) values (1, 'test', 2, 100);

drop table pets;

create table pets (
	petid integer primary key,
	name varchar(25) not null,
	customerid char(5) not null,
	weight integer default 5 constraint pets_weight CHECK (weight >= 0 and weight <=200),
	foreign key (customerid) references customers (customerid)
)

insert into pets (petid, name, customerid, weight) values (1, 'test', 6, 200);

SELECT* from customers;

alter table orders
add constraint orders_freight CHECK (freight >0);

alter table products
add constraint products_unitprice CHECK (unitprice >0);

create table practices (

practiceid integer primary key,
fieldname varchar(50) not null,
employeeid integer not null,
cost integer default 50 constraint practices_cost CHECK (cost>0 and cost <=100),
	foreign key (employeeid) references employees(employeeid)
)

alter table orders
alter column shipvia set default 1;

alter table products
alter column reorderlevel set default 5;


alter table products
alter column reorderlevel drop default;

alter table suppliers
alter column homepage set default 'N/A';

alter table suppliers
ALTER COLUMN homepage drop default;

alter table products
add constraint products_reorderlevel check (reorderlevel>=0);

alter table products
drop constraint products_reorderlevel_check;

alter table products
alter column discontinued set not null;

alter table products
drop constraint products_reorderlevel;

alter table products
alter column discontinued drop not null;

alter table order_details
add constraint order_details_unitprice check (unitprice >0);


alter table order_details
alter column discount set not null;

alter table order_details
drop constraint order_details_unitprice;

alter table order_details
alter column discount drop not null;

------------------------------------------------------------------------------
9 Fevriér
------------------------------------------------------------------------------


create sequence test_sequence

select nextval ('test_sequence')

select currval ('test_sequence')

select lastval ()



select setval ('test_sequence', 25, false)

select nextval ('test_sequence')

create sequence if not exists test_sequence2  increment 5;

select nextval ('test_sequence4') 

create sequence if not exists test_sequence3  
increment 50
MINVALUE 350
MAXVALUE 5000
START WITH 550
;

create sequence if not exists test_sequence4
INCREMENT 7
START WITH 33

select max(employeeid) from employees

CREATE SEQUENCE IF NOT EXISTS employees_employeeid_seq
increment 1
start WITH 10 OWned by employees.employeeid

insert into employees( lastname, firstname,title, reportsto) values ('Smit', 'Bob', 'Assitant', 2);


alter table employees
alter column employeeid set default nextval('employees_employeeid_seq');

select * from employees

insert into employees( lastname, firstname,title, reportsto) values ('Smit', 'Bob', 'Assitant', 2) returning employeeid;


select max(orderid) from orders
create sequence if not exists orders_orderid_seq start with 11078 owned by orders.orderid;

alter table orders
alter column orderid set default nextval('orders_orderid_seq')

insert into orders (customerid, employeeid, requireddate, shippeddate)
values ('VINET',5,'1996-08-01','1996-08-06') returning orderid;

ALTER SEQUENCE employees_employeeid_seq 
restart with 1000;


select nextval('employees_employeeid_seq')

alter sequence orders_orderid_seq 
restart with 200000;


select nextval('orders_orderid_seq')


alter SEQUENCE test_sequence
rename to test_sequence1

alter sequence test_sequence4
rename to test_sequence_four

drop SEQUENCE test_sequence_four

create table exes (
exid serial primary key,
name varchar(25)
)

insert into exes (name) values ('pedro') returning exid
select * from exes

create table pets2 (
petid serial primary key,
	name varchar (255)
)

insert into pets2
(name) 
values ('panchito') returning petid



create view suppliers_order_details as

select companyname,suppliers.supplierid, products.productid, productname, orders.*, order_details.unitprice, quantity, discount 
from suppliers
join products using (supplierid)
 join order_details using (productid)
 join orders using (orderid)
 
 
 select * from suppliers_order_details
 where supplierid =5;
 
 alter view suppliers_order_details
 rename to suppliers_order
 
 
 drop view suppliers_order
 
 
 
 select distinct (country)
 from customers
 
 select companyname, country
 case when country in ('Austria','Germany','Poland') then 'Europa'
 		when country in ('Mexico','USA','Canada') then 'North America'
		when country in ('Brazil','Venezuela','Argentina') then 'South America'
		else 'unknow'
	end as continent
from customers

select orderid,customerid,
case date_part('year', orderdate) 
	when 1996 then 'year1'
	when 1997 then 'year2'
	when 1998 then 'year3'
	else 'unknow'
end 
 from orders

 select companyname, COALESCE(homepage, 'Call to find') from suppliers

 create table test_time(
startdate date,
	startstamp timestamp,
	starttime time

)

show datestyle;

set datestyle = 'ISO, DMY'

insert into test_time (startdate,startstamp,starttime) 
values ( 'now', 'today', 'now')

select * from test_time;

select * from pg_timezone_names;

select * from pg_timezone_abbrevs;



alter table test_time
add column endtime time with time zone;




insert into test_time (endstamp, endtime) values ('06/20/2018 10:30:00 US/Pacific', '10:30:00+5')ABORT




show time zone

select * from test_time;

set time zone 'US/Pacific'

set time zone 'America/Tegucigalpa'



alter table test_time
add column span INTERVAL;

delete from test_time;

insert into test_time (span) values ('5 decades 3 years 6 months 3 days')



SET intervalstyle = 'postgres';


--//----------------------------------------------------------------------


select timestamp '2016-12-30 23:39:17' - INTERVAL '27 YEAR 3 MONTHS 17 DAYS 3 HOURS 37 MINUTES'


SELECT DATE '2016-12-30' - INTEGER '300'

-------------------------------------Windows Function------------------------------------


select categoryname, productname, unitprice, avg(unitprice) over (partition by categoryname)
from products
join categories using (categoryid)


select categoryname, productname, unitprice, avg(unitprice) over (partition by categoryname)
from products
join categories using (categoryid)
order by categoryname, unitprice desc


select  productname, quantity, avg(quantity) over (partition by productname)
from products
join order_details using (productid)
where productname = 'Alice Mutton'
order by productname, quantity desc


select  productname, quantity,avg(products.unitprice) over (partition by productname) as price, 
avg(quantity) over (partition by productname) as average
from products
join order_details using (productid)

order by quantity DESC


select companyname, orders.orderid, sum(unitprice*quantity) as amount 
from customers
join orders using (customerid)
join order_details using(orderid)
group by companyname, orders.orderid
order by amount desc

--//-----------------COMPOSITE TYPES----------------------

CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
);

CREATE TABLE friends (
	first_name varchar(100),
	last_name varchar(100),
	address	address
);

DROP TYPE address CASCADE;
DROP TABLE friends;


CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
);

CREATE TYPE full_name AS (
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
);

CREATE TABLE friends (
	name full_name,
	address	address
);

DROP TYPE address CASCADE;
DROP TYPE full_name CASCADE;
DROP TABLE friends;


CREATE TYPE address AS (
	street_address 	varchar(50),
	street_address2 varchar(50),
	city			varchar(50),
	state_region	varchar(50),
	country			varchar(50),
	postalcode		varchar(15)
);

CREATE TYPE full_name AS (
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
);

CREATE TYPE dates_to_remember AS (
  birthdate date,
  age       integer,
  anniversary date
);

CREATE TABLE friends (
	name full_name,
	address	address,
  specialdates dates_to_remember
);

INSERT INTO friends (name, address, specialdates)
VALUES (ROW('Boyd','M','Gregory'),ROW('7777','','Boise','Idaho','USA','99999'),ROW('1969-02-01',49,'2001-07-15'));

SELECT * FROM friends;
SELECT name FROM friends;

SELECT (address).city,(specialdates).birthdate
FROM friends;

SELECT name FROM friends
WHERE (name).first_name = 'Boyd';

SELECT (address).state_region,(name).middle_name,(specialdates).age FROM friends
WHERE (name).last_name = 'Gregory';


------------------------FUNCTIONS-------------------------

CREATE OR REPLACE FUNCTION customer_largest_order(cid bpchar) RETURNS double precision AS $$
	SELECT MAX(order_total) FROM
	(SELECT SUM(quantity*unitprice) as order_total,orderid
	FROM order_details
	NATURAL JOIN orders
	WHERE customerid=cid
	GROUP BY orderid) as order_total;
$$ LANGUAGE SQL;

SELECT customer_largest_order('ANATR');

CREATE OR REPLACE FUNCTION most_ordered_product(customerid bpchar) RETURNS varchar(40) AS $$
	SELECT productname
	FROM products
	WHERE productid IN
	(SELECT productid FROM
	(SELECT SUM(quantity) as total_ordered, productid
	FROM order_details
	NATURAL JOIN orders
	WHERE customerid= $1
	GROUP BY productid
	ORDER BY total_ordered DESC
	LIMIT 1) as ordered_products);
$$ LANGUAGE SQL;

SELECT most_ordered_product('CACTU');


------------------------------------------------------------------------------
10 Fevriér
------------------------------------------------------------------------------

CREATE or replace function new_price(products, increase_percent numeric)
returns double precision as $$

	SELECT $1.unitprice*increase_percent/100

$$ language sql


select productname, unitprice, new_price(products.*,200)
from products


create or replace function full_name(employees )
returns varchar(62) as $$

	select $1.title || ' ' || $1.firstname || ' ' || $1.lastname 

$$ language sql


select full_name(employees.*), city, country from employees


create or replace function newest_hire () returns employees as $$

select * from employees order by hiredate asc limit 1 ;

$$ language sql


select (newest_hire()).*;

create or replace function highest_inventory() returns products as $$

	select *
	from products 
	order by (unitprice*unitsinstock) desc limit 1;

$$ language sql


select productname(highest_inventory());

create or replace function sum_n_products (x int , y int , out sum int, out product int) as $$

	select x+y, x*y

$$ language sql

select sum_n_products(5,20)


create or replace function square_n_cube (in x int, out aquare int, out cube int) as $$

	select x*x,x*x*x

$$ language sql


select square_n_cube(3)

create or replace function new_price(products, increase_percent numeric default 105)
returns double precision as $$
	select $1.unitprice*increase_percent/100;
$$ language sql 


select productname, unitprice, new_price(products.*)
from products

create or replace function square_n_cube (in x int default 10, out aquare int, out cube int) as $$

	select x*x,x*x*x

$$ language sql


select (square_n_cube()).*

select firstname, lastname, hiredate
from newest_hire()

select productname, companyname
from highest_inventory() as hi
join suppliers on hi.supplierid=suppliers.supplierid


create or replace function sold_more_than(total_sales real)
returns setof products as $$
	select * from products
	where productid IN (SELECT productid from (select sum (quantity*unitprice), productid
											  from order_details
											  group by productid
											  having sum (quantity*unitprice) > total_sales
											  ) as qualified_products
						)
$$ language sql

select productname, productid, supplierid
from sold_more_than (25000)

create or replace function next_birthday()
	returns table (birthday date, firstname varchar (10), lastname varchar (20), hiredate date) as $$
	
	select (birthdate +INTERVAL  '1 YEAR' * (EXTRACT(YEAR FROM AGE(birthdate)) +1 ))::date,
	firstname, lastname, hiredate
	from employees
	
$$ language sql

select * from next_birthday()


create or replace function suppliers_to_reorder_from()
returns setof suppliers as $$
select * from suppliers 
where supplierid in (select supplierid from products
					where unitsinstock + unitsonorder < reorderlevel)		
$$ LANGUAGE sql


select * from suppliers_to_reorder_from();

create or replace procedure add_em (x int, y int) as $$

select x+y

$$ language sql


call add_em(5,10)

create or replace procedure change_supplier_prices(in suppid smallint, in amount real) as $$

update products
set unitprice = unitprice + amount
 where supplierid = $1

$$ language sql

call change_supplier_prices(20::smallint, 0.5)

-----------------------Transacctions-----------------------

start transaction ;

update products
set reorderlevel = reorderlevel - 5;


select count(*)
from products
where unitsinstock + unitsonorder <reorderlevel;

commit;

start transaction ;

 update orders
 set requireddate = requireddate + INTERVAL '1 DAY'
 WHERE orderdate BETWEEN '2017-12-01' and '2017-12-31';
 
update orders
 set requireddate = requireddate - INTERVAL '1 DAY'
 WHERE orderdate BETWEEN '2017-11-01' and '2017-11-30';
 
 commit;
 

 ----------------------PL/PGSQL------------------------

 create or replace function biggest_order() returns double precision as $$
begin 
	return max(amount) from
(select sum(unitprice*quantity) as amount, orderid 
  from order_details

group by orderid
) as totals ;
end;
$$ language plpgsql

select * from biggest_order()

CREATE OR REPLACE FUNCTION sum_n_product(x integer, y integer, out sum int, out product int) as $$


begin 
	sum := x +y;
	product := x*y;
	return;
	
end;
$$ language plpgsql;


select (sum_n_products(5,20)).*;


drop routine if EXISTS square_n_cube();

create or replace function square_n_cube
(in x int, out square int, out cube int) as $$
begin
	square :=x*x;
	cube := x*x*x;
	return;
end
$$ language plpgsql


select (square_n_cube(9)).*;


create or replace function sold_more_than (total_sales real)
returns setof products as $$
BEGIN
	return query select * from products
	where productid in (
	select productid from
	(select sum(quantity*unitprice), productid
	from order_details
	group by productid
	having sum (quantity*unitprice) > total_sales) as qualified_products
	);
	
END;
$$ language plpgsql;

select (sold_more_than(25000)).*;



create or replace function suppliers_to_reorder_from ()
returns setof suppliers as $$
BEGIN
	return query select * from suppliers
	where supplierid in (
	select supplierid from products
	where unitsinstock + unitsonorder < reorderlevel
	);
	
END;
$$ language plpgsql;

select * from suppliers_to_reorder_from()


create or replace function middle_priced ()
returns setof products as $$
declare

	average_price real;
	bottom_price real;
	top_price real;
	
BEGIN
	select avg(unitprice)into average_price from products;
	bottom_price := average_price * 0.75;
	top_price := average_price * 1.25;
	
	return query select * from products
	where unitprice between bottom_price and top_price;
	
END;
$$ language plpgsql;


select * from middle_priced()





CREATE OR REPLACE FUNCTION normal_orders() RETURNS SETOF orders AS $$

	DECLARE
		average_order_amount real;
		bottom_order_amount real;
		top_order_amount real;
	BEGIN
		SELECT AVG(amount_ordered) INTO average_order_amount FROM
		( SELECT SUM(unitprice*quantity) AS amount_ordered,orderid
		  FROM order_details
		  GROUP BY orderid) as order_totals;

		 bottom_order_amount := average_order_amount * 0.75;
		 top_order_amount := average_order_amount * 1.30;

		 RETURN QUERY SELECT * FROM orders WHERE
		 orderid IN (
			 SELECT orderid FROM
			(SELECT SUM(unitprice*quantity),orderid
		  	FROM order_details
		  	GROUP BY orderid
			HAVING SUM(unitprice*quantity) BETWEEN bottom_order_amount AND top_order_amount) AS order_amount
		 );
	END;
$$ LANGUAGE plpgsql;



select * from normal_orders()

CREATE OR REPLACE FUNCTION product_price_category(price real) RETURNS text AS $$
BEGIN

	IF price > 50.0 THEN
		RETURN 'Luxury';
	ELSIF price > 25.0 THEN
		RETURN 'Consumer';
	ELSE
		RETURN 'Bargain';
	END IF;
END;
$$ LANGUAGE plpgsql;


SELECT  product_price_category(unitprice),*
FROM products;



CREATE OR REPLACE FUNCTION time_of_year(date_to_check timestamp) RETURNS text AS $$

DECLARE
	month_of_year int := EXTRACT(MONTH FROM date_to_check);
BEGIN

	IF month_of_year >=3 AND month_of_year <=5 THEN
		RETURN 'Spring';
	ELSIF month_of_year >= 6 AND month_of_year <=8 THEN
		RETURN 'Summer';
	ELSIF month_of_year >= 9 AND month_of_year <=11 THEN
		RETURN 'Fall';
	ELSE
		RETURN 'Winter';
	END IF;
END;
$$ LANGUAGE plpgsql;

SELECT  time_of_year(orderdate),*
FROM orders;

CREATE OR REPLACE FUNCTION factorial(x float) RETURNS float AS $$
DECLARE
	current_x float := x;
	running_multiplication float := 1;
BEGIN
	LOOP
		running_multiplication := running_multiplication * current_x;

		current_x := current_x - 1;
		EXIT WHEN current_x <= 0;
	END LOOP;

	RETURN running_multiplication;

END;
$$ LANGUAGE plpgsql;

SELECT factorial(13::float);

CREATE OR REPLACE FUNCTION factorial(x float) RETURNS float AS $$
DECLARE
	current_x float := x;
	running_multiplication float := 1;
BEGIN
	WHILE current_x > 0 LOOP
		running_multiplication := running_multiplication * current_x;

		current_x := current_x - 1;
	END LOOP;

	RETURN running_multiplication;

END;
$$ LANGUAGE plpgsql;

---------------------------TRIGGERS--------------------------

alter table products
add column last_updated timestamp;

--------- Crear funion que llama al trigger----------

create or replace function products_timestamp() returns trigger as $$

begin

new.last_updated := now();
return new;

end;

$$ language plpgsql;

----------------Crear el trigger-----------------

create or replace trigger products_timestamp before insert or update on products
for each row execute function products_timestamp();


update products
set productname='Chai'
where productid = 1;


select last_updated, * from products
where productid = 1;

------------------------------------------------------------------------------
11 Fevriér
------------------------------------------------------------------------------

create table order_details_audit(
	operation char(1) not null,
	userid text not null,
	stamp timestamp not null,
	orderid smallint NOT NULL,
    productid smallint NOT NULL,
    unitprice real NOT NULL,
    quantity smallint NOT NULL,
    discount real				
								
)

create or replace function audit_order_details() returns trigger as $$

BEGIN
if 		(tg_op='DELETE') THEN
	 	insert into order_details_audit
	 	select 'D', user, now (),o.* from old_table o;
	 elsif
	 	(tg_op='UPDATE') THEN
	 	insert into order_details_audit
		 select 'U', user, now (),o.* from new_table o;
	 elsif
	 	(tg_op='INSERT') THEN
	 	insert into order_details_audit
	 	select 'I', user, now (),o.* from new_table o;
	 end if;
	 RETURN null;
END;
$$ LANGUAGE plpgsql



DROP TRIGGER IF EXISTS audit_order_details_insert on order_details;

create trigger audit_order_details_insert 
after insert on order_details
referencing new table as new_table
for each statement execute function audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_update on order_details;

create trigger audit_order_details_update 
after update on order_details
referencing new table as new_table
for each statement execute function audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_delete on order_details;

create trigger audit_order_details_delete 
after delete on order_details
referencing old table as old_table
for each statement execute function audit_order_details();


insert into order_details
values (10248, 3, 10,5,0)

select * from order_details_audit;

delete from order_details

where orderid =10248 and productid =3;

create table order_details_audit(
	operation char(1) not null,
	userid text not null,
	stamp timestamp not null,
	orderid smallint NOT NULL,
    productid smallint NOT NULL,
    unitprice real NOT NULL,
    quantity smallint NOT NULL,
    discount real				
								
)

create or replace function audit_order_details() returns trigger as $$

BEGIN
if 		(tg_op='DELETE') THEN
	 	insert into order_details_audit
	 	select 'D', user, now (),o.* from old_table o;
	 elsif
	 	(tg_op='UPDATE') THEN
	 	insert into order_details_audit
		 select 'U', user, now (),o.* from new_table o;
	 elsif
	 	(tg_op='INSERT') THEN
	 	insert into order_details_audit
	 	select 'I', user, now (),o.* from new_table o;
	 end if;
	 RETURN null;
END;
$$ LANGUAGE plpgsql



DROP TRIGGER IF EXISTS audit_order_details_insert on order_details;

create trigger audit_order_details_insert 
after insert on order_details
referencing new table as new_table
for each statement execute function audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_update on order_details;

create trigger audit_order_details_update 
after update on order_details
referencing new table as new_table
for each statement execute function audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_delete on order_details;

create trigger audit_order_details_delete 
after delete on order_details
referencing old table as old_table
for each statement execute function audit_order_details();


insert into order_details
values (10248, 3, 10,5,0)

select * from order_details_audit;

delete from order_details

where orderid =10248 and productid =3;

CREATE ROLE accounting NOCREATEDB NOLOGIN NOSUPERUSER;
CREATE ROLE hr NOCREATEDB NOLOGIN NOSUPERUSER;

CREATE ROLE suzy NOCREATEDB LOGIN NOSUPERUSER PASSWORD 'pass123';
CREATE USER bobby NOCREATEDB LOGIN NOSUPERUSER PASSWORD 'pass123';


REVOKE ALL ON DATABASE northwind FROM public;

GRANT  accounting TO suzy;
GRANT  hr TO bobby;


CREATE ROLE sales NOCREATEDB NOLOGIN NOSUPERUSER;
CREATE ROLE jill NOCREATEDB LOGIN NOSUPERUSER PASSWORD 'pass123';
GRANT  sales TO jill;


GRANT CONNECT ON DATABASE northwind TO accounting;
GRANT CONNECT ON DATABASE northwind TO hr;

