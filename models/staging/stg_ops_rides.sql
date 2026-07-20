select *
from {{ source('park_assets', 'ops_rides') }}