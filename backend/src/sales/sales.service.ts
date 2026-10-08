import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';

@Injectable()
export class SalesService {
  constructor(private readonly db: DatabaseService) {}
  async listQuotations(organizationId:string){return (await this.db.query('SELECT id,quotation_no,customer_id,status,quotation_date,valid_until,subtotal,discount_total,tax_total,grand_total FROM quotations WHERE organization_id=$1 ORDER BY quotation_date DESC,created_at DESC',[organizationId])).rows;}
  async listOrders(organizationId:string){return (await this.db.query('SELECT id,order_no,quotation_id,customer_id,status,order_date,subtotal,tax_total,grand_total FROM sales_orders WHERE organization_id=$1 ORDER BY order_date DESC,created_at DESC',[organizationId])).rows;}
}