CREATE TABLE IF NOT EXISTS quotations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id),
  quotation_no VARCHAR(50) NOT NULL, customer_id UUID NOT NULL REFERENCES customers(id),
  status VARCHAR(30) NOT NULL DEFAULT 'DRAFT', quotation_date DATE NOT NULL DEFAULT CURRENT_DATE,
  valid_until DATE, currency_code CHAR(3) NOT NULL DEFAULT 'INR', subtotal NUMERIC(18,2) NOT NULL DEFAULT 0,
  discount_total NUMERIC(18,2) NOT NULL DEFAULT 0, tax_total NUMERIC(18,2) NOT NULL DEFAULT 0,
  grand_total NUMERIC(18,2) NOT NULL DEFAULT 0, created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(organization_id,quotation_no)
);
CREATE TABLE IF NOT EXISTS quotation_lines (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), quotation_id UUID NOT NULL REFERENCES quotations(id) ON DELETE CASCADE,
  item_id UUID NOT NULL REFERENCES items(id), description VARCHAR(300), quantity NUMERIC(18,3) NOT NULL,
  uom_id UUID NOT NULL REFERENCES uoms(id), unit_price NUMERIC(18,4) NOT NULL,
  discount_amount NUMERIC(18,2) NOT NULL DEFAULT 0, tax_code_id UUID REFERENCES tax_codes(id),
  tax_amount NUMERIC(18,2) NOT NULL DEFAULT 0, line_total NUMERIC(18,2) NOT NULL DEFAULT 0,
  CHECK(quantity > 0), CHECK(unit_price >= 0)
);
CREATE TABLE IF NOT EXISTS sales_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), organization_id UUID NOT NULL REFERENCES organizations(id),
  order_no VARCHAR(50) NOT NULL, quotation_id UUID REFERENCES quotations(id), customer_id UUID NOT NULL REFERENCES customers(id),
  status VARCHAR(30) NOT NULL DEFAULT 'DRAFT', order_date DATE NOT NULL DEFAULT CURRENT_DATE,
  subtotal NUMERIC(18,2) NOT NULL DEFAULT 0, tax_total NUMERIC(18,2) NOT NULL DEFAULT 0,
  grand_total NUMERIC(18,2) NOT NULL DEFAULT 0, created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(organization_id,order_no)
);
CREATE TABLE IF NOT EXISTS sales_order_lines (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(), sales_order_id UUID NOT NULL REFERENCES sales_orders(id) ON DELETE CASCADE,
  item_id UUID NOT NULL REFERENCES items(id), quantity NUMERIC(18,3) NOT NULL, uom_id UUID NOT NULL REFERENCES uoms(id),
  unit_price NUMERIC(18,4) NOT NULL, tax_code_id UUID REFERENCES tax_codes(id), tax_amount NUMERIC(18,2) NOT NULL DEFAULT 0,
  line_total NUMERIC(18,2) NOT NULL DEFAULT 0, CHECK(quantity > 0), CHECK(unit_price >= 0)
);
CREATE INDEX IF NOT EXISTS idx_quotes_customer ON quotations(organization_id,customer_id);
CREATE INDEX IF NOT EXISTS idx_orders_customer ON sales_orders(organization_id,customer_id);