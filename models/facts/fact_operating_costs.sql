-- fact_operating_costs.sql
select *
from {{ ref('int_operating_costs') }}