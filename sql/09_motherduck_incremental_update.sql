-- Incremental MotherDuck update.
-- Run from project root: duckdb data/epc-new.duckdb < sql/09_motherduck_incremental_update.sql
--
-- Strategy: attach the local DB, attach MotherDuck, create any tables that
-- do not yet exist in the remote DB, then INSERT ONLY rows whose natural key
-- is absent from the remote.
--
-- This script is safe to run repeatedly: it uses
-- CREATE TABLE IF NOT EXISTS for schema bootstrapping and ANTI JOIN for
-- idempotent inserts.  Run 08_export_to_motherduck.sql first for the initial
-- full database clone, then use this for periodic updates.

-- =============================================================================
-- Attach local and remote databases
-- =============================================================================

ATTACH 'data/epc_new.duckdb' AS epc_new;
USE epc_new;

-- MotherDuck authentication comes from the MOTHERDUCK_TOKEN environment variable
ATTACH 'md:';

.tables
-- =============================================================================
-- Bootstrap remote schema (safe to re-run)
-- =============================================================================

CREATE TABLE IF NOT EXISTS epc.domestic_certificates (
    certificate_number VARCHAR,
    address1 VARCHAR,
    address2 VARCHAR,
    address3 VARCHAR,
    address VARCHAR,
    postcode VARCHAR,
    inspection_date DATE,
    uprn VARCHAR,
    environment_impact_potential INTEGER,
    energy_consumption_current DOUBLE,
    energy_consumption_potential DOUBLE,
    environment_impact_current INTEGER,
    co2_emissions_current DOUBLE,
    co2_emiss_curr_per_floor_area DOUBLE,
    co2_emissions_potential DOUBLE,
    total_floor_area DOUBLE,
    lodgement_date VARCHAR,
    report_type VARCHAR,
    posttown VARCHAR,
    lodgement_datetime TIMESTAMP,
    current_energy_efficiency INTEGER,
    current_energy_rating VARCHAR,
    potential_energy_efficiency INTEGER,
    potential_energy_rating VARCHAR,
    extension_count INTEGER,
    number_open_fireplaces INTEGER,
    number_heated_rooms INTEGER,
    number_habitable_rooms INTEGER,
    low_energy_lighting INTEGER,
    low_energy_fixed_lighting_outlets_count INTEGER,
    solar_water_heating_flag VARCHAR,
    mechanical_ventilation VARCHAR,
    tenure VARCHAR,
    property_type VARCHAR,
    transaction_type VARCHAR,
    construction_age_band VARCHAR,
    built_form VARCHAR,
    energy_tariff VARCHAR,
    glazed_type VARCHAR,
    glazed_area VARCHAR,
    heat_loss_corridor VARCHAR,
    main_fuel VARCHAR,
    unheated_corridor_length VARCHAR,
    floor_level VARCHAR,
    flat_top_storey VARCHAR,
    flat_storey_count INTEGER,
    mains_gas_flag VARCHAR,
    photo_supply DOUBLE,
    wind_turbine_count INTEGER,
    lighting_cost_current INTEGER,
    lighting_cost_potential INTEGER,
    heating_cost_current INTEGER,
    heating_cost_potential INTEGER,
    hot_water_cost_current INTEGER,
    hot_water_cost_potential INTEGER,
    multi_glaze_proportion INTEGER,
    hotwater_description VARCHAR,
    hot_water_energy_eff VARCHAR,
    hot_water_env_eff VARCHAR,
    floor_description VARCHAR,
    floor_energy_eff VARCHAR,
    floor_env_eff VARCHAR,
    roof_description VARCHAR,
    roof_energy_eff VARCHAR,
    roof_env_eff VARCHAR,
    walls_description VARCHAR,
    walls_energy_eff VARCHAR,
    walls_env_eff VARCHAR,
    windows_description VARCHAR,
    windows_energy_eff VARCHAR,
    windows_env_eff VARCHAR,
    secondheat_description VARCHAR,
    sheating_energy_eff VARCHAR,
    sheating_env_eff VARCHAR,
    mainheat_description VARCHAR,
    mainheat_energy_eff VARCHAR,
    mainheat_env_eff VARCHAR,
    mainheatcont_description VARCHAR,
    mainheatc_energy_eff VARCHAR,
    mainheatc_env_eff VARCHAR,
    lighting_description VARCHAR,
    lighting_energy_eff VARCHAR,
    lighting_env_eff VARCHAR,
    fixed_lighting_outlets_count INTEGER,
    floor_height DOUBLE,
    main_heating_controls VARCHAR,
    local_authority VARCHAR,
    local_authority_label VARCHAR,
    constituency_label VARCHAR,
    constituency VARCHAR,
    country VARCHAR,
    region VARCHAR,
    uprn_source VARCHAR
);

