{{ config(materialized="view") }}

select
    -- Domain Information
    d.domain_name,
    d.domain_description,

    -- Entity Details
    e.entity_name,
    e.entity_type,
    e.entity_description,
    e.created_by_user,

    -- Metrics
    e.entity_count

from {{ ref("dim_domains") }} d
left join {{ ref("fact_entities") }} e using (domain_key)
