-- Apply column and table descriptions from data dictionaries
-- Run from project root: duckdb data/epc-new.duckdb < sql/02_comments.sql

-- =============================================================================
-- Table comments
-- =============================================================================

COMMENT ON TABLE domestic_certificates IS 'Energy Performance Certificates for domestic properties in England and Wales (2012-2026). Multiple certificates can exist per uprn. Source: DLUHC EPC bulk download.';
COMMENT ON TABLE domestic_recommendations IS 'Improvement recommendations linked to domestic EPCs (2012-2026). Source: DLUHC EPC bulk download.';
COMMENT ON TABLE non_domestic_certificates IS 'Energy Performance Certificates for non-domestic properties in England and Wales (2012-2026). Multiple certificates can exist per uprn. Source: DLUHC EPC bulk download.';
COMMENT ON TABLE non_domestic_recommendations IS 'Improvement recommendations linked to non-domestic EPCs (2012-2026). Source: DLUHC EPC bulk download.';

-- =============================================================================
-- Domestic certificates — from domestic_data_dictionary.csv
-- =============================================================================

COMMENT ON COLUMN domestic_certificates.certificate_number IS 'The unique reference number for the EPC. Generated when the certificate is lodged; can retrieve the record from the EPB data API and the EPC register.';
COMMENT ON COLUMN domestic_certificates.address1 IS 'The first line of the property''s address, usually the building number and/or name and street name.';
COMMENT ON COLUMN domestic_certificates.address2 IS 'The second line of the property''s address, usually the village town or city.';
COMMENT ON COLUMN domestic_certificates.address3 IS 'The third line of the property''s address, usually the county; not always used.';
COMMENT ON COLUMN domestic_certificates.postcode IS 'The postcode of the property. Five to seven alphanumeric characters created by Royal Mail.';
COMMENT ON COLUMN domestic_certificates.current_energy_rating IS 'How energy efficient the property was at the time of assessment based on its structure, heating and lighting. Rated A to G, where A is best.';
COMMENT ON COLUMN domestic_certificates.potential_energy_rating IS 'How energy efficient the property could be after making recommended improvements. Rated A to G, where A is best.';
COMMENT ON COLUMN domestic_certificates.current_energy_efficiency IS 'The estimated current annual energy cost for heating, hot water and lighting. Measured in pounds per square metre per year.';
COMMENT ON COLUMN domestic_certificates.potential_energy_efficiency IS 'The estimated annual energy cost for heating, hot water and lighting if recommended improvements are made. Measured in pounds per square metre per year.';
COMMENT ON COLUMN domestic_certificates.property_type IS 'Describes the kind of property such as house, flat or maisonette.';
COMMENT ON COLUMN domestic_certificates.built_form IS 'Describes how the property is joined to other buildings such as detached, semi-detached, terraced, or part of a block.';
COMMENT ON COLUMN domestic_certificates.inspection_date IS 'The date when information about the building was collected to prepare the EPC.';
COMMENT ON COLUMN domestic_certificates.local_authority IS 'The local authority the building is in. Uses the official ONS code for that local area.';
COMMENT ON COLUMN domestic_certificates.constituency IS 'The UK parliamentary constituency the building is in. Uses the official ONS code for that area.';
COMMENT ON COLUMN domestic_certificates.lodgement_date IS 'The date the energy certificate was added to the Energy Performance of Buildings Register.';
COMMENT ON COLUMN domestic_certificates.transaction_type IS 'States why the energy certificate was produced: sale, rental, new build, Green Deal, ECO assessment, or another reason.';
COMMENT ON COLUMN domestic_certificates.environment_impact_current IS 'Estimate of current CO2 emissions related to heating, lighting and hot water use. Rated 1-92+; higher rating means lower emissions. Banded A-G.';
COMMENT ON COLUMN domestic_certificates.environment_impact_potential IS 'Estimate of CO2 emissions related to heating, lighting and hot water use if recommended improvements are made. Rated 1-92+; higher rating means lower emissions.';
COMMENT ON COLUMN domestic_certificates.energy_consumption_current IS 'Estimate of energy currently used to heat, light, and provide hot water over a year. Measured in kWh/m2/year.';
COMMENT ON COLUMN domestic_certificates.energy_consumption_potential IS 'Estimate of energy the property would use each year if recommended improvements are made. Measured in kWh/m2/year.';
COMMENT ON COLUMN domestic_certificates.co2_emissions_current IS 'Estimate of current CO2 emissions each year based on the building''s energy use. Measured in tonnes/yr.';
COMMENT ON COLUMN domestic_certificates.co2_emiss_curr_per_floor_area IS 'Estimate of current CO2 emissions from energy use per square metre of floor area per year. Measured in kg/m2/year.';
COMMENT ON COLUMN domestic_certificates.co2_emissions_potential IS 'Estimate of total CO2 emissions per year if recommended improvements are made. Measured in tonnes/yr.';
COMMENT ON COLUMN domestic_certificates.lighting_cost_current IS 'Estimate of current cost of electricity used for lighting each year. Measured in GBP/yr.';
COMMENT ON COLUMN domestic_certificates.lighting_cost_potential IS 'Estimate of cost of electricity used for lighting each year if recommended improvements are made. Measured in GBP/yr.';
COMMENT ON COLUMN domestic_certificates.heating_cost_current IS 'Estimate of current energy costs for heating each year. Measured in GBP/yr.';
COMMENT ON COLUMN domestic_certificates.heating_cost_potential IS 'Estimate of energy costs for heating each year if recommended improvements are made. Measured in GBP/yr.';
COMMENT ON COLUMN domestic_certificates.hot_water_cost_current IS 'Estimate of current cost of hot water each year. Measured in GBP/yr.';
COMMENT ON COLUMN domestic_certificates.hot_water_cost_potential IS 'Estimate of cost of hot water each year if recommended improvements are made. Measured in GBP/yr.';
COMMENT ON COLUMN domestic_certificates.total_floor_area IS 'Total enclosed floor area of the property measured to the internal face of external walls. Given in m2.';
COMMENT ON COLUMN domestic_certificates.energy_tariff IS 'The electricity tariff used in the property: single-rate, dual-rate or time-of-use. Does not refer to gas or other fuel tariffs.';
COMMENT ON COLUMN domestic_certificates.mains_gas_flag IS 'Whether mains gas is actively used in the property (Y/N). Yes if a gas meter is present and supplying at least one gas-burning appliance.';
COMMENT ON COLUMN domestic_certificates.floor_level IS 'Applies to flats/maisonettes only. Shows which floor the flat is on, numbered from the lowest level of the building.';
COMMENT ON COLUMN domestic_certificates.flat_top_storey IS 'Whether the flat is on the top floor of a building.';
COMMENT ON COLUMN domestic_certificates.flat_storey_count IS 'Total number of floors in the apartment block, including ground floor and any basement levels.';
COMMENT ON COLUMN domestic_certificates.main_heating_controls IS 'The type of heating controls used for the main heating system(s). If there are two main systems, both are included.';
COMMENT ON COLUMN domestic_certificates.multi_glaze_proportion IS 'Estimate of proportion of total window area that is double or triple-glazed. Assessor places into one of twelve bands.';
COMMENT ON COLUMN domestic_certificates.glazed_type IS 'Type of glazing used in windows: single, double or triple. May be based on observation or evidence from BFRC/manufacturer.';
COMMENT ON COLUMN domestic_certificates.glazed_area IS 'Estimate of glazing compared to a typical building of similar type: Typical, More/Less than Typical, Much more/less than Typical.';
COMMENT ON COLUMN domestic_certificates.extension_count IS 'Number of extensions added to the property (max 4). Each extension entered separately in EPC calculation.';
COMMENT ON COLUMN domestic_certificates.number_habitable_rooms IS 'Number of habitable rooms including living rooms, bedrooms, studies. Excludes kitchens, bathrooms, hallways, utility rooms.';
COMMENT ON COLUMN domestic_certificates.number_heated_rooms IS 'Number of heated habitable rooms with a fixed heat emitter present (radiator, storage heater, gas fire, etc.).';
COMMENT ON COLUMN domestic_certificates.low_energy_lighting IS 'Proportion of fixed light fittings using low-energy bulbs (LEDs or CFLs). Given as percentage. Does not include portable lamps.';
COMMENT ON COLUMN domestic_certificates.number_open_fireplaces IS 'Number of open fireplaces allowing air to flow directly between inside and outside.';
COMMENT ON COLUMN domestic_certificates.hotwater_description IS 'Describes how the property heats its hot water: gas boiler, electric immersion heater, solar system, etc.';
COMMENT ON COLUMN domestic_certificates.hot_water_energy_eff IS 'How efficiently the hot water system uses energy. One of: very good, good, average, poor, very poor.';
COMMENT ON COLUMN domestic_certificates.hot_water_env_eff IS 'How the hot water system contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.floor_description IS 'Construction of the property''s lowest exposed floor — e.g. solid concrete or suspended timber.';
COMMENT ON COLUMN domestic_certificates.floor_energy_eff IS 'How well the floor(s) retain heat based on construction. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.floor_env_eff IS 'How the floor(s) contribute to CO2 emissions based on construction. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.windows_description IS 'Describes windows including single/double/triple glazing. May include special coatings or gas-filled spaces.';
COMMENT ON COLUMN domestic_certificates.windows_energy_eff IS 'How well windows retain heat. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.windows_env_eff IS 'How windows contribute to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.walls_description IS 'Construction of external walls: solid brick, cavity wall, timber frame. Includes insulation status.';
COMMENT ON COLUMN domestic_certificates.walls_energy_eff IS 'How well walls retain heat. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.walls_env_eff IS 'How walls contribute to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.secondheat_description IS 'Type of secondary heating system: gas fire, electric room heater, etc. An additional or backup heat source.';
COMMENT ON COLUMN domestic_certificates.sheating_energy_eff IS 'Energy efficiency of the secondary heating system. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.sheating_env_eff IS 'How the secondary heating system contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.roof_description IS 'Construction of the roof: pitched with tiles, flat with felt, thatched. Includes roof-level insulation.';
COMMENT ON COLUMN domestic_certificates.roof_energy_eff IS 'How well the roof retains heat. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.roof_env_eff IS 'How the roof contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.mainheat_description IS 'Main heating system: gas boiler with radiators, electric storage heaters, heat pump, etc. Both systems included if two.';
COMMENT ON COLUMN domestic_certificates.mainheat_energy_eff IS 'Energy efficiency rating of the main heating system. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.mainheat_env_eff IS 'How the main heating system contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.mainheatcont_description IS 'Type of control(s) for main heating: programmer, room thermostat, smart control. Both included if two systems.';
COMMENT ON COLUMN domestic_certificates.mainheatc_energy_eff IS 'Energy efficiency of the main heating controls. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.mainheatc_env_eff IS 'How main heating controls contribute to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.lighting_description IS 'Type of fixed lighting based on number and type of light fittings. Focuses on low-energy bulbs (LEDs/CFLs).';
COMMENT ON COLUMN domestic_certificates.lighting_energy_eff IS 'How efficiently the fixed lighting uses energy. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.lighting_env_eff IS 'How fixed lighting contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN domestic_certificates.main_fuel IS 'Fuel used to power the main heating system: mains gas, electricity, heating oil, solid fuels, etc.';
COMMENT ON COLUMN domestic_certificates.wind_turbine_count IS 'Number of wind turbines on the property.';
COMMENT ON COLUMN domestic_certificates.heat_loss_corridor IS 'Internal common corridor leading to a flat/maisonette only. Either no corridor, heated corridor or unheated.';
COMMENT ON COLUMN domestic_certificates.unheated_corridor_length IS 'For flats/maisonettes only. Length of wall in metres between the flat and an unheated corridor.';
COMMENT ON COLUMN domestic_certificates.floor_height IS 'Average height of the storey in metres. Measured from finished floor level to the ceiling.';
COMMENT ON COLUMN domestic_certificates.photo_supply IS 'Whether the property generates electricity from solar panels. Proportion of roof area (%) covered. 0% means no solar panels.';
COMMENT ON COLUMN domestic_certificates.solar_water_heating_flag IS 'Whether the property uses solar panels to help heat its water (Y/N).';
COMMENT ON COLUMN domestic_certificates.mechanical_ventilation IS 'Type of mechanical ventilation: extractor fan, positive input ventilation, or MVHR.';
COMMENT ON COLUMN domestic_certificates.address IS 'Full address combining address1, address2, and address3. Postcode recorded separately.';
COMMENT ON COLUMN domestic_certificates.local_authority_label IS 'Name of the local authority area. For reliable identification, use the local_authority ONS code.';
COMMENT ON COLUMN domestic_certificates.constituency_label IS 'Name of the UK parliamentary constituency. For reliable identification, use the constituency ONS code.';
COMMENT ON COLUMN domestic_certificates.posttown IS 'Post town of the property based on the Royal Mail address database. May differ from local authority boundaries.';
COMMENT ON COLUMN domestic_certificates.construction_age_band IS 'Period when the building was originally constructed. Different age bands may apply to extensions.';
COMMENT ON COLUMN domestic_certificates.lodgement_datetime IS 'Date and time the EPC was officially lodged on the Energy Performance of Buildings Register.';
COMMENT ON COLUMN domestic_certificates.tenure IS 'Tenure type: owner-occupied, rented (social), or rented (private). Does not affect EPC calculation.';
COMMENT ON COLUMN domestic_certificates.fixed_lighting_outlets_count IS 'Number of fixed light fittings using incandescent or halogen bulbs.';
COMMENT ON COLUMN domestic_certificates.low_energy_fixed_lighting_outlets_count IS 'Number of fixed light fittings using low energy bulbs (LEDs or CFLs).';
COMMENT ON COLUMN domestic_certificates.uprn IS 'Unique Property Reference Number. A 12-digit code identifying the property, flat, building, or plot of land.';
COMMENT ON COLUMN domestic_certificates.uprn_source IS 'How the UPRN was added: Energy Assessor (entered during assessment) or Address Matched (added later by address-matching system).';
COMMENT ON COLUMN domestic_certificates.report_type IS 'Type of energy assessment: RdSAP (Reduced Standard Assessment Procedure) for existing homes, or SAP for new homes/conversions.';
COMMENT ON COLUMN domestic_certificates.country IS 'Country where the property is located (England or Wales).';
COMMENT ON COLUMN domestic_certificates.region IS 'Region where the property is located.';

