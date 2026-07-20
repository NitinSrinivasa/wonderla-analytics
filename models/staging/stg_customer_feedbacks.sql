select *
from {{ source('customer_data', 'customer_feedbacks') }}