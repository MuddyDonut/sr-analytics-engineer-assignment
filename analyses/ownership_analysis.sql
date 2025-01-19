/*

Questions to Answer:

- Who has been assigned as owners to dashboards and/or datasets?
- How many dashboards and/or datasets do they own?
- What is their job title?

*/
with
    entities_with_owners as (
        select
            entity_type,
            urn as entity_urn,
            json_extract_string(owner_urn.value, '$.owner') as owner_urn
        from
            stg_datahub_entities,
            unnest(json_extract(owners, '$.owners')::json[]) as owner_urn(value)
        where owners is not null
    ),

    owner_details as (
        select
            urn as owner_urn,
            json_extract_string(entity_details, '$.username') as username,
            json_extract_string(entity_details, '$.title') as title
        from stg_datahub_entities
        where
            entity_details is not null
            and json_extract_string(entity_details, '$.username') is not null
    )

select e.entity_type, o.username, o.title, count(distinct e.entity_urn) as entity_count
from entities_with_owners e
join owner_details o using (owner_urn)
group by e.entity_type, o.username, o.title
order by o.username, e.entity_type
;


/*

Query Output:

┌─────────────┬───────────────────────┬─────────────────────────┬───────┐
│ entity_type │       username        │          title          │  cnt  │
│   varchar   │        varchar        │         varchar         │ int64 │
├─────────────┼───────────────────────┼─────────────────────────┼───────┤
│ dataset     │ chris@longtail.com    │ Data Engineer           │   218 │
│ dataset     │ eddie@longtail.com    │ Analyst                 │   360 │
│ dataset     │ melina@longtail.com   │ Analyst                 │    24 │
│ dashboard   │ mitch@longtail.com    │ Software Engineer       │    21 │
│ dataset     │ mitch@longtail.com    │ Software Engineer       │    97 │
│ dataset     │ phillipe@longtail.com │ Fulfillment Coordinator │    96 │
│ dataset     │ roselia@longtail.com  │ Analyst                 │    73 │
│ dataset     │ shannon@longtail.com  │ Analytics Engineer      │   300 │
│ dataset     │ terrance@longtail.com │ Fulfillment Coordinator │    32 │
└─────────────┴───────────────────────┴─────────────────────────┴───────┘

*/

