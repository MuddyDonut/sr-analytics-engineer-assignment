# Sr Analytics Engineer Assignment

## Instructions to create models!
This will initialize a virtual environment via 'uv' and run a simple dbt build command to populate all of the duckdb tables

1. Install [uv](https://docs.astral.sh/uv/getting-started/installation/#standalone-installer)
```brew install uv``` or ```pip install uv```

2. cd into this repo
```cd sr-analytics-engineer-assignment```

3. activate the virtual environment
``` uv init```

4. install requirements
```uv add -r requirements.txt```

5. build dbt models
```uv run dbt build```

---
## Introduction
DataHub is the leading open-source metadata platform that helps organizations catalog, discover, and understand their data assets. Used by over 3,000 companies worldwide, DataHub connects metadata across diverse data assets - from datasets and pipelines to dashboards and ML models - providing a unified approach to data discovery, observability, and governance.

Acryl Data is the company behind the project, offering a premium version of DataHub to customers like Notion, Chime, TripAdvisor, Optum, and more. 

## Assignment Overview

This assignment simulates the work you'll do as the first Senior Analytics Engineer at Acryl Data, focused on building high-quality data models on top of DataHub's metadata graph to understand customer adoption.

It contains two parts:

1. **Code Review:** Provide a code review of 3 SQL queries in the `/analyses` directory.
2. **Data Modeling:** Design a collection of data models on top of the staging table to support a set of analytical use cases.

Your submission should include:
- Your Forked GitHub repo with executable SQL code for Parts 1 & 2, designed to run against the provided DuckDB database.
  - **NOTE:** You are welcome to make the repository private and grant appropriate access to `maggiehays` once you are ready to submit.
- A pull request demonstrating feedback and improvements for Part 1.
- Representative dbt-style models for Part 2 that showcase how you would structure the project.
- Comprehensive documentation covering your approach, assumptions, trade-offs, and open questions.

**Important Notes:**
- The provided dbt project files are for reference only. You are not required to set up dbt or run the project locally. Focus your efforts on demonstrating your ability to provide feedback and design effective models for analysis.
- Submissions should be executable within the provided DuckDB database (`dev.duckdb`). If you use a different environment, include clear instructions to reproduce your work.
- Deep expertise in DataHub's metadata model isn't required - the sample data is representative but simplified.

---

## Part 0: Get Familiar with the dbt Project

Here are the relevant files for this exercise:

- `seeds/datahub_entities_raw.csv`: A seed file representing DataHub's raw data model.
  - **NOTE:** We do not expect you to develop resources directly on top of this seed file, but you are welcome to use this to import data into a datastore other than the DuckDB database provided if you choose to do so.
- `models/staging/stg_datahub_entities.sql`: Initial transformation of the seed file; this is the baseline model you'll be working with. See below image for entity relationships.
- `models/schema.yml`: Table and column descriptions.
- `analyses/*.sql`: Three SQL queries built on top of `stg_datahub_entities`.
- `dev.duckdb`: A DuckDB database containing the `datahub_entities_raw` and `stg_datahub_entities` tables.

Take time to explore the contents and documentation for `stg_datahub_entities` to understand its structure and relationships. Here's an overview of how entities within this table relate to one another:

![](imgs/datahub-entity-relationships.png)

## Part 1: Code Review

Within your GitHub Fork, create a pull request with improvements to the 3 files in the `analyses/` directory, focusing on the following:

1. **Logic Accuracy:** Ensure the query logic accurately generates output to address the questions listed at the beginning of each file; update the baseline query output if necessary.
2. **Consistency & Readability:** Suggest changes to improve the consistency and readability of logic across all three files.
3. **Communication:** Explain why you are proposing the changes within your PR; add code comments inline where you feel they add value.

**NOTE:** Ensure you publish a pull request against your fork, NOT the `acryldata` repository:

![](imgs/pr-against-fork.png)

## Part 2: Analytical Data Model Design

Now that you are familiar with the underlying data and sample use cases, choose **one use case** from the `analyses` directory and design a set of reusable dbt models built on top of `stg_datahub_entities` to address that analytical need. These models can be merged directly into `main` or submitted as a Pull Request within your GitHub Fork. Models must be executable within the provided DuckDB database. If you choose to use a different datastore, include detailed steps to reproduce your work outside of DuckDB.

Your task involves the following:

1. **Select a Use Case**: Select **one use case** from the `analyses` directory to focus on:
   - Domains assigned to Datasets/Dashboards, their descriptions, and count of assigned entities.
   - **OR** Glossary Terms applied to Datasets/Dashboards and count of assigned entities.
   - **OR** Owners assigned to Datasets/Dashboards, their job titles, and ownership counts.

2. **Design Data Models**: Create a set of dbt models to support the questions presented in the use case, ensuring you support the following use cases:
   - **Data Cleanup/Normalization**: Model(s) that clean and normalize raw data, ensuring consistency and quality.
   - **Ad-hoc Query Layer**: Model(s) designed for SQL-savvy analysts to conduct flexible, exploratory analysis.
   - **Reporting/Presentation Layer**: Final model(s) optimized for reporting and consumption by less technical stakeholders.

3. **Provide Documentation**: Include two types of documentation for your models:  

   - **User-Facing Documentation**: For analysts and day-to-day users of the models, explaining key fields and usage.  
   - **Submission Documentation**: For reviewers, detailing:
     - Assumptions made during model design.   
     - Opportunities for future improvements or extensions.

**Note**: Optimize for clarity and usability over performance. Incremental models are optional unless they enhance your design. Deliver clean, testable, and reusable models aligned with dbt best practices.
