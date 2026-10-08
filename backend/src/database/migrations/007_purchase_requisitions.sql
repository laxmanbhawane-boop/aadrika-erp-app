CREATE TABLE IF NOT EXISTS purchase_requisitions (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id),
 branch_id UUID NOT NULL REFERENCES branches(id), requisition_no VARCHAR(50) NOT NULL,
 status VARCHAR(30) NOT NULL DEFAULT 'DRAFT', requested_by UUID NOT NULL REFERENCES users(id),
 needed_by DATE, purpose TEXT, created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 UNIQUE(organization_id,requisition_no)
);
CREATE TABLE IF NOT EXISTS purchase_requisition_lines (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), requisition_id UUID NOT NULL REFERENCES purchase_requisitions(id) ON DELETE CASCADE,
 item_id UUID NOT NULL REFERENCES items(id), quantity NUMERIC(20,6) NOT NULL, uom_id UUID NOT NULL REFERENCES uoms(id),
 warehouse_id UUID REFERENCES warehouses(id), specification TEXT, CHECK(quantity>0)
);
CREATE TABLE IF NOT EXISTS purchase_requisition_approvals (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(), requisition_id UUID NOT NULL REFERENCES purchase_requisitions(id) ON DELETE CASCADE,
 approver_user_id UUID NOT NULL REFERENCES users(id), action VARCHAR(30) NOT NULL, remarks TEXT, acted_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_pr_org_status ON purchase_requisitions(organization_id,status,created_at DESC);
