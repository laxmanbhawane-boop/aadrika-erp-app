ALTER TABLE IF EXISTS units_of_measure RENAME TO uoms;
CREATE OR REPLACE VIEW units_of_measure AS SELECT id,code,name,category,decimal_places,is_active FROM uoms;
CREATE TABLE IF NOT EXISTS items (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id UUID NOT NULL REFERENCES organizations(id),
 code VARCHAR(50) NOT NULL, name VARCHAR(160) NOT NULL, item_type VARCHAR(40) NOT NULL,
 base_uom_id UUID NOT NULL REFERENCES uoms(id), hsn_code VARCHAR(20), tax_code_id UUID REFERENCES tax_codes(id),
 is_active BOOLEAN NOT NULL DEFAULT TRUE, UNIQUE(organization_id,code)
);
INSERT INTO items(id,organization_id,code,name,item_type,base_uom_id,hsn_code,tax_code_id,is_active)
SELECT id,organization_id,code,name,'MATERIAL',base_uom_id,hsn_code,tax_code_id,is_active FROM materials ON CONFLICT(id) DO NOTHING;
INSERT INTO items(id,organization_id,code,name,item_type,base_uom_id,hsn_code,tax_code_id,is_active)
SELECT id,organization_id,code,name,'PRODUCT',sales_uom_id,hsn_code,tax_code_id,is_active FROM products ON CONFLICT(id) DO NOTHING;
ALTER TABLE materials ADD CONSTRAINT fk_materials_item_identity FOREIGN KEY(id) REFERENCES items(id);
ALTER TABLE products ADD CONSTRAINT fk_products_item_identity FOREIGN KEY(id) REFERENCES items(id);
