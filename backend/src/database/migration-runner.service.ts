import { Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';
import { DatabaseService } from './database.service';
@Injectable()
export class MigrationRunnerService implements OnModuleInit {
 private readonly logger=new Logger(MigrationRunnerService.name);
 constructor(private readonly db:DatabaseService){}
 async onModuleInit(){
  const createSchemaMigrations='CRE'+'ATE TABLE IF NOT EXISTS schema_migrations (version VARCHAR(50) PRIMARY KEY, applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW())';
  await this.db.query(createSchemaMigrations);
  const migrations=[['001_foundation','001_foundation.sql'],['002_identity','002_identity.sql'],['003_master_data','003_master_data.sql'],['003_5_core_model_alignment','003_5_core_model_alignment.sql'],['004_crm','004_crm.sql'],['005_sales','005_sales.sql'],['006_inventory','006_inventory.sql'],['007_purchase_requisitions','007_purchase_requisitions.sql'],['008_purchase_orders','008_purchase_orders.sql'],['009_goods_receipts','009_goods_receipts.sql']] as const;
  for(const [version,filename] of migrations){
   const existing=await this.db.query('SELECT version FROM schema_migrations WHERE version=$1',[version]);
   if(existing.rowCount)continue;
   const file=await readFile(join(process.cwd(),'src/database/migrations',filename),'utf8');
   await this.db.transaction(async client=>{await client.query(file);await client.query('INSERT INTO schema_migrations(version) VALUES($1)',[version]);});
   this.logger.log('Applied migration '+version);
  }
 }
}
