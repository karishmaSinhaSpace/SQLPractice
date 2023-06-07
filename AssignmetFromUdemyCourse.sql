# we will need a list of all staff members including thier first and last names, email address, and the store identification number where they work
use mavenmovies;
select * from staff;
select first_name, last_name, email, store_id
from staff;	


# we will need seperate counts of inventory items held at each of your two stores
select * from inventory;


select store_id, count(inventory_id) as total_inventory
from inventory
group by store_id;


# we will need a count of active customers for each of your stores, Seperately please

select store_id, count(customer_id) as active_customers
from customer
where active = 1
group by store_id;

# in order to assess the liablity of a data breach, we will need you to provide a count of all customer email addresses stored in the database
select count(email) as count_of_emails
from customer;

/* we are intrested in how diverse your film offering is a means of understanding how likely you are to keep customers engaged in the future. 
please provide a count of unique film titles you have in inventroy at each store and then provide a count of the unique categories of films you provide.*/

select store_id, count(distinct film_id) as unique_films
from inventory
group by store_id;



/* we whould like you to understand the replacement cost of your films. please provide the replacement cost for the film that is 
least expensive to replace, the most expensive to replace, and the average of all films you carry */

select min(replacement_cost) as least_expensive,
max(replacement_cost) as most_expensive,
avg(replacement_cost) as average_of_all_films
from film;



/* we are intrested in having you put payment monitoring systems and maximum payment precessing restrictions in place in order to minimise 
the future risk of fraud by your staff. plase provide the average payment you process, as well as the maximum payment you have processed */

select max(amount) as maximum_payment_processed,
avg(amount) as agerage_payment_proessed
from payment;

/* we wholud like to better understand what your customer base looks like. please provide a list of all customer identification
values, with a count of rentals they have made all time, with your highest volume customers at the top of the list*/

select customer_id, count(rental_id) as count_of_rentals
from rental
group by customer_id
order by count(rental_id) desc;




