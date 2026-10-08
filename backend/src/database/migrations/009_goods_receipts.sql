CREATE TABLE IF NOT EXISTS goods_receipts (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id), branch_id UUID NOT NULL REFERENCES branches(id),
 grn_no VARCHAR(50) NOT NULL, purchase_order_id UUID NOT NULL REFERENCES purchase_orders(id), status VARCHAR(30) NOT NULL DEFAULT 'DRAFT',
 receipt_date DATE NOT NULL DEFAULT CURRENT_DATE, idempotency_key VARCHAR(120) NOT NULL, received_by UUID REFERENCES users(id),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), UNIQUE(organization_id,grn_no), UNIQUE(organization_id,idempotency_key)
);
CREATE TABLE IF NOT EXISTS goods_receipt_lines (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), goods_receipt_id UUID NOT NULL REFERENCES goods_receipts(id) ON DELETE CASCADE, purchase_order_line_id UUID NOT NULL REFERENCES purchase_order_lines(id), item_id UUID NOT NULL REFERENCES items(id),
 warehouse_id UUID NOT NULL REFERENCES warehouses(id), location_id UUID REFERENCES stock_locations(id), uom_id UUID NOT NULL REFERENCES uoms(id),
 received_quantity NUMERIC(20,6) NOT NULL, accepted_quantity NUMERIC(20,6) NOT NULL DEFAULT 0,
 rejected_quantity NUMERIC(20,6) NOT NULL DEFAULT 0, hold_quantity NUMERIC(20,6) NOT NULL DEFAULT 0, unit_cost NUMERIC(20,6) NOT NULL,
 CHECK(received_quantity>0), CHECK(accepted_quantity>=0), CHECK(rejected_quantity>=0), CHECK(hold_quantity>=0),
 CHECK(accepted_quantity+rejected_quantity+hold_quantity=received_quantity), CHECK(unit_cost>=0)
);
CREATE INDEX IF NOT EXISTS idx_grn_po ON goods_receipts(purchase_order_id,receipt_date DESC);