CREATE TABLE IF NOT EXISTS epc.domestic_recommendations (
    certificate_number VARCHAR,
    improvement_item INTEGER,
    improvement_id VARCHAR,
    indicative_cost VARCHAR,
    improvement_summary_text VARCHAR,
    improvement_descr_text VARCHAR
);

CREATE TABLE IF NOT EXISTS epc.non_domestic_certificates (
    certificate_number VARCHAR,
    address1 VARCHAR,
    address2 VARCHAR,
    address3 VARCHAR,
    postcode VARCHAR,
    uprn VARCHAR,
    asset_rating INTEGER,
    asset_rating_band VARCHAR,
    property_type VARCHAR,
    inspection_date DATE,
    local_authority VARCHAR,
    constituency VARCHAR,
    transaction_type VARCHAR,
    lodgement_date DATE,
    new_build_benchmark DOUBLE,
    existing_stock_benchmark DOUBLE,
    building_level VARCHAR,
    main_heating_fuel VARCHAR,
    other_fuel_desc VARCHAR,
    special_energy_uses VARCHAR,
    renewable_sources VARCHAR,
    floor_area DOUBLE,
    standard_emissions DOUBLE,
    target_emissions DOUBLE,
    typical_emissions DOUBLE,
    building_emissions DOUBLE,
    aircon_present VARCHAR,
    aircon_kw_rating DOUBLE,
    estimated_aircon_kw_rating DOUBLE,
    ac_inspection_commissioned VARCHAR,
    building_environment VARCHAR,
    address VARCHAR,
    local_authority_label VARCHAR,
    constituency_label VARCHAR,
    posttown VARCHAR,
    lodgement_datetime TIMESTAMP,
    primary_energy_value DOUBLE,
    report_type VARCHAR,
    uprn_source VARCHAR
);

CREATE TABLE IF NOT EXISTS epc.non_domestic_recommendations (
    certificate_number VARCHAR,
    payback_type VARCHAR,
    recommendation_item INTEGER,
    related_certificate_number VARCHAR,
    recommendation_code VARCHAR,
    recommendation VARCHAR
);

CREATE TABLE IF NOT EXISTS epc.ca_la_tbl (
    LAD25CD VARCHAR,
    LAD25NM VARCHAR,
    CAUTH25CD VARCHAR,
    CAUTH25NM VARCHAR
);

-- =============================================================================
-- Incremental inserts: certificate_number is the natural key for certificates,
-- and the compound key (certificate_number, improvement_item) / (certificate_number,
-- recommendation_item) is the natural key for recommendations.
-- =============================================================================

-- Domestic certificates
INSERT INTO epc.domestic_certificates BY NAME
SELECT s.*
FROM epc_new.domestic_certificates s
ANTI JOIN epc.domestic_certificates t USING (certificate_number);

-- Domestic recommendations
INSERT INTO epc.domestic_recommendations BY NAME
SELECT s.*
FROM epc_new.domestic_recommendations s
ANTI JOIN epc.domestic_recommendations t USING (certificate_number, improvement_item);

-- Non-domestic certificates
INSERT INTO epc.non_domestic_certificates BY NAME
SELECT s.*
FROM epc_new.non_domestic_certificates s
ANTI JOIN epc.non_domestic_certificates t USING (certificate_number);

-- Non-domestic recommendations
INSERT INTO epc.non_domestic_recommendations BY NAME
SELECT s.*
FROM epc_new.non_domestic_recommendations s
ANTI JOIN epc.non_domestic_recommendations t USING (certificate_number, recommendation_item);

-- ca_la_tbl — a small static lookup; replace it entirely so new or updated
-- rows always propagate.  The table has at most ~400 rows.
DELETE FROM epc.ca_la_tbl WHERE 1=1;
INSERT INTO epc.ca_la_tbl BY NAME
SELECT * FROM epc_new.ca_la_tbl;
