/* 

Questions to Answer:

- Which Glossary Terms have been assigned to datasets and/or dashboards?
- How many datasets and/or dashboards have they been assigned to?

*/ 

with urns_with_terms as (
select
    urn,
    glossary_terms,
    json_extract_string(term.value, '$.urn') as term_urn
from
    stg_datahub_entities
cross join unnest(json_extract(glossary_terms, '$.terms')::json[]) as term(value)
where
    glossary_terms is not null
)

select
  -- stg_datahub_entities.urn as term_urn,
  json_extract_string(stg_datahub_entities.entity_details, '$.name') as term_name
  , count(distinct urns_with_terms.urn) as urn_count
from
  urns_with_terms
left join
  stg_datahub_entities
  on stg_datahub_entities.urn = urns_with_terms.term_urn
group by 1--, 2
order by 2 desc
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