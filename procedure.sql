# SQL basic queries
#
# August 5, 2016
#
# Reference to SQL commands: https://www.codecademy.com/articles/sql-commands?r=master
#

#Slectect Statment
 SELECT * FROM table_name;

# Create Statment
  create table table_name(id integer, name text, age integer);

# Insert Statment
  INSERT INTO celebs (id, name, age) VALUES (1, 'Artist Name', 21);

# Update Statment
  UPDATE celebs SET age = 22 WHERE id = 1;

# Change table structure
  ALTER TABLE celebs ADD COLUMN twitter_handle TEXT;

#Delete Statment
  DELETE FROM celebs WHERE twitter_handle IS NULL;

# Selcet distinct values
  SELECT DISTINCT genre FROM movies;

# Select with value
  SELECT * FROM movies WHERE imdb_rating > 8;

# Search for partial values with like
SELECT * FROM movies WHERE name LIKE 'Se_en';
SELECT * FROM movies WHERE name LIKE 'a%';
SELECT * FROM movies WHERE name LIKE '%man%';

# Slelect range of values
SELECT * FROM movies WHERE name BETWEEN 'A' AND 'J';
SELECT * FROM movies WHERE year BETWEEN 1990 AND 2000;

SELECT * FROM `movies` WHERE `genre` = 'comedy' OR `year` < 1980;

SELECT * FROM `movies` ORDER BY `imdb_rating` DESC;

SELECT * FROM `movies` ORDER BY `imdb_rating` ASC LIMIT 3;

# Count
SELECT COUNT(*) FROM `movies`;
SELECT COUNT(*) AS 'total_Horror_movies' FROM `movies` WHERE `genre` = 'horror';
SELECT 'genre', COUNT(*) FROM `movies` FROM `movies` GROUP BY `genre`;

# SUM
SELECT SUM(views) from movies;
SELECT `genre`, SUM(`views`) FROM `movies` GROUP BY `genre`;

# MAX
SELECT MAX(`views`) FROM `movies`;
SELECT `title`, `genre`, MAX(`views`) FROM `movies` GROUP BY `genre`;

# MIN
SELECT MIN(`views`) FROM `movies`;
SELECT `title`, `genre`, MIN(`views`) FROM `movies` GROUP BY `genre`;

#AVG
SELECT `title`, AVG(`revenue`) from `movies` GROUP BY `title`;

# ROUND
SELECT `title`, ROUND(AVG(`revenue`),2) FROM `movies` GROUP BY `title`;

SELECT * FROM `products` WHERE ((`code` LIKE '".$var1."%') OR(`productsName` LIKE '".$var1."%') OR(`description` LIKE '".$var1."%')) ORDER BY 'code';


# Combine data from different tables.
# ** Cross Join **
# Define fields by table name, call all tables separated by commas
# The result of a cross join combines every row of the table1 with every row of the table2.
SELECT albums.name, albums.year, artists.name FROM albums, artists;


# ** Inner Join **
# ** Left Join **
SELECT * FROM `albums` JOIN `artists` ON albums.artist_id = artists.id;

#An inner join will combine rows from different tables if the join condition is true.
SELECT * FROM `albums` LEFT JOIN `artists` ON albums.artist_id = artists.id;


# ** Outer Join
# Outer joins do not require the join condition to be met
SELECT albums.name AS 'Album', albums.year, artists.name AS 'Artist' FROM albums JOIN artists ON albums.artist_id = artists.id WHERE albums.year > 1980;









# Sub Queries

# this query will return a single column  of data.
SELECT code
FROM airports
WHERE elevation > 2000;
# It then can be used to connect with other table as a conditional value

# flights.origin = airports.code
SElECT *
FROM flights
WHERE origin in(
	SELECT code
	FROM airports
	WHERE elevation > 2000
	);

# This query calls the same table twice to create a
# count per week, then return it as and Average
SELECT a.dep_month,
		a.dep_day_of_week,
		AVG(a.flight_count) AS average_flights
