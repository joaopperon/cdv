{{
    config(
        materialized = 'incremental',
        unique_key   = 'transaction_id',
        incremental_strategy = 'delete+insert'
    )
}}

with int_t as (

    select * from {{ ref('int_transactions') }}

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
from int_t

{% if is_incremental() %}
    where transaction_date >= (select coalesce(max(transaction_date), '1900-01-01') from {{ this }})
{% endif %}
