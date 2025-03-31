{{ config(materialized='view') }}

WITH relevant_matches AS (
    SELECT  UUID() AS ID,

            -- DIMENSIONES
            tourney_id,
            tourney_name,
            surface,
            draw_size,
            tourney_level,
            tourney_date AS tourney_date_id,
            CAST(strptime(CAST(tourney_date AS VARCHAR), '%Y%m%d') AS DATE) AS tourney_date,
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
            
            -- METRICAS
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
            loser_rank,
            avg_first_serve_won_winner,
            avg_second_serve_won_winner,
            avg_first_serve_won_loser,
            avg_second_serve_won_loser

    FROM {{ ref('enriched_matches_atp') }}
)

SELECT * FROM relevant_matches