"""Apply incremental EPC certificate updates from data/updates/*.

For each side (domestic, non-domestic) that has CSV files in its updates
directory, runs the matching ANTI JOIN insert from
sql/06_update_certificates.sql against the DuckDB database, then deletes
the consumed files. Sides with no files are skipped silently.
"""

from __future__ import annotations

import re
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DB = ROOT / "data" / "epc_new.duckdb"
SQL_FILE = ROOT / "sql" / "06_update_certificates.sql"

_DUCKDB = shutil.which("duckdb")
if not _DUCKDB:
    sys.exit("error: duckdb executable not found in PATH")

SIDES: dict[str, tuple[Path, str]] = {
    "domestic": (ROOT / "data" / "updates" / "domestic", "domestic_certificates"),
    "non-domestic": (
        ROOT / "data" / "updates" / "non-domestic",
        "non_domestic_certificates",
    ),
}


def extract_statement(sql_text: str, key: str) -> str:
    """Pull the statement following `-- @<key>` up to the next `-- @` or EOF."""
    pattern = rf"-- @{re.escape(key)}\s*\n(.*?)(?=\n-- @|\Z)"
    match = re.search(pattern, sql_text, re.DOTALL)
    if not match:
        raise ValueError(f"No `-- @{key}` block found in {SQL_FILE}")
    return match.group(1).strip()


def count_rows(table: str) -> int:
    result = subprocess.run(
        [_DUCKDB, str(DB), "-noheader", "-list", "-c", f"SELECT count(*) FROM {table}"],  # noqa: S603
        check=True,
        capture_output=True,
        text=True,
        encoding="utf-8",
    )
    return int(result.stdout.strip())


def run_sql(statement: str) -> None:
    result = subprocess.run(
        [_DUCKDB, str(DB), "-c", statement],  # noqa: S603
        check=False,
        capture_output=True,
        encoding="utf-8",
    )
    if result.returncode != 0:
        print(result.stderr, file=sys.stderr)
        raise subprocess.CalledProcessError(result.returncode, result.args)


def process_side(name: str, csv_dir: Path, table: str, sql_text: str) -> None:
    files = sorted(csv_dir.glob("*.csv"))
    if not files:
        print(f"[{name}] no update files — skipping")
        return

    statement = extract_statement(sql_text, name)
    before = count_rows(table)
    print(f"[{name}] inserting from {len(files)} file(s)…")
    run_sql(statement)
    after = count_rows(table)
    inserted = after - before
    print(f"[{name}] inserted {inserted} new row(s); deleting consumed files")

    for f in files:
        f.unlink()


def main() -> int:
    if not DB.exists():
        print(f"error: database not found at {DB}", file=sys.stderr)
        return 1
    if not SQL_FILE.exists():
        print(f"error: SQL file not found at {SQL_FILE}", file=sys.stderr)
        return 1

    sql_text = SQL_FILE.read_text(encoding="utf-8")
    for name, (csv_dir, table) in SIDES.items():
        process_side(name, csv_dir, table, sql_text)
    return 0


if __name__ == "__main__":
    sys.exit(main())
