{{ config(materialized="table") }}

with
    source_data as (
        select distinct
            urn,
            domain_urn,
            entity_type,
            entity_name,
            entity_description,
            entity_created_by,
            entity_created_at
        from {{ ref("int_entities_unnest") }}
        where entity_created_at is not null
    )

select
    md5(urn) as entity_fact_key,
    md5(domain_urn) as domain_key,
    urn as entity_urn,
    coalesce(entity_name, 'Unknown') as entity_name,
    coalesce(entity_type, 'Unknown') as entity_type,
    coalesce(entity_description, 'No description available') as entity_description,
    coalesce(entity_created_by, 'Unknown') as created_by_user,
    entity_created_at as created_timestamp,
    1 as entity_count,
    current_localtimestamp() as dbt_loaded_at
from source_data

