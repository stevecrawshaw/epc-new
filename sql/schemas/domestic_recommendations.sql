-- Schema for domestic EPC recommendations
-- Column order matches CSV header from bulk download files
CREATE TABLE IF NOT EXISTS domestic_recommendations (
    certificate_number VARCHAR,
    improvement_item INTEGER,
    improvement_id VARCHAR,
    indicative_cost VARCHAR,
    improvement_summary_text VARCHAR,
    improvement_descr_text VARCHAR
);
