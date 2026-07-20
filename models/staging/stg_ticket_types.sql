select
    try_to_number(to_varchar(ticket_id)) as ticket_id,
    ticket_type_name,
    description,
    try_to_decimal(to_varchar(price), 12, 2) as price,
    try_to_boolean(to_varchar(includes_fast_pass)) as includes_fast_pass,
    try_to_boolean(to_varchar(includes_vip_benefits)) as includes_vip_benefits,
    try_to_date(to_varchar(launch_date)) as launch_date,
    created_at,
    updated_at
from {{ source('park_assets', 'ticket_types') }}