-- =============================================================================
-- Domestic recommendations — manually written (not in data dictionary)
-- =============================================================================

COMMENT ON COLUMN domestic_recommendations.certificate_number IS 'The EPC certificate number this recommendation relates to. Foreign key to domestic_certificates.';
COMMENT ON COLUMN domestic_recommendations.improvement_item IS 'Sequence number ordering the recommendations on the output EPC.';
COMMENT ON COLUMN domestic_recommendations.improvement_id IS 'Identifier code for the type of improvement recommended.';
COMMENT ON COLUMN domestic_recommendations.indicative_cost IS 'Estimated cost range for the improvement, e.g. GBP 3,500 - GBP 5,500.';
COMMENT ON COLUMN domestic_recommendations.improvement_summary_text IS 'Short summary of the recommended improvement, e.g. Solar photovoltaic panels, 2.5 kWp.';
COMMENT ON COLUMN domestic_recommendations.improvement_descr_text IS 'Detailed description of the recommended improvement and its benefits.';

-- =============================================================================
-- Non-domestic certificates — from non_domestic_data_dictionary.csv
-- =============================================================================

COMMENT ON COLUMN non_domestic_certificates.certificate_number IS 'The unique reference number for the EPC. Generated when the certificate is lodged; can retrieve the record from the EPB data API and the EPC register.';
COMMENT ON COLUMN non_domestic_certificates.address1 IS 'The first line of the property''s address, usually the building number and/or name and street name.';
COMMENT ON COLUMN non_domestic_certificates.address2 IS 'The second line of the property''s address, usually the village town or city.';
COMMENT ON COLUMN non_domestic_certificates.address3 IS 'The third line of the property''s address, usually the county; not always used.';
COMMENT ON COLUMN non_domestic_certificates.postcode IS 'The postcode of the property. Five to seven alphanumeric characters created by Royal Mail.';
COMMENT ON COLUMN non_domestic_certificates.asset_rating IS 'Energy Performance Asset Rating. CO2 emissions from the actual building compared to a Standard Emission Rate. (kg CO2/m2)';
COMMENT ON COLUMN non_domestic_certificates.asset_rating_band IS 'Energy Performance Asset Rating converted into a linear A+ to G band (A+ most efficient, G least).';
COMMENT ON COLUMN non_domestic_certificates.property_type IS 'Type of building being inspected. Based on planning use class.';
COMMENT ON COLUMN non_domestic_certificates.inspection_date IS 'The date when information about the building was collected to prepare the EPC.';
COMMENT ON COLUMN non_domestic_certificates.local_authority IS 'The local authority the building is in. Uses the official ONS code.';
COMMENT ON COLUMN non_domestic_certificates.constituency IS 'The UK parliamentary constituency the building is in. Uses the official ONS code.';
COMMENT ON COLUMN non_domestic_certificates.transaction_type IS 'States why the energy certificate was produced: sale, rental, new build, Green Deal, ECO assessment, or another reason.';
COMMENT ON COLUMN non_domestic_certificates.lodgement_date IS 'The date the energy certificate was added to the Energy Performance of Buildings Register.';
COMMENT ON COLUMN non_domestic_certificates.new_build_benchmark IS 'The benchmark value for new builds of this type of building.';
COMMENT ON COLUMN non_domestic_certificates.existing_stock_benchmark IS 'The benchmark value of existing stock for this type of building.';
COMMENT ON COLUMN non_domestic_certificates.building_level IS 'Building Complexity Level based on Energy Assessor National Occupation Standards.';
COMMENT ON COLUMN non_domestic_certificates.main_heating_fuel IS 'Main heating fuel: the fuel which delivers the greatest total thermal output for space or water heating.';
COMMENT ON COLUMN non_domestic_certificates.other_fuel_desc IS 'Text description of unspecified fuel type if Other is selected for main heating fuel.';
COMMENT ON COLUMN non_domestic_certificates.special_energy_uses IS 'Special energy uses discounted. Only appears on the Recommendations Report.';
COMMENT ON COLUMN non_domestic_certificates.renewable_sources IS 'On-site renewable energy sources. Only appears on the Advisory Report.';
COMMENT ON COLUMN non_domestic_certificates.floor_area IS 'Total useful floor area measured to the internal face of external walls. Given in m2.';
COMMENT ON COLUMN non_domestic_certificates.standard_emissions IS 'Standard Emission Rate determined by applying a fixed improvement factor to reference building emissions. (kg CO2/m2/year)';
COMMENT ON COLUMN non_domestic_certificates.target_emissions IS 'Target Emission Rate determined by applying a fixed improvement factor to reference building emissions. (kg CO2/m2/year)';
COMMENT ON COLUMN non_domestic_certificates.typical_emissions IS 'Typical Emission Rate for this type of building.';
COMMENT ON COLUMN non_domestic_certificates.building_emissions IS 'Building Emissions Rate. Annual CO2 emissions from the building. (kg CO2/m2)';
COMMENT ON COLUMN non_domestic_certificates.aircon_present IS 'Whether the building has an air conditioning system.';
COMMENT ON COLUMN non_domestic_certificates.aircon_kw_rating IS 'Air conditioning system rating in kW.';
COMMENT ON COLUMN non_domestic_certificates.estimated_aircon_kw_rating IS 'Estimated total effective output rating of the air conditioning system if exact rating unknown.';
COMMENT ON COLUMN non_domestic_certificates.ac_inspection_commissioned IS 'AC inspection status: 1=completed, 2=commissioned, 3=not completed/commissioned, 4=not relevant, 5=don''t know.';
COMMENT ON COLUMN non_domestic_certificates.building_environment IS 'Building environment: the servicing strategy contributing the largest proportion of CO2 emissions.';
COMMENT ON COLUMN non_domestic_certificates.address IS 'Full address combining address1, address2, and address3. Postcode recorded separately.';
COMMENT ON COLUMN non_domestic_certificates.local_authority_label IS 'Name of the local authority area. For reliable identification, use the local_authority ONS code.';
COMMENT ON COLUMN non_domestic_certificates.constituency_label IS 'Name of the UK parliamentary constituency. For reliable identification, use the constituency ONS code.';
COMMENT ON COLUMN non_domestic_certificates.posttown IS 'Post town of the property based on the Royal Mail address database.';
COMMENT ON COLUMN non_domestic_certificates.lodgement_datetime IS 'Date and time the EPC was officially lodged on the Energy Performance of Buildings Register.';
COMMENT ON COLUMN non_domestic_certificates.primary_energy_value IS 'Primary energy use displayed on the non-domestic EPC. (kWh/m2/year)';
COMMENT ON COLUMN non_domestic_certificates.uprn IS 'Unique Property Reference Number. A 12-digit code identifying the property, building, or plot of land.';
COMMENT ON COLUMN non_domestic_certificates.uprn_source IS 'How the UPRN was added: Energy Assessor (entered during assessment) or Address Matched (added later by address-matching system).';
COMMENT ON COLUMN non_domestic_certificates.report_type IS 'Type of assessment: 102 = SBEM (Simplified Building Energy Model) for non-domestic buildings.';

