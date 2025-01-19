{{ config(materialized="view") }}

select distinct
    urn,
    trim(both '"' from domain_urn) as domain_urn,
    entity_type,
    json_extract_string(entity_details, '$.name') as entity_name,
    json_extract_string(entity_details, '$.description') as entity_description,
    entity_created_by,
    entity_created_at
from
    {{ ref("stg_datahub_entities") }},
    unnest(json_extract_string(domains, '$.domains')::string[]) as domain_flat(
        domain_urn
    )
where domains is not null
