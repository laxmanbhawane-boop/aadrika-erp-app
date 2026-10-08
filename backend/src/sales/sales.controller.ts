import { Controller,Get,Headers } from '@nestjs/common';
import { SalesService } from './sales.service';
@Controller('sales')
export class SalesController {
 constructor(private readonly service:SalesService){}
 @Get('quotations') quotations(@Headers('x-organization-id') organizationId:string){return this.service.listQuotations(organizationId);}
 @Get('orders') orders(@Headers('x-organization-id') organizationId:string){return this.service.listOrders(organizationId);}
}