-- =============================================================================
-- Non-domestic recommendations — from non_domestic_data_dictionary.csv + manual
-- =============================================================================

COMMENT ON COLUMN non_domestic_recommendations.certificate_number IS 'The EPC certificate number this recommendation relates to. Foreign key to non_domestic_certificates.';
COMMENT ON COLUMN non_domestic_recommendations.payback_type IS 'Payback period category for the recommendation (e.g. short, medium, long).';
COMMENT ON COLUMN non_domestic_recommendations.recommendation_item IS 'Sequence number ordering the recommendations on the output EPC.';
COMMENT ON COLUMN non_domestic_recommendations.related_certificate_number IS 'The certificate number of a related EPC, typically the same as certificate_number.';
COMMENT ON COLUMN non_domestic_recommendations.recommendation_code IS 'Shorthand code to represent the recommendation (e.g. EPC-E7).';
COMMENT ON COLUMN non_domestic_recommendations.recommendation IS 'Description of the suggested improvement.';

-- =============================================================================
-- Domestic LEP deduplicated view — West of England LEP (Bristol, Bath & NES,
-- North Somerset, South Gloucestershire). One row per UPRN, most recent EPC.
-- =============================================================================

COMMENT ON VIEW epc_domestic_lep_deduplicated_vw IS 'Most recent domestic EPC per UPRN for the four West of England LEP local authorities (Bristol E06000023, Bath and NES E06000024, North Somerset E06000025, South Gloucestershire E06000022). Deduplication uses latest lodgement_datetime then latest certificate_number.';

COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.certificate_number IS 'The unique reference number for the EPC. Generated when the certificate is lodged; can retrieve the record from the EPB data API and the EPC register.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.address1 IS 'The first line of the property''s address, usually the building number and/or name and street name.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.address2 IS 'The second line of the property''s address, usually the village town or city.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.address3 IS 'The third line of the property''s address, usually the county; not always used.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.postcode IS 'The postcode of the property. Five to seven alphanumeric characters created by Royal Mail.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.current_energy_rating IS 'How energy efficient the property was at the time of assessment based on its structure, heating and lighting. Rated A to G, where A is best.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.potential_energy_rating IS 'How energy efficient the property could be after making recommended improvements. Rated A to G, where A is best.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.current_energy_efficiency IS 'The estimated current annual energy cost for heating, hot water and lighting. Measured in pounds per square metre per year.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.potential_energy_efficiency IS 'The estimated annual energy cost for heating, hot water and lighting if recommended improvements are made. Measured in pounds per square metre per year.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.property_type IS 'Describes the kind of property such as house, flat or maisonette.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.built_form IS 'Describes how the property is joined to other buildings such as detached, semi-detached, terraced, or part of a block.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.inspection_date IS 'The date when information about the building was collected to prepare the EPC.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.local_authority IS 'The local authority the building is in. Uses the official ONS code for that local area. Filtered to E06000022–E06000025 (West of England LEP).';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.constituency IS 'The UK parliamentary constituency the building is in. Uses the official ONS code for that area.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.lodgement_date IS 'The date the energy certificate was added to the Energy Performance of Buildings Register.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.transaction_type IS 'States why the energy certificate was produced: sale, rental, new build, Green Deal, ECO assessment, or another reason.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.environment_impact_current IS 'Estimate of current CO2 emissions related to heating, lighting and hot water use. Rated 1-92+; higher rating means lower emissions. Banded A-G.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.environment_impact_potential IS 'Estimate of CO2 emissions related to heating, lighting and hot water use if recommended improvements are made. Rated 1-92+; higher rating means lower emissions.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.energy_consumption_current IS 'Estimate of energy currently used to heat, light, and provide hot water over a year. Measured in kWh/m2/year.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.energy_consumption_potential IS 'Estimate of energy the property would use each year if recommended improvements are made. Measured in kWh/m2/year.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.co2_emissions_current IS 'Estimate of current CO2 emissions each year based on the building''s energy use. Measured in tonnes/yr.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.co2_emiss_curr_per_floor_area IS 'Estimate of current CO2 emissions from energy use per square metre of floor area per year. Measured in kg/m2/year.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.co2_emissions_potential IS 'Estimate of total CO2 emissions per year if recommended improvements are made. Measured in tonnes/yr.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.lighting_cost_current IS 'Estimate of current cost of electricity used for lighting each year. Measured in GBP/yr.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.lighting_cost_potential IS 'Estimate of cost of electricity used for lighting each year if recommended improvements are made. Measured in GBP/yr.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.heating_cost_current IS 'Estimate of current energy costs for heating each year. Measured in GBP/yr.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.heating_cost_potential IS 'Estimate of energy costs for heating each year if recommended improvements are made. Measured in GBP/yr.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.hot_water_cost_current IS 'Estimate of current cost of hot water each year. Measured in GBP/yr.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.hot_water_cost_potential IS 'Estimate of cost of hot water each year if recommended improvements are made. Measured in GBP/yr.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.total_floor_area IS 'Total enclosed floor area of the property measured to the internal face of external walls. Given in m2.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.energy_tariff IS 'The electricity tariff used in the property: single-rate, dual-rate or time-of-use. Does not refer to gas or other fuel tariffs.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.mains_gas_flag IS 'Whether mains gas is actively used in the property (Y/N). Yes if a gas meter is present and supplying at least one gas-burning appliance.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.floor_level IS 'Applies to flats/maisonettes only. Shows which floor the flat is on, numbered from the lowest level of the building.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.flat_top_storey IS 'Whether the flat is on the top floor of a building.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.flat_storey_count IS 'Total number of floors in the apartment block, including ground floor and any basement levels.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.main_heating_controls IS 'The type of heating controls used for the main heating system(s). If there are two main systems, both are included.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.multi_glaze_proportion IS 'Estimate of proportion of total window area that is double or triple-glazed. Assessor places into one of twelve bands.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.glazed_type IS 'Type of glazing used in windows: single, double or triple. May be based on observation or evidence from BFRC/manufacturer.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.glazed_area IS 'Estimate of glazing compared to a typical building of similar type: Typical, More/Less than Typical, Much more/less than Typical.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.extension_count IS 'Number of extensions added to the property (max 4). Each extension entered separately in EPC calculation.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.number_habitable_rooms IS 'Number of habitable rooms including living rooms, bedrooms, studies. Excludes kitchens, bathrooms, hallways, utility rooms.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.number_heated_rooms IS 'Number of heated habitable rooms with a fixed heat emitter present (radiator, storage heater, gas fire, etc.).';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.low_energy_lighting IS 'Proportion of fixed light fittings using low-energy bulbs (LEDs or CFLs). Given as percentage. Does not include portable lamps.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.number_open_fireplaces IS 'Number of open fireplaces allowing air to flow directly between inside and outside.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.hotwater_description IS 'Describes how the property heats its hot water: gas boiler, electric immersion heater, solar system, etc.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.hot_water_energy_eff IS 'How efficiently the hot water system uses energy. One of: very good, good, average, poor, very poor.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.hot_water_env_eff IS 'How the hot water system contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.floor_description IS 'Construction of the property''s lowest exposed floor — e.g. solid concrete or suspended timber.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.floor_energy_eff IS 'How well the floor(s) retain heat based on construction. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.floor_env_eff IS 'How the floor(s) contribute to CO2 emissions based on construction. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.windows_description IS 'Describes windows including single/double/triple glazing. May include special coatings or gas-filled spaces.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.windows_energy_eff IS 'How well windows retain heat. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.windows_env_eff IS 'How windows contribute to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.walls_description IS 'Construction of external walls: solid brick, cavity wall, timber frame. Includes insulation status.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.walls_energy_eff IS 'How well walls retain heat. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.walls_env_eff IS 'How walls contribute to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.secondheat_description IS 'Type of secondary heating system: gas fire, electric room heater, etc. An additional or backup heat source.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.sheating_energy_eff IS 'Energy efficiency of the secondary heating system. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.sheating_env_eff IS 'How the secondary heating system contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.roof_description IS 'Construction of the roof: pitched with tiles, flat with felt, thatched. Includes roof-level insulation.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.roof_energy_eff IS 'How well the roof retains heat. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.roof_env_eff IS 'How the roof contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.mainheat_description IS 'Main heating system: gas boiler with radiators, electric storage heaters, heat pump, etc. Both systems included if two.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.mainheat_energy_eff IS 'Energy efficiency rating of the main heating system. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.mainheat_env_eff IS 'How the main heating system contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.mainheatcont_description IS 'Type of control(s) for main heating: programmer, room thermostat, smart control. Both included if two systems.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.mainheatc_energy_eff IS 'Energy efficiency of the main heating controls. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.mainheatc_env_eff IS 'How main heating controls contribute to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.lighting_description IS 'Type of fixed lighting based on number and type of light fittings. Focuses on low-energy bulbs (LEDs/CFLs).';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.lighting_energy_eff IS 'How efficiently the fixed lighting uses energy. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.lighting_env_eff IS 'How fixed lighting contributes to CO2 emissions. Rated very poor to very good.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.main_fuel IS 'Fuel used to power the main heating system: mains gas, electricity, heating oil, solid fuels, etc.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.wind_turbine_count IS 'Number of wind turbines on the property.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.heat_loss_corridor IS 'Internal common corridor leading to a flat/maisonette only. Either no corridor, heated corridor or unheated.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.unheated_corridor_length IS 'For flats/maisonettes only. Length of wall in metres between the flat and an unheated corridor.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.floor_height IS 'Average height of the storey in metres. Measured from finished floor level to the ceiling.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.photo_supply IS 'Whether the property generates electricity from solar panels. Proportion of roof area (%) covered. 0% means no solar panels.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.solar_water_heating_flag IS 'Whether the property uses solar panels to help heat its water (Y/N).';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.mechanical_ventilation IS 'Type of mechanical ventilation: extractor fan, positive input ventilation, or MVHR.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.address IS 'Full address combining address1, address2, and address3. Postcode recorded separately.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.local_authority_label IS 'Name of the local authority area. For reliable identification, use the local_authority ONS code.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.constituency_label IS 'Name of the UK parliamentary constituency. For reliable identification, use the constituency ONS code.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.posttown IS 'Post town of the property based on the Royal Mail address database. May differ from local authority boundaries.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.construction_age_band IS 'Period when the building was originally constructed. Different age bands may apply to extensions.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.lodgement_datetime IS 'Date and time the EPC was officially lodged on the Energy Performance of Buildings Register. Used as primary deduplication key; the record with the latest value is retained per UPRN.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.tenure IS 'Tenure type: owner-occupied, rented (social), or rented (private). Does not affect EPC calculation.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.fixed_lighting_outlets_count IS 'Number of fixed light fittings using incandescent or halogen bulbs.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.low_energy_fixed_lighting_outlets_count IS 'Number of fixed light fittings using low energy bulbs (LEDs or CFLs).';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.uprn IS 'Unique Property Reference Number. A 12-digit code identifying the property, flat, building, or plot of land. Deduplicated: one row per UPRN in this view.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.uprn_source IS 'How the UPRN was added: Energy Assessor (entered during assessment) or Address Matched (added later by address-matching system).';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.report_type IS 'Type of energy assessment: RdSAP (Reduced Standard Assessment Procedure) for existing homes, or SAP for new homes/conversions.';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.country IS 'Country where the property is located (England or Wales).';
COMMENT ON COLUMN epc_domestic_lep_deduplicated_vw.region IS 'Region where the property is located.';

