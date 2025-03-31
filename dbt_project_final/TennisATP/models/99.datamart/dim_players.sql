{{ config(materialized='table') }}

WITH winners as (
    select winner_id as player_id, winner_name as player_name
    FROM {{ ref('enriched_matches_atp') }}
),
losers as (
    select loser_id as player_id, loser_name as player_name
    FROM {{ ref('enriched_matches_atp') }}
), all_players as (
    select * from winners
    union
    select * from losers
)

select distinct
    player_id,
    player_name
from all_players