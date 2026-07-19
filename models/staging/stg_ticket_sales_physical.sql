select
    try_to_number(to_varchar(sale_id)) as sale_id,
    try_to_number(to_varchar(customer_id)) as customer_id,
    try_to_number(to_varchar(ticket_id)) as ticket_id,
    try_to_decimal(to_varchar(ticket_price), 12, 2) as ticket_price,
    try_to_decimal(to_varchar(discount_percent), 8, 2) as discount_percent,
    payment_method,
    purchase_channel,
    try_to_date(to_varchar(purchase_date)) as purchase_date,
    try_to_timestamp_ntz(to_varchar(purchase_timestamp)) as purchase_timestamp,
    try_to_date(to_varchar(visit_date)) as visit_date,
    try_to_number(to_varchar(visit_hour)) as visit_hour,
    try_to_boolean(to_varchar(is_online_sale)) as is_online_sale,
    created_at,
    updated_at
from {{ source('sales', 'ticket_sales_physical') }}