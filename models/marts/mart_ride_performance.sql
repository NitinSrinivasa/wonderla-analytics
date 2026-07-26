select
    ride_id,
    count(*) as total_checkins,
    avg(actual_wait_minutes) as avg_wait_minutes,
    avg(estimated_wait_minutes) as avg_estimated_wait_minutes
from {{ ref('fact_checkins') }}
group by ride_id