select *
from {{ source('park_assets', 'marketing_rides') }}