duckdb
ATTACH  'data/epc_new.duckdb' AS epc_new;
USE epc_new;

-- md authentication is in the .env variable

ATTACH 'md:';
DROP DATABASE epc CASCADE;
CREATE OR REPLACE DATABASE epc FROM epc_new;
