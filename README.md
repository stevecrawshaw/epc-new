# EPC Data Pipeline

Ingests bulk Energy Performance Certificate (EPC) data for England and Wales into DuckDB for analysis, with views and exports scoped to the West of England Combined Authority (WECA) region.

## What it does

- Loads ~25M domestic and ~1.5M non-domestic EPC certificates from DLUHC bulk CSV downloads into a local DuckDB database
- Creates deduplicated views per property (most recent certificate per UPRN) filtered to four WECA local authorities
- Adds a Combined Authority / Local Authority lookup table
- Exports certificate data to CSV for upload to the Huwise open data portal, with geo-points derived from the OS Open UPRN dataset

## Prerequisites

| Tool | Purpose |
|------|---------|
| [DuckDB CLI](https://duckdb.org/docs/installation/) | Database engine and query runner |
| [uv](https://docs.astral.sh/uv/) | Python package manager (incremental update script) |

## Data download

Download bulk data from [Get Energy Performance Data](https://get-energy-performance-data.communities.gov.uk/) (DLUHC). Place files in:

```
data/
  domestic/
    certificates-2012.csv
    certificates-2013.csv
    ...
    recommendations-2012.csv
    ...
  non-domestic/
    certificates-*.csv
    recommendations-*.csv
```

Data dictionaries from DLUHC live in `data/data-dictionaries/`.

## Pipeline

Run steps in order from the project root.

### 1. Ingest all CSVs

```bash
duckdb data/epc_new.duckdb < sql/01_ingest.sql
```

Loads yearly CSV files into four tables with explicit type mappings. Takes time — the domestic certificates alone are ~20 GB of CSV.

### 2. Create deduplicated views

```bash
duckdb data/epc_new.duckdb < sql/02_epc_create_views.sql
```

Creates views that deduplicate certificates per UPRN (most recent lodgement), filtered to the four WECA local authorities (`E06000022`–`E06000025`).

### 3. Add CA / LA lookup

```bash
duckdb data/epc_new.duckdb < sql/03_create_ca_la_lookup_tbl
```

Loads the ONS Local Authority to Combined Authority lookup (May 2025). North Somerset is inserted manually as it is not yet officially part of WECA.

### 4. Apply column comments

```bash
duckdb data/epc_new.duckdb < sql/04_comments.sql
```

Adds table and column comments from the DLUHC data dictionaries, improving readability when querying via MCP or an IDE.

### 5. Export to ODS

```bash
duckdb data/epc_new.duckdb < sql/07_epc_ods_export.sql
```

Exports domestic and non-domestic certificate data as CSV for the Huwise open data portal. Address fields are excluded for privacy. Requires a configured `weca_postgres` DuckDB secret and access to the OS Open UPRN PostGIS table.

## Incremental updates

To add new certificates without re-running the full ingest:

1. Drop new CSV files into `data/updates/domestic/` and/or `data/updates/non-domestic/`
2. Run the update script:

```bash
uv run python scripts/run_updates.py
```

The script inserts only certificate numbers not already present (ANTI JOIN) and deletes the source CSVs on success.

## Database schema

| Table | Source | Scale |
|-------|--------|-------|
| `domestic_certificates` | `data/domestic/certificates-*.csv` | ~25M rows |
| `domestic_recommendations` | `data/domestic/recommendations-*.csv` | ~70M rows |
| `non_domestic_certificates` | `data/non-domestic/certificates-*.csv` | ~1.5M rows |
| `non_domestic_recommendations` | `data/non-domestic/recommendations-*.csv` | ~10M rows |

Schema SQL lives in `sql/schemas/`. Recommendations link to certificates via `certificate_number`.

## Ad-hoc queries

```bash
# Row count
duckdb data/epc_new.duckdb -c "SELECT COUNT(*) FROM domestic_certificates"

# Interactive session
duckdb data/epc_new.duckdb
```

## MCP integration

A MotherDuck MCP server is configured in `.mcp.json`, pointing at `data/epc_new.duckdb`. This allows SQL queries against the database directly from Claude Code without leaving the editor.

## Development

```bash
uv sync          # Install dependencies
uv run ruff check .    # Lint
uv run ruff format .   # Format
uv run pytest    # Tests
```

## Data source

Bulk EPC data: [DLUHC — Get Energy Performance Data](https://get-energy-performance-data.communities.gov.uk/)
CA/LA lookup: [ONS Geoportal](https://geoportal.statistics.gov.uk/datasets/ons::local-authority-district-to-combined-authority-may-2025-lookup-in-en/api)
