duckdb
ATTACH  'data/epc_new.duckdb' AS epc_new;
DETACH epc_new;

.tables

INSTALL SPATIAL;
LOAD SPATIAL;

SELECT roof_description, walls_description
FROM domestic_certificates
WHERE roof_description IS NOT NULL
LIMIT 10;


SELECT max(lodgement_datetime) AS max_lodgement_datetime
FROM domestic_certificates;

-- .tables
-- Attach PostGIS database using configured secret
-- ATTACH '' AS weca_postgres (TYPE POSTGRES, SECRET weca_postgres);
-- ATTACH '~/projects/duckdb-macros/macro_library.duckdb' AS macros;

-- FROM macros.glimpse('domestic_certificates');

-- SELECT COUNT() FROM domestic_certificates;


USE epc_new;
ATTACH 'md:';

DROP DATABASE epc CASCADE;
-- md authentication is in the .env variable

ATTACH 'md:';
CREATE OR REPLACE DATABASE epc FROM epc_new;
