# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

EPC (Energy Performance Certificate) data processing pipeline for England and Wales. Ingests bulk CSV downloads from DLUHC into a DuckDB database for analysis. Covers domestic and non-domestic properties from 2012 onwards.

## Data Architecture

**Database**: `data/epc_new.duckdb` (DuckDB)

Four tables, each loaded from yearly CSV files via glob patterns:

| Table | Source pattern | Scale |
|---|---|---|
| `domestic_certificates` | `data/domestic/certificates-*.csv` | ~25M rows, ~20GB CSV |
| `domestic_recommendations` | `data/domestic/recommendations-*.csv` | ~70M rows, ~30GB CSV |
| `non_domestic_certificates` | `data/non-domestic/certificates-*.csv` | ~1.5M rows, ~600MB CSV |
| `non_domestic_recommendations` | `data/non-domestic/recommendations-*.csv` | ~10M rows, ~2GB CSV |

Recommendations tables link to certificates via `certificate_number`.

Schema definitions live in `sql/schemas/`. Column comments (from DLUHC data dictionaries) are in `sql/02_comments.sql`. Data dictionaries are in `data/data-dictionaries/`.

## Key Commands

```bash
# Ingest all CSVs into DuckDB (run from project root)
duckdb data/epc-new.duckdb < sql/01_ingest.sql

# Apply column/table comments
duckdb data/epc-new.duckdb < sql/02_comments.sql

# Apply incremental certificate updates from data/updates/{domestic,non-domestic}/
# Inserts new certificate_numbers only (ANTI JOIN); deletes consumed CSVs on success.
uv run python scripts/run_updates.py

# Ad-hoc query
duckdb data/epc-new.duckdb -c "SELECT COUNT(*) FROM domestic_certificates"

# Sync dependencies
uv sync

# Lint
uv run ruff check .

# Format
uv run ruff format .

# Tests
uv run pytest
```

## MCP Integration

MotherDuck MCP server is configured in `.mcp.json`, pointing at `data/epc_new.duckdb`. This enables SQL queries against the EPC database directly from Claude Code.

## CSV Ingestion Notes

- Domestic certificates CSV uses `escape='\'` due to backslash-escaped fields
- Non-domestic certificates CSV also uses `escape='\'`
- All column types are explicitly mapped in `sql/01_ingest.sql` (no auto-detect) to avoid type inference issues across ~50GB of CSV data
- CSV files are yearly partitions (2012-2026), one per year per table
- Incremental updates: drop CSVs (matching the schemas in `sql/01_ingest.sql`) into `data/updates/domestic/` or `data/updates/non-domestic/`, then run `scripts/run_updates.py`. The wrapper invokes the ANTI JOIN inserts in `sql/06_update_certificates.sql` for whichever side has files, skipping `certificate_number`s already present, and deletes the source CSVs on success

## Ruff Configuration

Configured in `ruff.toml`: line length 88, target Python 3.12, rules include pycodestyle, pyflakes, pyupgrade, bandit, bugbear, simplify, and isort.
