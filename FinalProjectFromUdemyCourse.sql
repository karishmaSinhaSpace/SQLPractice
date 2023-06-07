/* 
THE SITUATION
You and your business partner were recently approached by another local business owner who is intrested in purchasing mavenmovies. 
He primarily ownes restraunts and bars so he have lots of questions for you about your business and rental business in general his offer seems very 
generous, so you are going to entertain the questions
*/

/* 
My partner and I want to come by each of the stores in person and meet the managers. Please send over manager's name at each store, 
with the full address of each property(street address, district, city and coutry please) 
*/
use mavenmovies;
select 
A.first_name as manager_first_name, 
A.last_name as manager_last_name, 
B.address, 
C.city, 
D.country
from staff as A
left join address as B on A.address_id = B.address_id
left join city as C on B.city_id = C.city_id
left join country as D on C.country_id = D.country_id;



/*
I whould like to get a better understanding of all of the inventory that whould come along with the business.
Please pull togther a list of each inventory item you have stoked, including the store_id number, the inventory_id, the name of the film,
the films rating, it's rental rate and replacement cost.
*/

select A.store_id, A.inventory_id, B.title, B.rating, B.rental_rate, B.replacement_cost
from inventory as A
left join film as B
on A.film_id = B.film_id;



/* 
From the same list of films you just pulled, please roll that data up  and provide a summary level overview of your inventory.
We whould like to know how many inventory items you have with each rating at each store.
*/

select A.store_id, B.rating, count(inventory_id) as inventory_items
from inventory as A
left join film as B
on A.film_id = B.film_id
group by A.store_id, B.rating;



/*
Similarly we want to understand how diversified the inventory is in terms of replacement cost. We want to see how big of a hit it would be if
a certain category of film became unpopular at a certain store. We wholud like to see the number of films, as well as the average replacement cost 
and total replacement cost, sliced by store and film category.
*/

select A.store_id, count(A.inventory_id) as number_of_films, B.name as category, avg(C.replacement_cost) as avg_replacement_cost, sum(C.replacement_cost) as total_replacement_cost
from inventory as A
left join film as C on A.film_id = C.film_id
left join film_category as D on C.film_id = D.film_id
left join category as B on D.category_id = B.category_id
group by A.store_id, B.name ;



/* 
We want to make sure you folks have good handle on who your customers are? Please provide a list of all customer names, which store they go to 
wheather or not they are currently active, and their full address, city and country.
*/

select A.first_name, A.last_name, A.store_id, A.active, B.address, C.city, D.country
from customer as A
left join address as B on A.address_id = B.address_id
left join city as C on B.city_id = C.city_id
left join country as D on C.country_id = D.country_id;



/* 
We whould like to understand how much your customers are spending with you, and also to know who your most valuable customers are? Please pull together a 
list of customers names, their total lifetime rentals, and the sum of all payments you have collected from them. It whould be grate to see this ordered on 
total lifetime value, with the most valuable customers at the top of the list
*/

select A.first_name, A.last_name, count(B.rental_id) as total_rental, sum(B.amount) as total_payment_amount
from customer as A
left join  payment as B on A.customer_id = B.customer_id
group by A.first_name, A.last_name
order by sum(B.amount) desc;



/*
My partner and I whould like to get to know your board of advisors and any current investors? Could you please provide a list of advisors 
and investors in one table? Could you please note wheather they are an investor or an advisor and for the investors it wholud be good to include which
company they work with
*/

select 'Advisor' as Type, first_name, last_name, 'N/A' as company_name
from advisor
union
select 'Investor' as Type, first_name, last_name, company_name
from investor;



/*
We are intrested in how well you have coverd the most-awarded actors. Of all actors with three types of awards, for what % of them do we carry a film?
and how about for actors with three types of awards ? same questions. finally how about actors with just one award
*/

select 
case 
when actor_award.awards = 'Emmy, Oscar, Tony' then '3 Awards'
when actor_award.awards in('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') then '2 Awards'
else '1 Award'
end as number_of_awards
avg(case when actor_award.actor_id is null then 0 else 1 end) as pct_w_one_film
from actor_award
group by
case
when actor_award.awards = 'Emmy, Oscar, Tony' then '3 Awards'
when actor_award.awards in('Emmy, Oscar','Emmy, Tony', 'Oscar, Tony') then '2 Awards'
else '1 Award'
end;







