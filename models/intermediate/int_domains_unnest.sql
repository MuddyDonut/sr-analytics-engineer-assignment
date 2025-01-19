{{ config(materialized="view") }}

with
    domain_details as (
        select
            urn as domain_urn,
            json_extract_string(entity_details, '$.name') as domain_name,
            json_extract_string(entity_details, '$.description') as domain_description
        from {{ ref("stg_datahub_entities") }}
    ),

    domain_unnest as (
        select trim(both '"' from domain_urn) as domain_urn, urn as entity_urn
        from
            {{ ref("stg_datahub_entities") }},
            unnest(json_extract_string(domains, '$.domains')::string[]) as domain_flat(
                domain_urn
            )
        where domains is not null
    )

select distinct domain_name, domain_description, domain_urn
from domain_details
join domain_unnest using (domain_urn)
