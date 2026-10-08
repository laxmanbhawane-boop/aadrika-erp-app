CREATE TABLE IF NOT EXISTS purchase_orders (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id),
 branch_id UUID NOT NULL REFERENCES branches(id), po_no VARCHAR(50) NOT NULL, revision_no INTEGER NOT NULL DEFAULT 1,
 previous_revision_id UUID REFERENCES purchase_orders(id), supplier_id UUID NOT NULL REFERENCES parties(id),
 requisition_id UUID REFERENCES purchase_requisitions(id), status VARCHAR(30) NOT NULL DEFAULT 'DRAFT',
 order_date DATE NOT NULL DEFAULT CURRENT_DATE, expected_date DATE, currency_code CHAR(3) NOT NULL DEFAULT 'INR',
 subtotal NUMERIC(18,2) NOT NULL DEFAULT 0, discount_total NUMERIC(18,2) NOT NULL DEFAULT 0,
 freight_amount NUMERIC(18,2) NOT NULL DEFAULT 0, tax_total NUMERIC(18,2) NOT NULL DEFAULT 0, grand_total NUMERIC(18,2) NOT NULL DEFAULT 0,
 created_by UUID REFERENCES users(id), created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 UNIQUE(organization_id,po_no,revision_no), CHECK(revision_no>0), CHECK(grand_total>=0)
);
CREATE TABLE IF NOT EXISTS purchase_order_lines (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), purchase_order_id UUID NOT NULL REFERENCES purchase_orders(id) ON DELETE CASCADE,
 item_id UUID NOT NULL REFERENCES items(id), quantity NUMERIC(20,6) NOT NULL, uom_id UUID NOT NULL REFERENCES uoms(id),
 unit_rate NUMERIC(20,6) NOT NULL, discount_amount NUMERIC(18,2) NOT NULL DEFAULT 0, tax_code_id UUID REFERENCES tax_codes(id),
 tax_amount NUMERIC(18,2) NOT NULL DEFAULT 0, line_total NUMERIC(18,2) NOT NULL DEFAULT 0,
 CHECK(quantity>0), CHECK(unit_rate>=0), CHECK(discount_amount>=0), CHECK(line_total>=0)
);
CREATE TABLE IF NOT EXISTS purchase_order_approvals (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), purchase_order_id UUID NOT NULL REFERENCES purchase_orders(id) ON DELETE CASCADE, approver_user_id UUID NOT NULL REFERENCES users(id), action VARCHAR(30) NOT NULL, remarks TEXT, acted_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_po_org_supplier ON purchase_orders(organization_id,supplier_id,order_date DESC);
