select
    dbt_scd_id as customer_version_key,
    customer_id,
    first_name,
    last_name,
    email,
    city,
    state,
    age,
    gender,
    is_vip_member,
    marketing_opt_in,
    preferred_thrill_level,
    loyalty_points,
    registration_date,
    dbt_valid_from,
    dbt_valid_to,
    dbt_valid_to is null as is_current
from {{ ref('customers_snapshot') }}