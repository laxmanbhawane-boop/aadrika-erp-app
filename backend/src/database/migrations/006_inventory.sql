CREATE TABLE IF NOT EXISTS stock_locations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id),
  warehouse_id UUID NOT NULL REFERENCES warehouses(id), code VARCHAR(40) NOT NULL, name VARCHAR(120) NOT NULL,
  location_type VARCHAR(30) NOT NULL DEFAULT 'BIN', is_active BOOLEAN NOT NULL DEFAULT TRUE,
  UNIQUE(organization_id,warehouse_id,code)
);
CREATE TABLE IF NOT EXISTS stock_balances (
  organization_id UUID NOT NULL REFERENCES organizations(id), item_id UUID NOT NULL REFERENCES items(id),
  warehouse_id UUID NOT NULL REFERENCES warehouses(id), location_id UUID REFERENCES stock_locations(id),
  quantity NUMERIC(20,6) NOT NULL DEFAULT 0, reserved_quantity NUMERIC(20,6) NOT NULL DEFAULT 0,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), PRIMARY KEY(item_id,warehouse_id,location_id)
);
CREATE TABLE IF NOT EXISTS inventory_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id),
  item_id UUID NOT NULL REFERENCES items(id), warehouse_id UUID NOT NULL REFERENCES warehouses(id),
  location_id UUID REFERENCES stock_locations(id), transaction_type VARCHAR(40) NOT NULL,
  quantity NUMERIC(20,6) NOT NULL, uom_id UUID NOT NULL REFERENCES uoms(id),
  unit_cost NUMERIC(20,6) NOT NULL DEFAULT 0, reference_type VARCHAR(50), reference_id UUID,
  batch_no VARCHAR(80), serial_no VARCHAR(120), created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), CHECK(quantity <> 0), CHECK(unit_cost >= 0)
);
CREATE INDEX IF NOT EXISTS idx_inventory_tx_item ON inventory_transactions(organization_id,item_id,created_at DESC);
CREATE INDEX IF NOT EXISTS idx_inventory_tx_ref ON inventory_transactions(reference_type,reference_id);