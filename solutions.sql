use sakila;

-- consulta 1
-- escribe una consulta para mostrar para cada tienda su id de tienda, ciudad y país.


select s.store_id, c.city, co.country
from store as s
join address as a on s.address_id = a.address_id
join city as c on a.city_id = c.city_id
join country as co on c.country_id = co.country_id;


-- consulta 2
-- escribe una consulta para mostrar cuánto negocio, en dólares, trajo cada tienda.

select s.store_id, sum(p.amount) as total_revenue
from payment as p
join rental as r on p.rental_id = r.rental_id
join inventory as i on r.inventory_id = i.inventory_id
join store as s on i.store_id = s.store_id
group by s.store_id;

-- consulta 3
-- ¿cuál es el tiempo de ejecución promedio de las películas por categoría?

select c.name as category_name, avg(f.length) as average_length
from film as f
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id
group by c.name;

-- consulta 4
-- ¿qué categorías de películas son las más largas?

select c.name as category_name, max(f.length) as max_length
from film as f
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id
group by c.name
order by max_length desc;

-- consulta 5
-- muestra las películas más alquiladas en orden descendente.

select f.title, count(r.rental_id) as rental_count
from film as f
join inventory as i on f.film_id = i.film_id
join rental as r on i.inventory_id = r.inventory_id
group by f.title
order by rental_count desc;

-- consulta 6
-- enumera los cinco principales géneros en ingresos brutos en orden descendente.

select c.name as category_name, sum(p.amount) as total_revenue
from payment as p
join rental as r on p.rental_id = r.rental_id
join inventory as i on r.inventory_id = i.inventory_id
join film as f on i.film_id = f.film_id
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id
group by c.name
order by total_revenue desc
limit 5;

-- consulta 7
-- ¿está "academy dinosaur" disponible para alquilar en la tienda 1?

select f.title, i.inventory_id
from inventory as i
join film as f on i.film_id = f.film_id
where f.title = 'academy dinosaur' and i.store_id = 1 and i.inventory_id not in (
    select r.inventory_id
    from rental as r
    where r.return_date is null
);
