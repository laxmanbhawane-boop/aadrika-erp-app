import { Controller, Get } from '@nestjs/common';

@Controller('health')
export class HealthController {
  @Get()
  check() {
    return { status: 'ok', service: 'aadrika-erp-v2-api', timestamp: new Date().toISOString() };
  }
}