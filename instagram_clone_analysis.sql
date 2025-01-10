-- CHALLENGE 1: FIND THE 5 OLDEST USERS
use instagram_clone;
SELECT * FROM USERS ORDER BY created_at LIMIT 5;

-- CHALLENGE 2: what days of the week do most users register on? need info the schedule an ad campgain

CREATE VIEW weekday_data AS 
SELECT date_format(created_at, '%W') as weekday, COUNT(*) as num FROM users GROUP BY weekday;

SELECT * FROM weekday_data;

SELECT weekday FROM weekday_data WHERE num = (SELECT MAX(num) FROM weekday_data);

-- CHALLENGE 3: FIND THE USERS WHO HAVE NEVER POSTED A PHOTO

CREATE VIEW null_table AS
SELECT user_name, image_url FROM users LEFT JOIN photos ON photos.user_id = users.id WHERE image_url IS NULL;

SELECT COUNT(*) FROM null_table;

-- CHALLENGE 4: FIND WHICH USER HAS THE MOST LIKES ON A POST

SELECT * FROM photos;

SELECT * FROM likes;

SELECT user_name, COUNT(*) as num FROM likes 
JOIN photos ON photos.photo_id = likes.post_like_id
JOIN users ON photos.user_id = users.id
GROUP BY post_like_id ORDER BY num DESC;

-- CHALLENGE 5: HOW MANY TIMES DOES THE AVERAGE USER POST?

SELECT COUNT(NULL);

CREATE VIEW post_summary AS 
SELECT user_name, COUNT(image_url) as num_of_posts FROM users 
LEFT JOIN photos ON 
photos.user_id = users.id
GROUP BY user_name;

SELECT AVG(num_of_posts) FROM post_summary;


-- CHALLENGE 6: Find the top 5 most commonly used hashtags

SELECT tag_name, COUNT(*) AS num 
FROM photo_tags 
JOIN tags ON tags.id = photo_tags.tag_id 
GROUP BY tag_name 
ORDER BY num DESC LIMIT 5;

-- CHALLENGE 7: FIND users who have liked every single photo on the site

CREATE VIEW user_num_likes AS
SELECT user_like_id, COUNT(post_like_id) AS num_of_likes FROM likes 
GROUP BY user_like_id;

SELECT id, user_name AS bot_names FROM user_num_likes 
JOIN users ON users.id = user_like_id
WHERE num_of_likes = (SELECT COUNT(*) FROM photos);


SELECT id, user_name FROM likes 
JOIN users ON users.id = user_like_id
GROUP BY user_like_id HAVING COUNT(post_like_id) = (SELECT COUNT(*) FROM photos);


-- CSV files for python graph processing!

-- Challenge One: Create a bar graph that indicates how many users signed up on each weekday.



SELECT DATE_FORMAT(created_at, '%W') AS day_name, COUNT(*) FROM users GROUP BY day_name ORDER BY 
     CASE
          WHEN day_name = 'Sunday' THEN 1
          WHEN day_name = 'Monday' THEN 2
          WHEN day_name = 'Tuesday' THEN 3
          WHEN day_name = 'Wednesday' THEN 4
          WHEN day_name = 'Thursday' THEN 5
          WHEN day_name = 'Friday' THEN 6
          WHEN day_name = 'Saturday' THEN 7
     END ASC;


USE instagram_clone;

SELECT * FROM users;

-- let's create two charts - a pie chart detailing % of users who post x times and a histogram.
CREATE VIEW user_post_count_better AS
SELECT user_id, COUNT(*) AS num_of_posts FROM photos GROUP BY user_id;

SELECT * FROM user_post_count_better;

CREATE VIEW ref_numofUsers AS
SELECT num_of_posts, COUNT(*) AS num_of_users FROM user_post_count_better GROUP BY num_of_posts ORDER BY num_of_posts;

-- CREATE VIEW percentage_view AS
SELECT num_of_posts, num_of_users/(SELECT SUM(num_of_users) FROM ref_numofUsers)*100 AS percentage FROM ref_numofUsers;

SELECT SUM(percentage) FROM DANK;
DROP VIEW DANK;
-- CREATE VIEW DANK AS
SELECT num_of_posts, percentage FROM percentage_view WHERE num_of_posts < 6 UNION ALL 
SELECT 6 AS num_of_posts, SUM(percentage) AS percentage FROM percentage_view WHERE num_of_posts >5;
SELECT * FROM DANK;
SELECT @@SESSION.sql_mode;

USE instagram_clone;

SHOW TABLES;

SHOW VARIABLES LIKE 'secure_file_priv';
