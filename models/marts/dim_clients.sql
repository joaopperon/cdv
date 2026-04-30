with clients as (

    select * from {{ ref('stg_clients') }}

)

select
    client_id,
    client_name,
    city,
    state,
    created_at
from clients
