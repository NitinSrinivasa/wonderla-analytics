select
    cost_id,
    ride_id,
    date as cost_date,
    'electricity' as cost_type,
    electricity_cost as cost_amount
from {{ ref('stg_electricity_costs') }}

union all

select
    cost_id,
    ride_id,
    date as cost_date,
    'maintenance' as cost_type,
    total_cost as cost_amount
from {{ ref('stg_maintenance_costs') }}

union all

select
    cost_id,
    ride_id,
    date as cost_date,
    'supplies' as cost_type,
    supplies_cost as cost_amount
from {{ ref('stg_supplies_costs') }}

union all

select
    cost_id,
    ride_id,
    date as cost_date,
    'staff' as cost_type,
    staff_cost as cost_amount
from {{ ref('stg_staff_costs') }}