duckdb
ATTACH  'data/epc_new.duckdb' AS epc_new;
USE epc_new;

DROP DATABASE epc;
-- md authentication is in the .env variable

ATTACH 'md:';
CREATE OR REPLACE DATABASE epc FROM epc_new;
