with source as (

    select * from {{ ref('clients') }}

),

renamed as (

    select
        cast(client_id  as varchar) as client_id,
        trim(name)                  as client_name,
        nullif(trim(city), '')      as city,
        upper(trim(state))          as state,
        cast(created_at as date)    as created_at
    from source

),

deduplicated as (

    select *
    from (
        select
            *,
            row_number() over (
                partition by client_id
                order by created_at, client_name
            ) as rn
        from renamed
    )
    where rn = 1

)

select
    client_id,
    client_name,
    city,
    state,
    created_at
from deduplicated
