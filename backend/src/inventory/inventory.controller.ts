import { Body, Controller, Get, Headers, Param, Post } from '@nestjs/common';
import { InventoryService } from './inventory.service';

@Controller('inventory')
export class InventoryController {
 constructor(private readonly service:InventoryService){}
 @Get('transactions') transactions(@Headers('x-organization-id') organizationId:string){return this.service.listTransactions(organizationId);}
 @Get('balance/:itemId/:warehouseId') balance(@Headers('x-organization-id') organizationId:string,@Param('itemId') itemId:string,@Param('warehouseId') warehouseId:string){return this.service.getBalance(organizationId,itemId,warehouseId);}
 @Post('transactions') post(@Headers('x-organization-id') organizationId:string,@Body() body:any){return this.service.postTransaction({...body,organizationId});}
}