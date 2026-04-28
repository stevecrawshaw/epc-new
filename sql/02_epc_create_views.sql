duckdb data/epc_new.duckdb

-- CREATE INTERMEDIATE VIEWS OF DE - DUPLICATED RECORDS FOR DOMESTIC AND NON - DOMESTIC CERTIFICATES, FILTERED TO FOUR LOCAL AUTHORITIES IN SCOPE FOR ODS EXPORT
-- THIS IS TO OPTIMISE THE SUBSEQUENT EXPORT VIEW CREATION AND EXPORT STEPS, AND TO ENABLE REUSE OF THE DEDUPLICATED DATA FOR OTHER PURPOSES IF REQUIRED

ATTACH '~/projects/duckdb-macros/macro_library.duckdb' AS macros;

CREATE OR REPLACE VIEW epc_domestic_lep_deduplicated_vw AS
SELECT *
FROM domestic_certificates e
WHERE e.local_authority IN ('E06000023', 'E06000024', 'E06000025', 'E06000022')
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY e.uprn
    ORDER BY
        e.lodgement_datetime DESC NULLS LAST,
        e.certificate_number DESC NULLS LAST
) = 1;

DESCRIBE epc_domestic_lep_deduplicated_vw;
-- FROM macros.glimpse('epc_domestic_lep_deduplicated_vw');

-- SELECT COUNT() FROM epc_domestic_lep_deduplicated_vw;

-- SELECT COUNT() FROM epc_domestic_lep_deduplicated_vw GROUP BY uprn HAVING COUNT() > 1;


CREATE OR REPLACE VIEW epc_non_domestic_lep_deduplicated_vw AS
SELECT *
FROM non_domestic_certificates e
WHERE e.local_authority IN ('E06000023', 'E06000024', 'E06000025', 'E06000022')
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY e.uprn
    ORDER BY
        e.lodgement_datetime DESC NULLS LAST,
        e.certificate_number DESC NULLS LAST
) = 1;


DESCRIBE epc_non_domestic_lep_deduplicated_vw;
-- FROM macros.glimpse('epc_non_domestic_lep_deduplicated_vw');

-- DETACH macros;
