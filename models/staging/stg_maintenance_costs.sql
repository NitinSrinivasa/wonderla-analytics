select *
from {{ source('park_internal', 'maintenance_costs') }}