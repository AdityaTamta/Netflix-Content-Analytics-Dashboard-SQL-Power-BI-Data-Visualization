# Netflix-Content-Analytics-Dashboard-SQL-Power-BI-Data-Visualization
This project explores and analyzes Netflix’s public dataset using advanced SQL queries and visualizes key insights using Power BI dashboards. It answers business-relevant questions such as content trends, director/actor analysis, genre popularity, and content quality flags using keyword classification.

Objectives
1.Clean, filter, and transform Netflix content data using SQL

2.Perform in-depth analysis across multiple dimensions: country, release year, genre, rating, duration, cast

3.Build an interactive Power BI dashboard with filters, KPIs, and trend analysis

4.Identify top actors, longest content, most common genres, and keyword-based content categorization

Key Features & Queries
1. Count the number of Movies vs TV Shows
2. Find the most common rating for movies and TV shows
3. List all movies released in a specific year (e.g., 2020)
4. Find the top 5 countries with the most content on Netflix
5. Identify the longest movie
6. Find content added in the last 5 years
7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
8. List all TV shows with more than 5 seasons
9. Count the number of content items in each genre
10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!
11. List all movies that are documentaries
12. Find all content without a director
13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
15.
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.

16.KPI cards and slicers in Power BI for year, genre, type, and country

How to Run
1.Load netflix_titles.csv into a PostgreSQL database

2.Run the cleaning and transformation SQL scripts from /sql_queries

3.Connect Power BI to the cleaned tables/views or load the exported .csv

4.Explore KPIs, filters, and visualizations in powerbi_dashboard.pbix
