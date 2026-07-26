select
    purchase_date,
    count(*) as tickets_sold,
    sum(net_revenue) as ticket_revenue
from {{ ref('fact_ticket_sales') }}
group by purchase_date