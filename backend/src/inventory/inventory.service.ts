import { BadRequestException, Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';

@Injectable()
export class InventoryService {
  constructor(private readonly db: DatabaseService) {}
  async getBalance(organizationId:string,itemId:string,warehouseId:string){
    return (await this.db.query('SELECT item_id,warehouse_id,location_id,quantity,reserved_quantity FROM stock_balances WHERE organization_id=$1 AND item_id=$2 AND warehouse_id=$3',[organizationId,itemId,warehouseId])).rows;
  }
  async listTransactions(organizationId:string){
    return (await this.db.query('SELECT id,item_id,warehouse_id,location_id,transaction_type,quantity,uom_id,unit_cost,reference_type,reference_id,batch_no,serial_no,created_at FROM inventory_transactions WHERE organization_id=$1 ORDER BY created_at DESC',[organizationId])).rows;
  }
  async postTransaction(input:{organizationId:string,itemId:string,warehouseId:string,locationId?:string,transactionType:string,quantity:number,uomId:string,unitCost?:number,referenceType?:string,referenceId?:string,createdBy?:string}){
    if(input.quantity===0) throw new BadRequestException('Inventory quantity cannot be zero');
    if((input.unitCost ?? 0)<0) throw new BadRequestException('Inventory unit cost cannot be negative');
    return this.db.transaction(async client=>{
      const result=await client.query('INSERT INTO inventory_transactions(organization_id,item_id,warehouse_id,location_id,transaction_type,quantity,uom_id,unit_cost,reference_type,reference_id,created_by) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11) RETURNING *',[input.organizationId,input.itemId,input.warehouseId,input.locationId??null,input.transactionType,input.quantity,input.uomId,input.unitCost??0,input.referenceType??null,input.referenceId??null,input.createdBy??null]);
      await client.query('INSERT INTO stock_balances(organization_id,item_id,warehouse_id,location_id,quantity,updated_at) VALUES($1,$2,$3,$4,$5,NOW()) ON CONFLICT(item_id,warehouse_id,location_id) DO UPDATE SET quantity=stock_balances.quantity+EXCLUDED.quantity,updated_at=NOW()',[input.organizationId,input.itemId,input.warehouseId,input.locationId??null,input.quantity]);
      return result.rows[0];
    });
  }
}