select *
from {{ source('park_internal', 'supplies_costs') }}