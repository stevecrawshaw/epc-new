LOAD HTTPFS;

CREATE TABLE ca_la_tbl (
    LAD25CD VARCHAR,
    LAD25NM VARCHAR,
    CAUTH25CD VARCHAR,
    CAUTH25NM VARCHAR
);
-- add North Somerset to the table as it is not officially yet part of the West of England
-- Combined Authority
INSERT INTO ca_la_tbl BY NAME (
    SELECT
        'E06000024' AS LAD25CD,
        'North Somerset' AS LAD25NM,
        'E47000009' AS CAUTH25CD,
        'West of England' AS CAUTH25NM
    );

-- Retrieve the lookup data for all combined authorities and their local authorities
-- Current data from May 2025 - will need updating

INSERT INTO ca_la_tbl BY NAME (
WITH json_cte AS
(SELECT unnest(features) f
FROM read_json('https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/LAD25_CAUTH25_EN_LU/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json'))
SELECT f.attributes.LAD25CD, f.attributes.LAD25NM, f.attributes.CAUTH25CD, f.attributes.CAUTH25NM
FROM json_cte);
