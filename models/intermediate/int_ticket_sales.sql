select
    sale_id,
    customer_id,
    ticket_id,
    ticket_price,
    discount_percent,
    payment_method,
    purchase_channel,
    purchase_date,
    purchase_timestamp,
    visit_date,
    visit_hour,
    is_online_sale,
    created_at,
    updated_at,
    'online' as source_table
from {{ ref('stg_ticket_sales_online') }}

union all

select
    sale_id,
    customer_id,
    ticket_id,
    ticket_price,
    discount_percent,
    payment_method,
    purchase_channel,
    purchase_date,
    purchase_timestamp,
    visit_date,
    visit_hour,
    is_online_sale,
    created_at,
    updated_at,
    'physical' as source_table
from {{ ref('stg_ticket_sales_physical') }}