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


--count the no of content in each genre
select * from netflix


select 
	unnest(string_to_array(listed_in,',')) as genre,
	count(*)
from netflix
group by genre;

--find each year and the average no of content released on netflix in india
select 
	extract(year from to_date(date_added, 'Month DD,YYYY')) as year,
	count(*) as yearly_content,
	round (
	count(*) :: numeric / (select count(*) from netflix where country = 'India') :: integer * 100
	,2)
	as average
from netflix
where country ilike '%india%'
group by 1


--list all movies that are documentaries
select 
	*
from netflix
where type = 'Movie'
and listed_in ilike '%documentaries%'


--find all the content without a director
select 
	*
from netflix
where director is null

--find all movies that salman khan has appeared in last 10 years
SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;


--find the top 10 actors who appeared in the most movies produced in india
select
	unnest(string_to_array(casts, ',')),
	count(*)
from netflix
where country = 'India'
group by 1
order by count(*) desc
limit 10

-- Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.
with new_table 
as
(
select 
	*,
	case
		when
		description ilike '%kill%'
		or 
		description ilike '%violence%' then 'bad_content'
		else 'good_content'
	end category
from netflix
)

select category,
count(*)
from new_table
group by 1






