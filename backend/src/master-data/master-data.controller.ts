import { Controller, Get, Headers } from '@nestjs/common';
import { MasterDataService } from './master-data.service';

@Controller('master-data')
export class MasterDataController {
  constructor(private readonly service: MasterDataService) {}
  @Get('uoms') uoms() { return this.service.listUoms(); }
  @Get('customers') customers(@Headers('x-organization-id') organizationId: string) { return this.service.listCustomers(organizationId); }
  @Get('suppliers') suppliers(@Headers('x-organization-id') organizationId: string) { return this.service.listSuppliers(organizationId); }
  @Get('items') items(@Headers('x-organization-id') organizationId: string) { return this.service.listItems(organizationId); }
  @Get('warehouses') warehouses(@Headers('x-organization-id') organizationId: string) { return this.service.listWarehouses(organizationId); }
}