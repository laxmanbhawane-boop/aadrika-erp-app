import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';

@Injectable()
export class MasterDataService {
  constructor(private readonly db: DatabaseService) {}
  async listParties(organizationId:string, partyType?:string){const q=partyType?'SELECT * FROM parties WHERE organization_id=$1 AND party_type=$2 AND is_active=true ORDER BY display_name':'SELECT * FROM parties WHERE organization_id=$1 AND is_active=true ORDER BY display_name';return (await this.db.query(q,partyType?[organizationId,partyType]:[organizationId])).rows;}
  async listMaterials(organizationId:string){return (await this.db.query('SELECT * FROM materials WHERE organization_id=$1 AND is_active=true ORDER BY name',[organizationId])).rows;}
  async listProducts(organizationId:string){return (await this.db.query('SELECT * FROM products WHERE organization_id=$1 AND is_active=true ORDER BY name',[organizationId])).rows;}
  async listWarehouses(organizationId:string){return (await this.db.query('SELECT * FROM warehouses WHERE organization_id=$1 AND is_active=true ORDER BY name',[organizationId])).rows;}
  async listMachines(organizationId:string){return (await this.db.query('SELECT * FROM machines WHERE organization_id=$1 AND is_active=true ORDER BY name',[organizationId])).rows;}
  async listProcesses(organizationId:string){return (await this.db.query('SELECT * FROM processes WHERE organization_id=$1 AND is_active=true ORDER BY name',[organizationId])).rows;}
  async listUoms(){return (await this.db.query('SELECT id,code,name,category,decimal_places FROM units_of_measure WHERE is_active=true ORDER BY code')).rows;}
  async listTaxCodes(){return (await this.db.query('SELECT id,code,name,cgst_rate,sgst_rate,igst_rate,cess_rate FROM tax_codes WHERE is_active=true ORDER BY code')).rows;}
}