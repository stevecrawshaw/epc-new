duckdb data/epc_new.duckdb

.tables

-- Monthly cumulative proportion of all properties with CURRENT_ENERGY_RATING A+ to C
-- Uses the latest EPC per property (UPRN) as of each month

WITH certs AS (
    SELECT
        uprn AS prop_id,
        current_energy_rating,
        DATE_TRUNC('month', lodgement_datetime)::DATE AS lodge_month,
        LEAD(DATE_TRUNC('month', lodgement_datetime)::DATE) OVER (
            PARTITION BY uprn ORDER BY lodgement_datetime
        ) AS next_lodge_month
    FROM epc_domestic_lep_deduplicated_vw
    WHERE uprn IS NOT NULL
),
months AS (
    SELECT UNNEST(generate_series(DATE '2020-01-01', DATE '2026-02-01', INTERVAL 1 MONTH))::DATE AS month
)
SELECT
    m.month,
    COUNT(*) AS total_properties,
    COUNT(*) FILTER (c.current_energy_rating IN ('A+', 'A', 'B', 'C')) AS a_to_c,
    ROUND(100.0 * COUNT(*) FILTER (c.current_energy_rating IN ('A+', 'A', 'B', 'C')) / COUNT(*), 2) AS pct_a_to_c
FROM months m
JOIN certs c
    ON m.month >= c.lodge_month
    AND (c.next_lodge_month IS NULL OR m.month < c.next_lodge_month)
GROUP BY m.month
ORDER BY m.month;


-- Monthly cumulative proportion of all properties with CURRENT_ENERGY_RATING A or A+
-- Uses the latest EPC per property (UPRN) as of each month
-- Requires: LOAD spatial;

WITH certs AS (
    SELECT
        uprn AS prop_id,
        current_energy_rating,
        DATE_TRUNC('month', lodgement_datetime)::DATE AS lodge_month,
        LEAD(DATE_TRUNC('month', lodgement_datetime)::DATE) OVER (
            PARTITION BY uprn ORDER BY lodgement_datetime
        ) AS next_lodge_month
    FROM epc_domestic_lep_deduplicated_vw
    WHERE uprn IS NOT NULL
),
months AS (
    SELECT UNNEST(generate_series(DATE '2020-01-01', DATE '2026-02-01', INTERVAL 1 MONTH))::DATE AS month
)
SELECT
    m.month,
    COUNT(*) AS total_properties,
    COUNT(*) FILTER (c.current_energy_rating IN ('A', 'A+')) AS a_or_aplus,
    ROUND(100.0 * COUNT(*) FILTER (c.current_energy_rating IN ('A', 'A+')) / COUNT(*), 2) AS pct_a_or_aplus
FROM months m
JOIN certs c
    ON m.month >= c.lodge_month
    AND (c.next_lodge_month IS NULL OR m.month < c.next_lodge_month)
GROUP BY m.month
ORDER BY m.month;
