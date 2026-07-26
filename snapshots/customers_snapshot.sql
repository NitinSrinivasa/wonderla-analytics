{% snapshot customers_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='check',
        check_cols=[
            'city',
            'state',
            'is_vip_member',
            'marketing_opt_in',
            'preferred_thrill_level',
            'loyalty_points'
        ],
        invalidate_hard_deletes=True
    )
}}

select
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
    updated_at
from {{ ref('stg_customers') }}

{% endsnapshot %}