import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';

@Injectable()
export class MasterDataService {
  constructor(private readonly db: DatabaseService) {}

  async listParties(organizationId: string, partyType?: string) {
    const sql = partyType ? 'SELECT * FROM parties WHERE organization_id=$1 AND party_type=$2 AND is_active=true ORDER BY display_name' : 'SELECT * FROM parties WHERE organization_id=$1 AND is_active=true ORDER BY display_name';
    const params = partyType ? [organizationId, partyType] : [organizationId];
    return (await this.db.query(sql, params)).rows;
  }

  async listMaterials(organizationId: string) {
    return (await this.db.query('SELECT * FROM materials WHERE organization_id=$1 AND is_active=true ORDER BY name', [organizationId])).rows;
  }

  async listProducts(organizationId: string) {
    return (await this.db.query('SELECT * FROM products WHERE organization_id=$1 AND is_active=true ORDER BY name', [organizationId])).rows;
  }

  async listWarehouses(organizationId: string) {
    return (await this.db.query('SELECT * FROM warehouses WHERE organization_id=$1 AND is_active=true ORDER BY name', [organizationId])).rows;
  }

  async listMachines(organizationId: string) {
    return (await this.db.query('SELECT * FROM machines WHERE organization_id=$1 AND is_active=true ORDER BY name', [organizationId])).rows;
  }

  async listProcesses(organizationId: string) {
    return (await this.db.query('SELECT * FROM processes WHERE organization_id=$1 AND is_active=true ORDER BY name', [organizationId])).rows;
  }
}