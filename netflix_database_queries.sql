--Schema--
Drop Table if exists netflix;
Create Table netflix
(
	show_id	Varchar(5),
	type    Varchar(10),
	title	Varchar(250),
	director Varchar(550),
	casts	Varchar(1050),
	country	Varchar(550),
	date_added	Varchar(55),
	release_year	Int,
	rating	Varchar(15),
	duration	Varchar(15),
	listed_in	Varchar(250),
	description Varchar(550)
);

--Copying the data from csv file--
copy netflix (
  show_id, type, title, director, casts, country,
  date_added, release_year, rating, duration, listed_in, description
)
From 'D:/Netflix Database project/netflix_titles.csv' --add path to where you saved csv file.--
CSV HEADER;

--Count the number of Movies vs TV Shows--
Select
Count(Case when type ='Movie' then 1 End) as Number_of_Movies,
Count(Case when type = 'TV Show' then 1 End) as Number_of_TV_Shows
From Netflix;

--Find the most common rating for movies and TV shows--
select type,rating from 
(select type,rating, count(*),rank() over (partition by type order by count(*) desc ) as ranking
from netflix 
group by 1,2
)
where ranking = 1;

--List all movies released in a specific year (e.g., 2020)--
Select title,release_year from netflix where release_year = 2020 order by title asc;
1;

--Find the top 5 countries with the most content on Netflix--
Select unnest(string_to_array(country, ',')) as country ,
count(show_id) as total_count 
from netflix
group by 1
order by 2 
limit 5;

--Identify the longest movie--
Select title,duration from(
Select title,duration, rank() over (order by Cast( Split_part(duration, ' ', 1 ) As Integer )Desc) as ranking 
from netflix 
where duration IS NOT NULL
group by duration,title
) where ranking = 1;

--Find content added in the last 5 years--
Select title,duration,release_year from netflix
where release_year between
	(select max(release_year) from netflix)-4
	and
	(select max(release_year) from netflix)
order by release_year desc,title

--Find all the movies/TV shows by director 'Rajiv Chilaka'--
Select title,type,director from netflix where director ILike '%Rajiv Chilaka%';

--List all TV shows with more than 5 seasons--
Select title,type,Number_of_Seasons from(
select title,type, cast (split_part(duration, ' ',1) as Integer) as Number_of_Seasons from netflix where type = 'TV Show'
) as tv
where Number_of_Seasons >5
order by Number_of_Seasons desc;

--Count the number of content items in each genre--
select unnest(string_to_array(listed_in,',')) as genre, count(show_id) as total_content 
from netflix
group by 1;

--Find each year and the average numbers of content release in India on netflix--
select extract (YEAR from To_Date(date_added, 'Month DD YYYY')) as year,count(*) , Round(count(*)::numeric/(select count(*) from netflix where Country = 'India')*100,2) as avg_content
from netflix
where Country = 'India'
group by 1;

select count(*) from netflix where Country = 'India'


--return top 5 year with highest avg content release in india--
select extract (YEAR from To_Date(date_added, 'Month DD YYYY')) as year,count(*) , Round(count(*)::numeric/(select count(*) from netflix where Country = 'India')*100,2) as avg_content
from netflix
group by 1
order by 3 Desc 
Limit 5;

--List all movies that are documentaries--
select title, a from(
select title,unnest(string_to_array(listed_in,',')) as a from netflix
)
where a = 'Documentaries'
order by 1;
--Find all content without a director--
select title,director from netflix where director IsNull;

--Find how many movies actor 'Salman Khan' appeared in last 10 years--
select title,cast_member from (
select title, unnest(string_to_array(casts,',')) as cast_member
from netflix
where type = 'Movie'

) as t1
where cast_member ILike '%Salman Khan%'

--Find the top 10 actors who have appeared in the highest number of movies produced in India.
select unnest(string_to_array(casts,',')) as cast_member,count(*) as total_count
from netflix
where type = 'Movie' and country Ilike '%India%'
group by 1
order by 2 desc
Limit 10;



--Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.--
select
    t1,
	type,
    Count(*) AS content_count from
(select *,case when description ILike '%Kill%' or description ILike '%violence%' then 'Bad' 
			   Else 'Good' 
		  End as t1 
from netflix
) as t2
group by 1,2
order by 2;



