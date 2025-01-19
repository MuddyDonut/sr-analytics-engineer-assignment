/*

Questions to Answer:

- Which Domain is most commonly applied to datasets and/or dashboards?
- How many datasets and/or dashboards is that Domain applied to?
- What is the description of that Domain?

*/
with
    domain_details as (
        select
            urn as domain_urn,
            json_extract_string(entity_details, '$.name') as domain_name,
            json_extract_string(entity_details, '$.description') as domain_description
        from stg_datahub_entities
    ),

    domain_unnest as (
        select trim(both '"' from domain_urn) as domain_urn, urn as entity_urn
        from
            stg_datahub_entities,
            unnest(json_extract_string(domains, '$.domains')::string[]) as domain_flat(
                domain_urn
            )
        where domains is not null
    )

select domain_name, domain_description, count(distinct entity_urn) as entity_count
from domain_details
join domain_unnest using (domain_urn)
group by domain_name, domain_description
order by entity_count desc
limit 1
;


/*

Query Output:

┌─────────────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┬──────────────┐
│ domain_name │                                                 domain_description                                                 │ entity_count │
│   varchar   │                                                      varchar                                                       │    int64     │
├─────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┼──────────────┤
│ Finance     │ All data entities required for the Finance team to generate and maintain revenue forecasts and relevant reporting. │          285 │
└─────────────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┴──────────────┘

*/