-- =============================================================================
-- Non-domestic LEP deduplicated view — West of England LEP (Bristol, Bath & NES,
-- North Somerset, South Gloucestershire). One row per UPRN, most recent EPC.
-- =============================================================================

COMMENT ON VIEW epc_non_domestic_lep_deduplicated_vw IS 'Most recent non-domestic EPC per UPRN for the four West of England LEP local authorities (Bristol E06000023, Bath and NES E06000024, North Somerset E06000025, South Gloucestershire E06000022). Deduplication uses latest lodgement_datetime then latest certificate_number.';

COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.certificate_number IS 'The unique reference number for the EPC. Generated when the certificate is lodged; can retrieve the record from the EPB data API and the EPC register.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.address1 IS 'The first line of the property''s address, usually the building number and/or name and street name.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.address2 IS 'The second line of the property''s address, usually the village town or city.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.address3 IS 'The third line of the property''s address, usually the county; not always used.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.postcode IS 'The postcode of the property. Five to seven alphanumeric characters created by Royal Mail.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.asset_rating IS 'Energy Performance Asset Rating. CO2 emissions from the actual building compared to a Standard Emission Rate. (kg CO2/m2)';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.asset_rating_band IS 'Energy Performance Asset Rating converted into a linear A+ to G band (A+ most efficient, G least).';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.property_type IS 'Type of building being inspected. Based on planning use class.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.inspection_date IS 'The date when information about the building was collected to prepare the EPC.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.local_authority IS 'The local authority the building is in. Uses the official ONS code. Filtered to E06000022–E06000025 (West of England LEP).';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.constituency IS 'The UK parliamentary constituency the building is in. Uses the official ONS code.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.transaction_type IS 'States why the energy certificate was produced: sale, rental, new build, Green Deal, ECO assessment, or another reason.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.lodgement_date IS 'The date the energy certificate was added to the Energy Performance of Buildings Register.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.new_build_benchmark IS 'The benchmark value for new builds of this type of building.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.existing_stock_benchmark IS 'The benchmark value of existing stock for this type of building.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.building_level IS 'Building Complexity Level based on Energy Assessor National Occupation Standards.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.main_heating_fuel IS 'Main heating fuel: the fuel which delivers the greatest total thermal output for space or water heating.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.other_fuel_desc IS 'Text description of unspecified fuel type if Other is selected for main heating fuel.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.special_energy_uses IS 'Special energy uses discounted. Only appears on the Recommendations Report.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.renewable_sources IS 'On-site renewable energy sources. Only appears on the Advisory Report.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.floor_area IS 'Total useful floor area measured to the internal face of external walls. Given in m2.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.standard_emissions IS 'Standard Emission Rate determined by applying a fixed improvement factor to reference building emissions. (kg CO2/m2/year)';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.target_emissions IS 'Target Emission Rate determined by applying a fixed improvement factor to reference building emissions. (kg CO2/m2/year)';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.typical_emissions IS 'Typical Emission Rate for this type of building.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.building_emissions IS 'Building Emissions Rate. Annual CO2 emissions from the building. (kg CO2/m2)';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.aircon_present IS 'Whether the building has an air conditioning system.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.aircon_kw_rating IS 'Air conditioning system rating in kW.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.estimated_aircon_kw_rating IS 'Estimated total effective output rating of the air conditioning system if exact rating unknown.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.ac_inspection_commissioned IS 'AC inspection status: 1=completed, 2=commissioned, 3=not completed/commissioned, 4=not relevant, 5=don''t know.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.building_environment IS 'Building environment: the servicing strategy contributing the largest proportion of CO2 emissions.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.address IS 'Full address combining address1, address2, and address3. Postcode recorded separately.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.local_authority_label IS 'Name of the local authority area. For reliable identification, use the local_authority ONS code.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.constituency_label IS 'Name of the UK parliamentary constituency. For reliable identification, use the constituency ONS code.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.posttown IS 'Post town of the property based on the Royal Mail address database.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.lodgement_datetime IS 'Date and time the EPC was officially lodged on the Energy Performance of Buildings Register. Used as primary deduplication key; the record with the latest value is retained per UPRN.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.primary_energy_value IS 'Primary energy use displayed on the non-domestic EPC. (kWh/m2/year)';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.uprn IS 'Unique Property Reference Number. A 12-digit code identifying the property, building, or plot of land. Deduplicated: one row per UPRN in this view.';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.uprn_source IS 'How the UPRN was added: Energy Assessor (entered during assessment) or Address Matched (added later by address-matching system).';
COMMENT ON COLUMN epc_non_domestic_lep_deduplicated_vw.report_type IS 'Type of assessment: 102 = SBEM (Simplified Building Energy Model) for non-domestic buildings.';
