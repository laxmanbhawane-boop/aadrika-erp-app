import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './database/database.module';
import { HealthModule } from './health/health.module';
import { HttpModule } from './common/http/http.module';
import { AuthModule } from './auth/auth.module';
import { OrganizationModule } from './organization/organization.module';
import { MasterDataModule } from './master-data/master-data.module';
import { CrmModule } from './crm/crm.module';
import { SalesModule } from './sales/sales.module';
import { InventoryModule } from './inventory/inventory.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true, envFilePath: ['.env', '.env.local'] }),
    DatabaseModule, HttpModule, AuthModule, OrganizationModule, MasterDataModule, CrmModule, SalesModule, InventoryModule, HealthModule,
  ],
})
export class AppModule {}