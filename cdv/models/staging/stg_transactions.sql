with source as (

    select * from {{ ref('transactions') }}

),

renamed as (

    select
        cast(transaction_id   as varchar) as transaction_id,
        cast(client_id        as varchar) as client_id,
        cast(asset_ticker     as varchar) as asset_ticker,
        upper(trim(operation))            as operation,
        cast(quantity         as integer) as quantity,
        cast(unit_price       as double)  as unit_price,
        cast(transaction_date as date)    as transaction_date
    from source

),

filtered as (

    select *
    from renamed
    where client_id is not null
      and quantity is not null
      and quantity > 0
      and operation in ('BUY', 'SELL')

)

select * from filtered
