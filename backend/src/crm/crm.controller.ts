import { Controller, Get, Headers } from '@nestjs/common';
import { CrmService } from './crm.service';

@Controller('crm')
export class CrmController {
  constructor(private readonly service: CrmService) {}
  @Get('leads') leads(@Headers('x-organization-id') organizationId: string) { return this.service.listLeads(organizationId); }
  @Get('opportunities') opportunities(@Headers('x-organization-id') organizationId: string) { return this.service.listOpportunities(organizationId); }
  @Get('requirements') requirements(@Headers('x-organization-id') organizationId: string) { return this.service.listRequirements(organizationId); }
  @Get('activities') activities(@Headers('x-organization-id') organizationId: string) { return this.service.listActivities(organizationId); }
}