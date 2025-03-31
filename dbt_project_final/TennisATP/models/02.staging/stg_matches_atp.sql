{{ config(materialized='view') }}

SELECT tourney_id,
       tourney_name,
       surface,
       draw_size,
       tourney_level,
       tourney_date,
       match_num,

       winner_id,
       winner_name,
       winner_hand,
       winner_ioc,
       winner_age,

       loser_id,
       loser_name,
       loser_hand,
       loser_ioc,
       loser_age,

       score,
       best_of,
       round,

       minutes,

       w_ace,
       w_svpt,
       w_1st_won,
       w_2nd_won,
       w_bp_saved,
       w_bp_faced,

       l_ace,
       l_svpt,
       l_1st_won,
       l_2nd_won,
       l_bp_saved,
       l_bp_faced,

       winner_rank,
       loser_rank

FROM {{ ref('matches_atp') }}