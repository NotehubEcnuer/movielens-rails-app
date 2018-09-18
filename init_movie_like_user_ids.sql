WITH avg_rating_per_user AS ( 
  SELECT movie_id, 
         user_id, 
         rating,
         AVG(rating) OVER (PARTITION BY user_id) AS avg_rating 
    FROM ratings
),
rating_per_movie AS (
  SELECT movie_id, 
         array_agg(user_id) AS like_user_ids
    FROM avg_rating_per_user
   WHERE rating > avg_rating 
GROUP BY movie_id
)

UPDATE movies AS m 
   SET like_user_ids = r.like_user_ids
  FROM rating_per_movie AS r
 WHERE r.movie_id = m.id;