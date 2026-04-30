with transactions as (

    select * from {{ ref('stg_transactions') }}

),

joined as (

    select
        transaction_id,
        client_id,
        asset_ticker,
        operation,
        quantity,
        unit_price,
        quantity * unit_price                              as gross_amount,
        {{ signed_quantity('operation', 'quantity') }}     as signed_quantity,
        {{ signed_quantity('operation', 'quantity * unit_price') }} as signed_amount,
        transaction_date
    from transactions

),

deduplicated as (

    select *
    from (
        select
            *,
            row_number() over (
                partition by transaction_id
                order by transaction_date
            ) as rn
        from joined
    )
    where rn = 1

)

select
    transaction_id,
    client_id,
    asset_ticker,
    operation,
    quantity,
    unit_price,
    gross_amount,
    signed_quantity,
    signed_amount,
    transaction_date
from deduplicated
