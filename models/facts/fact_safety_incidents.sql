-- fact_safety_incidents.sql
select *
from {{ ref('stg_safety_incidents') }}