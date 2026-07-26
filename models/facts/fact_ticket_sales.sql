select
    sale_id,
    customer_id,
    ticket_id,
    purchase_date,
    visit_date,
    source_table,
    ticket_price,
    discount_percent,
    ticket_price
        * (1 - coalesce(discount_percent, 0) / 100)
        as net_revenue
from {{ ref('int_ticket_sales') }}