FROM (
	SELECT dep_month,
			dep_day_of_week,
			dep_date,
			COUNT(*) AS flight_count
	FROM flights
	GROUP BY 1,2,3
	)a
	GROUP BY 1,2
	ORDER BY 1,2;

# This query calls the same table twice to add the
# distances in a week and return them as Average
ELECT a.dep_month,
       a.dep_day_of_week,
       AVG(a.flight_distance) AS average_distance
  FROM (
        SELECT dep_month,
              dep_day_of_week,
               dep_date,
               SUM(distance) AS flight_distance
          FROM flights
         GROUP BY 1,2,3
       ) a
 GROUP BY 1,2
 ORDER BY 1,2;


# Correlated query
# A row is processed in the outer query.
# Then, for that particular row in the outer query, the subquery is executed.
 SELECT id
 FROM flights AS f
 WHERE distance > (
	 SELECT AVG(distance)
	 FROM flights
	 WHERE carrier = f.carrier
 );

 SELECT carrier,id, (
	 SELECT COUNT(*)
	 FROM flights f
	 WHERE f.id < flights.id
	 AND f.carrier =  flights.carrier
 	) + 1 AS flight_sequence_number
 FROM flights;

 SELECT origin,id, (
	 SELECT COUNT(*)
	 FROM flights f
	 WHERE f.origin = flights.origin
	 AND f.carrier =  flights.carrier
 	) + 1 AS flight_sequence_number
 FROM flights;





#Merge the rows, called a join.

#Merge the columns, called a union

#union
SELECT brand FROM legacy_products
UNION
SELECT brand FROM new_products;

# ALL will allow duplicate results
SELECT brand FROM legacy_products
UNION ALL
SELECT brand FROM new_products;

# INTERSECT is used to combine two SELECT statements,
# but returns rows only from the first SELECT statement
# that are identical to a row in the second SELECT statement
SELECT category FROM new_products
INTERSECT
SELECT category FROM legacy_products;

# EXCEPT returns distinct rows from
# the first SELECT statement that aren’t output by the second SELECT statement.
SELECT category FROM legacy_products
EXCEPT
SELECT category FROM new_products;

# If / Else statements as CASE
SELECT
	CASE
		WHEN elevation < 250 THEN 'Low'
		WHEN elevation BETWEEN 250 AND 1749 THEN 'Medium'
		WHEN elevation >= 1750 THEN 'High'
		ELSE 'Unknown'
	END AS elevation_tier,
	COUNT(*)
FROM airports
GROUP by 1;

SELECT state,
	COUNT(
		CASE
			WHEN elevation >= 2000 THEN 1
			ELSE NULL
		END
	) AS count_high_elevation_airports
FROM airports
GROUP BY state;

SELECT origin,
	100.0*(sum(
				CASE
					WHEN carrier = 'DL' THEN distance
					ELSE 0
				END
			)/sum(distance)
		) as percentage_flight_distance_from_delta
FROM flights
GROUP BY origin;




SELECT
origin,
    100.0*(sum
		(
			CASE
				WHEN carrier = 'UN' THEN distance
				ELSE 0
			END)/sum(distance)
		) as percentage_flight_distance_from_united
FROM flights
GROUP BY origin;





SELECT state,
100.0 * sum(
	CASE
		WHEN elevation >= 2000 THEN 1
		ELSE 0
	END) / count(*)
	  as percentage_high_elevation_airports
FROM airports
GROUP BY state;






select section, count(section) as hits from visitPageTracking group by section order by hits desc;

select * from visitPageTracking left join visittrackinginfo on visitPageTracking.visitTrackingInfoId = visittrackinginfo.auto;
SELECT albums.name AS 'Album', albums.year, artists.name AS 'Artist' FROM albums JOIN artists ON albums.artist_id = artists.id WHERE albums.year > 1980;

select section, count(section) as 'hits' from visitPageTracking
join visittrackinginfo
on visitPageTracking.visitTrackingInfoId = visittrackinginfo.auto
where visittrackinginfo.page = 'index.html'
group by section
order by hits
desc;
