# Sr Analytics Engineer Assignment Instructions

## Instructions to create models!
This will initialize a virtual environment via 'uv' and run a simple dbt build command to populate all of the duckdb tables

1. Install [uv](https://docs.astral.sh/uv/getting-started/installation/#standalone-installer)

```brew install uv``` or ```pip install uv```

2. cd into this repo

```cd sr-analytics-engineer-assignment```

3. activate the virtual environment

```uv init```

4. install requirements

```uv add -r requirements.txt```

5. build dbt models

```uv run dbt build```

## Tip
Don't forget to open duckdb!

```.open dev.duckdb```

