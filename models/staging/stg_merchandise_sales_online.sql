select
    try_to_number(sale_id) as sale_id,
    try_to_number(customer_id) as customer_id,
    try_to_number(product_id) as product_id,
    product_name,
    category,
    try_to_number(quantity) as quantity,
    try_to_decimal(unit_price, 12, 2) as unit_price,
    try_to_decimal(total_price, 12, 2) as total_price,
    try_to_decimal(discount_applied, 12, 2) as discount_applied,
    payment_method,
    try_to_date(sale_date) as sale_date,
    try_to_timestamp_ntz(sale_timestamp) as sale_timestamp,
    try_to_number(haunted_house_id) as ride_id,
    staff_member,
    created_at,
    updated_at
from {{ source('sales', 'merchandise_sales_online') }}