use sakila;

-- Task 1 Display the full name of actor
select concat(first_name, ' ', last_name) as Full_name from actor;

-- Task 2.1 Display the number of time each fist name appears 
select first_name, count(*) as Name_count from actor group by first_name;

-- Task 2.2 Display all unique first names in the database.
select distinct first_name from actor;

-- Task 3.1 Display the number of time each last name appears
select last_name, count(*) as Name_count from actor group by last_name;

-- Task 3.2 Display all unique last names in the database.
select distinct last_name from actor;

-- Task 4.1 Display the list of records for the movies with the rating "R".
select * from film where rating = 'R';

-- Task 4.2 Display the list of records for the movies that are not rated "R".
select * from film where rating != 'R';

-- Task 4.3 Display the list of records for the movies that are suitable for audience below 13 years of age.

select * from film where rating = 'G' or rating = 'PG';

-- Task 5.1 Display the list of records for the movies where the replacement cost is up to $11
select * from film where replacement_cost <= 11.00;

-- Task 5.2 Display the list of records for the movies where the replacement cost is between $11 and $20.
select * from film where replacement_cost between 11.00 and 20.00;

-- Task 5.3 Display the list of records for the all movies in descending order of their replacement costs.
select * from film order by replacement_cost desc;

-- Task 6 Display the names of the top 3 movies with the greatest number of actors.
select film.title, count(actor.actor_id) as num_actors from film
join film_actor on film.film_id = film_actor.film_id
join actor on film_actor.actor_id = actor.actor_id
group by film.title order by num_actors desc limit 3;

-- Task 7 Display the titles of the movies starting with the letters 'K' and 'Q'.   
select title from film where title like 'K%' or title like 'Q%';

-- Task 8 The film 'Agent Truman' has been a great success. Display the names of all actors who appeared in this film.
select concat(first_name, ' ', last_name) as Full_name from actor
join film_actor on actor.actor_id = film_actor.actor_id
join film on film_actor.film_id = film.film_id
where film.title = 'Agent Truman';

-- Task 9 Identify all the movies categorized as family films.
select film.title, category.category_name FROM film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where category.category_name = 'Family';

-- Task 10.1 Display the maximum, minimum, and average rental rates of movies based on their ratings. The output must be sorted in descending order of the average rental rates.
select rating, MAX(rental_rate) as max_rental_rate, MIN(rental_rate) as min_rental_rate, 
avg(rental_rate) as avg_rental_rate from film
group by rating order by avg_rental_rate desc;

-- Task 10.2  Display the movies in descending order of their rental frequencies.
select film.title, COUNT(rental.rental_id) as rental_frequency from film
left join inventory on film.film_id = inventory.film_id
left join rental on inventory.inventory_id = rental.inventory_id
group by film.title order by rental_frequency desc;

-- Task 11.1  In how many film categories, the difference between the average film replacement cost ((disc-DVD/Blue Ray) and the average film rental rate is greater than $15?
select category.category_name from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
group by category.category_name having avg(film.replacement_cost) - avg(film.rental_rate) > 15;


-- Task 11.2  Display the list of all film categories identified above, along with the corresponding average film replacement cost and average film rental rate.
select category.category_name, avg(film.replacement_cost) as avg_replacement_cost, avg(film.rental_rate) as avg_rental_rate,
AVG(replacement_cost) - AVG(rental_rate) AS cost_rental_difference
from category join film_category on category.category_id = film_category.category_id join film on film_category.film_id = film.film_id
group by category.category_name;

-- Task 12   Display the film categories in which the number of movies is greater than 70
select category.category_name from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
group by category.category_name having count(film.film_id) > 70;
