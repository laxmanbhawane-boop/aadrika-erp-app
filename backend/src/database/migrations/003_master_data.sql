CREATE TABLE IF NOT EXISTS units_of_measure (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), code VARCHAR(30) NOT NULL UNIQUE, name VARCHAR(80) NOT NULL, category VARCHAR(40) NOT NULL, decimal_places SMALLINT NOT NULL DEFAULT 3, is_active BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE IF NOT EXISTS tax_codes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), code VARCHAR(30) NOT NULL UNIQUE, name VARCHAR(100) NOT NULL, cgst_rate NUMERIC(7,3) NOT NULL DEFAULT 0, sgst_rate NUMERIC(7,3) NOT NULL DEFAULT 0, igst_rate NUMERIC(7,3) NOT NULL DEFAULT 0, cess_rate NUMERIC(7,3) NOT NULL DEFAULT 0, is_active BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE IF NOT EXISTS warehouses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id), branch_id UUID NOT NULL REFERENCES branches(id), code VARCHAR(30) NOT NULL, name VARCHAR(120) NOT NULL, address TEXT, is_active BOOLEAN NOT NULL DEFAULT TRUE, UNIQUE(organization_id, code)
);
CREATE TABLE IF NOT EXISTS parties (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id), code VARCHAR(40) NOT NULL, legal_name VARCHAR(200) NOT NULL, display_name VARCHAR(150) NOT NULL, party_type VARCHAR(20) NOT NULL, gstin VARCHAR(20), pan VARCHAR(20), email VARCHAR(320), phone VARCHAR(40), payment_terms_days INTEGER NOT NULL DEFAULT 0, credit_limit NUMERIC(18,2) NOT NULL DEFAULT 0, is_active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), UNIQUE(organization_id, code)
);
CREATE TABLE IF NOT EXISTS party_addresses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), party_id UUID NOT NULL REFERENCES parties(id) ON DELETE CASCADE, address_type VARCHAR(30) NOT NULL, line1 VARCHAR(200) NOT NULL, line2 VARCHAR(200), city VARCHAR(100), state VARCHAR(100), postal_code VARCHAR(20), country VARCHAR(80) NOT NULL DEFAULT 'India', is_default BOOLEAN NOT NULL DEFAULT FALSE
);
CREATE TABLE IF NOT EXISTS materials (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id), code VARCHAR(50) NOT NULL, name VARCHAR(160) NOT NULL, material_type VARCHAR(50) NOT NULL, base_uom_id UUID NOT NULL REFERENCES units_of_measure(id), hsn_code VARCHAR(20), tax_code_id UUID REFERENCES tax_codes(id), gsm NUMERIC(10,3), specification JSONB NOT NULL DEFAULT '{}'::jsonb, is_active BOOLEAN NOT NULL DEFAULT TRUE, UNIQUE(organization_id, code)
);
CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id), code VARCHAR(50) NOT NULL, name VARCHAR(160) NOT NULL, product_type VARCHAR(50) NOT NULL, sales_uom_id UUID NOT NULL REFERENCES units_of_measure(id), hsn_code VARCHAR(20), tax_code_id UUID REFERENCES tax_codes(id), specification JSONB NOT NULL DEFAULT '{}'::jsonb, is_active BOOLEAN NOT NULL DEFAULT TRUE, UNIQUE(organization_id, code)
);
CREATE TABLE IF NOT EXISTS machines (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id), branch_id UUID NOT NULL REFERENCES branches(id), code VARCHAR(50) NOT NULL, name VARCHAR(160) NOT NULL, machine_type VARCHAR(80) NOT NULL, work_centre VARCHAR(80), capacity_per_hour NUMERIC(18,4), capacity_uom_id UUID REFERENCES units_of_measure(id), is_active BOOLEAN NOT NULL DEFAULT TRUE, UNIQUE(organization_id, code)
);
CREATE TABLE IF NOT EXISTS processes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id), code VARCHAR(50) NOT NULL, name VARCHAR(120) NOT NULL, process_type VARCHAR(50) NOT NULL, is_active BOOLEAN NOT NULL DEFAULT TRUE, UNIQUE(organization_id, code)
);
CREATE INDEX IF NOT EXISTS idx_parties_org_type ON parties(organization_id, party_type);
CREATE INDEX IF NOT EXISTS idx_materials_org_type ON materials(organization_id, material_type);
CREATE INDEX IF NOT EXISTS idx_products_org_type ON products(organization_id, product_type);
