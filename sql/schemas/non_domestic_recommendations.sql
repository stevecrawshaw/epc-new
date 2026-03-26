-- Schema for non-domestic EPC recommendations
-- Column order matches CSV header from bulk download files
CREATE TABLE IF NOT EXISTS non_domestic_recommendations (
    certificate_number VARCHAR,
    payback_type VARCHAR,
    recommendation_item INTEGER,
    related_certificate_number VARCHAR,
    recommendation_code VARCHAR,
    recommendation VARCHAR
);
