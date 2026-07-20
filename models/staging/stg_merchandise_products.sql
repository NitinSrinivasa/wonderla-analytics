select
    try_to_number(to_varchar(product_id)) as product_id,
    product_name,
    category,
    try_to_decimal(to_varchar(price), 12, 2) as price,
    created_at,
    updated_at
from {{ source('park_assets', 'merchandise_products') }}