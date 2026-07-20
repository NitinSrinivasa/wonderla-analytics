select *
from {{ source('park_internal', 'electricity_costs') }}