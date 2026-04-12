-- duckdb data/epc_new.duckdb

INSTALL SPATIAL;
LOAD SPATIAL;

-- .tables
-- Attach PostGIS database using configured secret
ATTACH '' AS weca_postgres (TYPE POSTGRES, SECRET weca_postgres);
ATTACH '~/projects/duckdb-macros/macro_library.duckdb' AS macros;

-- Load open UPRN (Unique Property Reference Number) boundaries
CREATE TEMPORARY TABLE open_uprn_lep_tbl AS
SELECT * FROM weca_postgres.os.open_uprn_lep;

-- DOMESTIC EPC DATA EXPORT TO ODS
-- ONLY A SUBSET OF RECORDS IS EXPORTED TO COMPLY WITH COPYRIGHT AND RECORD LIMITATIONS
-- A Geopoint is added via spatial join with UPRN boundaries to enable mapping in ODS
-- Address fields are excluded for privacy
CREATE TEMPORARY VIEW epc_domestic_lep_ods_vw AS
SELECT
e.certificate_number,
e.uprn,
e.local_authority,
e.local_authority_label,
e.property_type,
e.transaction_type,
e.construction_age_band,
e.tenure,
e.walls_description,
e.roof_description,
e.walls_energy_eff,
e.roof_energy_eff,
e.mainheat_description,
e.mainheat_energy_eff,
e.main_fuel,
e.solar_water_heating_flag,
e.current_energy_rating,
e.potential_energy_rating,
e.current_energy_efficiency,
e.potential_energy_efficiency,
e.energy_consumption_current,
e.energy_consumption_potential,
e.energy_tariff,
e.co2_emissions_current,
e.co2_emissions_potential,
e.co2_emiss_curr_per_floor_area,
e.environment_impact_current,
e.environment_impact_potential,
e.heating_cost_current,
e.heating_cost_potential,
e.hot_water_cost_current,
e.hot_water_cost_potential,
e.number_habitable_rooms,
e.number_heated_rooms,
e.photo_supply,
e.total_floor_area,
e.built_form,
e.lodgement_datetime,
macros.geopoint_from_blob(o.shape) AS geo_point_2d
FROM epc_new.epc_domestic_lep_deduplicated_vw e
LEFT JOIN open_uprn_lep_tbl o ON e.uprn = o.uprn;

-- DESCRIBE epc_domestic_lep_ods_vw;
-- FROM macros.glimpse('epc_domestic_lep_ods_vw');

-- SELECT COUNT() FROM epc_domestic_lep_ods_vw;

-- SELECT COUNT() FROM epc_domestic_lep_ods_vw GROUP BY uprn HAVING COUNT() > 1;


-- EXPORT TO CSV - REPLACE PROPRIETARY SQUARED SYMBOL WITH '2' TO AVOID ISSUES IN ODS ENCODING
COPY
 (
      SELECT * REPLACE (
          regexp_replace(walls_description, '²', '2') AS walls_description,
          regexp_replace(roof_description, '²', '2') AS roof_description
      )
      FROM epc_domestic_lep_ods_vw)
 TO
'~/projects/epc-new/data/exports/epc_domestic_lep_ods.csv' (FORMAT CSV, HEADER);

-- NON DOMESTIC EPC DATA EXPORT TO ODS

CREATE TEMPORARY VIEW epc_non_domestic_lep_ods_vw AS
SELECT
    e.* EXCLUDE ("address", "address1", "address2", "address3", "postcode"),
    macros.geopoint_from_blob(o.shape) AS geo_point_2d
FROM epc_new.epc_non_domestic_lep_deduplicated_vw e
LEFT JOIN open_uprn_lep_tbl o ON e.uprn = o.uprn;

-- DESCRIBE epc_non_domestic_lep_ods_vw;
-- FROM macros.glimpse('epc_non_domestic_lep_ods_vw');

COPY epc_non_domestic_lep_ods_vw
TO '~/projects/epc-new/data/exports/epc_non_domestic_lep_ods.csv'
(FORMAT CSV, HEADER);

DETACH weca_postgres;
DETACH macros;
