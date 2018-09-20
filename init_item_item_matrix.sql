WITH matrix AS (
  SELECT u.id AS u_id, 
         v.id as v_id, 
         array_length(v.like_user_ids & u.like_user_ids, 1) / array_length(u.like_user_ids | v.like_user_ids, 1)::float AS sim_score 
    FROM movies AS u, 
         movies AS v 
   WHERE u.id > v.id AND v.like_user_ids && u.like_user_ids
), matrix_trim AS (
  SELECT u_id, v_id, sim_score FROM (
    SELECT u_id,
           v_id,
           sim_score,
           row_number() OVER (partition by u_id ORDER BY sim_score desc) AS row_num
      FROM matrix 
     WHERE sim_score > 0.01
  ) AS tmp WHERE row_num <= 10
)

INSERT INTO item_item_matrix 
(
  SELECT u_id, v_id, sim_score FROM matrix_trim 
  UNION 
  SELECT v_id AS u_id, u_id AS v_id, sim_score FROM matrix_trim
) 
ON CONFLICT (u_id, v_id) DO UPDATE SET sim_score = excluded.sim_score;