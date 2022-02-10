create database if not exists travelonthegodb;
use travelonthegodb;

drop table if exists passenger;
drop table if exists price;

/*1 Create Tables*/
create table passenger(
passenger_name varchar(250),
cateogry varchar(10),
gender varchar(2),
boarding_city varchar(100),
destination_city varchar(100),
distance int,
bus_type varchar(15)
);

create table price(
bus_type varchar(15),
distance int,
price int
);

/*2 insert into Tables*/

insert into passenger values ('Sejal', 'AC' ,'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into passenger values ('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
insert into passenger values ('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600 ,'Sleeper');
insert into passenger values ('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into passenger values ('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper');
insert into passenger values ('Ankur', 'AC', 'M', 'Nagpur' ,'Hyderabad',500, 'Sitting');
insert into passenger values ('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 700 ,'Sleeper');
insert into passenger values ('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
insert into passenger values ('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700 ,'Sitting');

insert into price values ('Sleeper', 350, 770  );
insert into price values ('Sleeper', 500 ,1100 );
insert into price values ('Sleeper', 600 ,1320 );
insert into price values ('Sleeper', 700 ,1540 );
insert into price values ('Sleeper', 1000 ,2200);
insert into price values ('Sleeper', 1200 ,2640);
insert into price values ('Sleeper', 1500 ,2700);
insert into price values ('Sitting', 500 ,620  );
insert into price values ('Sitting', 600 ,744  );
insert into price values ('Sitting', 700 ,868  );
insert into price values ('Sitting', 1000 ,1240);
insert into price values ('Sitting', 1200 ,1488);
insert into price values ('Sitting', 1500 ,1860);

/*Queries*/

select * from passenger;
select * from price;

/*3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?*/
select gender, count(1) as count from passenger where distance >= 600 group by gender;

/*4) Find the minimum ticket price for Sleeper Bus*/
select min(price) as minimum_price from price where bus_type = 'Sleeper';

/*5) Select passenger names whose names start with character 'S'*/
select passenger_name from passenger where passenger_name like 'S%';

/*6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/
select p.passenger_name as 'Passenger Name', p.boarding_city as 'Boarding City', p.destination_city as 'Destination City',
 p.bus_type as 'Bus type', pr.price as 'Price'
from passenger p
left join price pr on p.bus_type = pr.bus_type and p.distance = pr.distance;

/*7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s*/
select p.passenger_name as 'Passenger Name', p.boarding_city as 'Boarding City', p.destination_city as 'Destination City',
 p.bus_type as 'Bus type', pr.price as 'Price'
from passenger p
left join price pr on p.bus_type = pr.bus_type and p.distance = pr.distance
where p.bus_type = 'Sitting' and p.distance = 1000;

/*8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/
select bus_type as 'Bus Type', price as 'Price' from price where distance = (
select distance from passenger 
where (boarding_city = 'Panaji' and destination_city = 'Bengaluru')
or (boarding_city = 'Bengaluru' and destination_city = 'Panaji')) ;

/*9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.*/
select distinct distance from passenger order by distance desc;

/*10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/
SELECT passenger_name as 'Passenger Name', distance * 100 / pr.total as '% distance travelled'
FROM passenger
CROSS JOIN (SELECT SUM(distance) AS total FROM passenger) pr;

/*11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/
select bus_type, distance, price,
case  
	when price>1000 then 'Expensive'
    when price>500 then 'Average Cost'
    else 'Cheap'
end category
from price;