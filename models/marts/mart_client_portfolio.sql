with fact as (

    select * from {{ ref('fact_transactions') }}

),

clients as (

    select * from {{ ref('dim_clients') }}

),

aggregated as (

    select
        client_id,
        asset_ticker,
        sum(case when operation = 'BUY'  then quantity     else 0 end) as total_quantity_bought,
        sum(case when operation = 'SELL' then quantity     else 0 end) as total_quantity_sold,
        sum(case when operation = 'BUY'  then gross_amount else 0 end) as total_amount_bought,
        sum(case when operation = 'SELL' then gross_amount else 0 end) as total_amount_sold,
        sum(signed_quantity)                                            as net_quantity,
        sum(signed_amount)                                              as net_amount,
        min(transaction_date)                                           as first_transaction_date,
        max(transaction_date)                                           as last_transaction_date
    from fact
    group by client_id, asset_ticker

)

select
    a.client_id,
    c.client_name,
    a.asset_ticker,
    a.total_quantity_bought,
    a.total_quantity_sold,
    a.net_quantity,
    a.total_amount_bought,
    a.total_amount_sold,
    a.net_amount,
    a.first_transaction_date,
    a.last_transaction_date
from aggregated a
left join clients c
    on c.client_id = a.client_id
