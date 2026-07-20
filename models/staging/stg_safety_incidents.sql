select *
from {{ source('park_internal', 'safety_incidents') }}