select * from netflix;

--no of movies vs no of tv shows
select
	type, count(*) as total_content
from netflix
group by type;


--max rating given to movies and tv shows
select 
	type,
	rating
from(
select 
	type, rating, count(rating),
	rank() over( partition by type order by count(rating) desc) as ranking
from  netflix
group by 1,2
) as t1
where ranking = 1;

--list all movies released in 2020
select 
	*
from netflix
where
	type = 'Movie'
	and
	release_year = 2020;

--find the top 5 countries with most content on netflix
select 
	unnest(string_to_array(country,',')) as new_country
from netflix;


select 
	unnest(string_to_array(country,',')) as new_country,
	count(*) as total_content
from netflix
group by 1
order by 2 desc
limit 5;


--select the longest movie
SELECT 
    *
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC

--select content which is added in the last 5 years
select current_date - interval '5 years'


select 
	*
from netflix
where to_date(date_added, 'Month DD, YYYY') >= current_date - interval '5 years'


-- find all movies/tv shows by director rajiv chilaka
select 
	type, title, director
from netflix
where director ilike '%Rajiv Chilaka%'




--list all tv shows with more than 5 seasons
SELECT *
FROM netflix
WHERE 
    type = 'TV Show'
    AND split_part(duration, ' ', 1)::int > 5;







