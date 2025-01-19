{{ config(materialized="table") }}

select distinct
    md5(domain_urn) as domain_key,
    domain_urn,
    domain_name,
    domain_description,
    current_localtimestamp() as dbt_loaded_at
from {{ ref("int_domains_unnest") }}
