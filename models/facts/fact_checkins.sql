-- fact_checkins.sql
select *
from {{ ref('stg_checkins') }}