--LAB WORK 4
--Yerzhanov Abylay

--1.Write a SQL query using Joins:
--a)Combine each row of dealer table with each row of client table
SELECT * FROM dealer
INNER JOIN client on dealer.id = client.dealer_id

--b) find all dealers along with client name, city, grade, sell number, date, and amount
SELECT client.dealer_id, client.name, client.city,client.priority,sell.id,sell.date,sell.amount
FROM client INNER JOIN sell on client.id = sell.client_id

--c) find the dealer and client who belongs to same city
SELECT dealer.name,client.name FROM dealer 
CROSS JOIN client WHERE dealer.location = client.city

--d) find sell id, amount, client name, city those sells where sell amount exists between100 and 500
SELECT sell.id,sell.amount,client.name,client.city FROM sell
INNER JOIN client  on sell.client_id = client.id WHERE amount > 100 AND amount < 500

--e)find dealers who works either for one or more client or not yet join under any of the clients
SELECT dealer.name as dealer_name,count(client.id) as number_of_clients FROM dealer
LEFT JOIN client on dealer.id = client.dealer_id group by dealer.name

--f)find the dealers and the clients he service, return client name, city, dealer name,commission.

SELECT client.name, client.city,dealer.name,dealer.charge
FROM dealer
INNER JOIN client on dealer.id = client.dealer_id

--g)find client name, client city, dealer, commission those dealers who received a commission from the sell more than 12%
SELECT client.name,client.city,dealer.name,dealer.charge
FROM client
INNER JOIN dealer on dealer.id = client.dealer_id
where dealer.charge > 0.12

--h) make a report with client name, city, sell id, sell date, sell amount, dealer name and commission to find that either any of the existing clients haven’t made a purchase(sell) or made one or more purchase(sell) by their dealer or by own.
SELECT client.name,client.city,sell.id,sell.date,sell.amount, dealer.name,dealer.charge
FROM dealer
INNER JOIN client  on dealer.id = client.dealer_id
INNER JOIN sell  on client.id = sell.client_id

--i)
SELECT sell.client_id, client.name, client.priority, dealer.name,sell.id,sell.amount
FROM sell
INNER JOIN client on sell.client_id = client.id 
INNER JOIN dealer on sell.dealer_id = dealer.id
WHERE priority is not Null
group by sell.client_id, client.name, client.priority, dealer.name, sell.id
having sum(Amount) > 2000

--2.Create following views:
--a) count the number of unique clients, compute average and total purchase amount of client orders by each date.
CREATE view total_average(date,total)
AS
SELECT date,count(id) FROM sell group by date
SELECT total_average.date,total, avg(total)
FROM sell,total_average
group by total_average.date,total

--b) find top 5 dates with the greatest total sell amount
CREATE view greatest_amount(date,sum)
AS
    SELECT date,sum(amount)
    FROM sell
    group by date
    order by sum(amount) DESC
    LIMIT 5
SELECT *
FROM greatest_amount

--c) count the number of sales, compute average and total amount of allsales of each dealer
CREATE view tot_avg_dealer(dealer_id,total)
AS
    SELECT dealer_id,count(id)
FROM sell
group by dealer_id
SELECT dealer_id,total,avg(total)
FROM tot_avg_dealer
group by dealer_id, total

--d)compute how much all dealers earned from charge(total sell amount *charge) in each location
CREATE view dealers_earned(location,earned)
as
    SELECT location,sum(amount*dealer.charge) FROM dealer,sell group by location
SELECT * FROM dealers_earned

--e) compute number of sales, average and total amount of all sales dealers made in each location
CREATE view avg_tot_location(location,total,avg) 
as
    SELECT dealer.location,sum(sell.amount),avg(amount) FROM dealer,sell
    where dealer.id = sell.dealer_id group by dealer.location
SELECT * FROM avg_tot_location

--f) compute number of sales, average and total amount of expenses in each city clients made.
CREATE view avg_tot_client(city,total,avg)
as
    SELECT client.city,sum(amount),avg(amount)
    FROM client,sell
    WHERE client.id = sell.client_id
    group by client.city
SELECT * FROM avg_tot_client

--g) find cities where total expenses more than total amount of sales in locations
SELECT city,avg_tot_client.total,avg_tot_location.total
FROM avg_tot_client
full outer join avg_tot_location on city = location
WHERE avg_tot_client.total > avg_tot_location.total

-- -- -- -- -- -- -- -- -- -- -- --
drop view total_average
drop view greatest_amount
drop view tot_avg_dealer
drop view dealers_earned
drop view avg_tot_location
drop view avg_tot_client