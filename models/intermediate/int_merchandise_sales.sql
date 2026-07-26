select
    sale_id,
    customer_id,
    product_id,
    product_name,
    category,
    quantity,
    unit_price,
    total_price,
    discount_applied,
    payment_method,
    sale_date,
    sale_timestamp,
    ride_id,
    staff_member,
    created_at,
    updated_at,
    'online' as source_table
from {{ ref('stg_merchandise_sales_online') }}

union all

select
    sale_id,
    customer_id,
    product_id,
    product_name,
    category,
    quantity,
    unit_price,
    total_price,
    discount_applied,
    payment_method,
    sale_date,
    sale_timestamp,
    ride_id,
    staff_member,
    created_at,
    updated_at,
    'physical' as source_table
from {{ ref('stg_merchandise_sales_physical') }}