select
    sale_id,
    customer_id,
    product_id,
    ride_id,
    sale_date,
    source_table,
    quantity,
    unit_price,
    total_price,
    discount_applied
from {{ ref('int_merchandise_sales') }}