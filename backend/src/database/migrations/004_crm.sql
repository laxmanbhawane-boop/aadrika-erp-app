CREATE TABLE IF NOT EXISTS crm_leads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  code VARCHAR(40) NOT NULL,
  company_name VARCHAR(200),
  contact_name VARCHAR(150) NOT NULL,
  email VARCHAR(320),
  phone VARCHAR(30),
  source VARCHAR(60),
  status VARCHAR(30) NOT NULL DEFAULT 'NEW',
  assigned_user_id UUID REFERENCES users(id),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(organization_id, code)
);
CREATE TABLE IF NOT EXISTS crm_opportunities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  customer_id UUID REFERENCES customers(id),
  lead_id UUID REFERENCES crm_leads(id),
  code VARCHAR(40) NOT NULL,
  name VARCHAR(200) NOT NULL,
  stage VARCHAR(40) NOT NULL DEFAULT 'QUALIFICATION',
  expected_value NUMERIC(18,2) NOT NULL DEFAULT 0,
  probability NUMERIC(5,2) NOT NULL DEFAULT 0,
  expected_close_date DATE,
  assigned_user_id UUID REFERENCES users(id),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(organization_id, code)
);
CREATE TABLE IF NOT EXISTS crm_requirements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  opportunity_id UUID REFERENCES crm_opportunities(id),
  customer_id UUID REFERENCES customers(id),
  title VARCHAR(200) NOT NULL,
  description TEXT,
  quantity NUMERIC(18,3),
  uom_id UUID REFERENCES uoms(id),
  target_date DATE,
  status VARCHAR(30) NOT NULL DEFAULT 'OPEN',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS crm_activities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  organization_id UUID NOT NULL REFERENCES organizations(id),
  lead_id UUID REFERENCES crm_leads(id),
  opportunity_id UUID REFERENCES crm_opportunities(id),
  customer_id UUID REFERENCES customers(id),
  activity_type VARCHAR(30) NOT NULL,
  subject VARCHAR(200) NOT NULL,
  notes TEXT,
  due_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  assigned_user_id UUID REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_crm_leads_org_status ON crm_leads(organization_id,status);
CREATE INDEX IF NOT EXISTS idx_crm_opp_org_stage ON crm_opportunities(organization_id,stage);
CREATE INDEX IF NOT EXISTS idx_crm_req_opp ON crm_requirements(opportunity_id);
CREATE INDEX IF NOT EXISTS idx_crm_activity_due ON crm_activities(organization_id,due_at);