select
    customer_id,
    count(*) as ticket_purchases,
    sum(net_revenue) as lifetime_ticket_revenue,
    min(purchase_date) as first_purchase_date,
    max(purchase_date) as latest_purchase_date
from {{ ref('fact_ticket_sales') }}
group by customer_id