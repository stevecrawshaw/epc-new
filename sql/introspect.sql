duckdb data/epc_new.duckdb

-- .tables

-- INSTALL SPATIAL;
-- LOAD SPATIAL;

-- .tables
-- Attach PostGIS database using configured secret
-- ATTACH '' AS weca_postgres (TYPE POSTGRES, SECRET weca_postgres);
-- ATTACH '~/projects/duckdb-macros/macro_library.duckdb' AS macros;

-- FROM macros.glimpse('domestic_certificates');

-- SELECT COUNT() FROM domestic_certificates;


-- QUERY BELOW AIMS TO FILTER JUST THE MOST RECENT CERTIFICATE PER UPRN, AND ONLY FOR THE FOUR LOCAL AUTHORITIES IN SCOPE FOR ODS EXPORT
-- HOW CAN IT BE OPTIMISED?
SELECT *
FROM domestic_certificates
WHERE uprn IS NOT NULL AND local_authority IN ('E06000023', 'E06000024', 'E06000025', 'E06000022')
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY uprn
    ORDER BY
        lodgement_datetime DESC NULLS LAST,
        certificate_number DESC NULLS LAST
) = 1;

