/* 

Questions to Answer:

- Which Glossary Terms have been assigned to datasets and/or dashboards?
- How many datasets and/or dashboards have they been assigned to?

*/
with
    urns_with_terms as (
        select urn, glossary_terms, json_extract_string(term.value, '$.urn') as term_urn
        from
            stg_datahub_entities,
            unnest(json_extract(glossary_terms, '$.terms')::json[]) as term(value)
        where glossary_terms is not null
    ),

    term_details as (
        select
            json_extract_string(
                stg_datahub_entities.entity_details, '$.name'
            ) as term_name,
            urn
        from stg_datahub_entities
    )

select term_name, count(*) as urn_count
from term_details t
join urns_with_terms on t.urn = term_urn
group by term_name
order by count(*) desc
;

/*

Query Output:

┌───────────────────────┬───────────┐
│       term_name       │ urn_count │
│        varchar        │   int64   │
├───────────────────────┼───────────┤
│ Gold Tier             │       668 │
│ Confidential          │        60 │
│ Return Rate           │        16 │
│ Certification Pending │         1 │
└───────────────────────┴───────────┘

*/

