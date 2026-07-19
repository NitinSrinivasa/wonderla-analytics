select
    try_to_number(ride_id) as ride_id,
    ride_name,
    ride_type,
    try_to_number(thrill_level) as thrill_level,
    try_to_number(duration_seconds) as duration_seconds,
    try_to_number(min_height_cm) as min_height_cm,
    try_to_number(max_capacity_per_group) as max_capacity_per_group,
    try_to_number(max_daily_capacity) as max_daily_capacity,
    try_to_boolean(is_water_ride) as is_water_ride,
    park_zone,
    ride_status,
    created_at,
    updated_at
from {{ source('park_assets', 'rides') }}