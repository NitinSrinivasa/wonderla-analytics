select
    try_to_number(to_varchar(weather_id)) as weather_id,
    try_to_date(to_varchar(date)) as weather_date,
    try_to_number(to_varchar(month_number)) as month_number,
    season,
    weather_type,
    try_to_decimal(to_varchar(temperature_c), 8, 2) as temperature_c,
    try_to_decimal(to_varchar(rainfall_mm), 8, 2) as rainfall_mm,
    try_to_decimal(to_varchar(humidity_pct), 8, 2) as humidity_pct,
    try_to_boolean(to_varchar(is_park_open)) as is_park_open,
    created_at,
    updated_at
from {{ source('park_assets', 'weather_data') }}