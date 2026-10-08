import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
@Injectable()
export class OrganizationService {
  constructor(private readonly db: DatabaseService) {}
  async getById(id: string) { const r=await this.db.query('SELECT id, code, name, legal_name, currency_code, timezone, is_active FROM organizations WHERE id=$1',[id]); return r.rows[0] ?? null; }
  async listBranches(organizationId: string) { const r=await this.db.query('SELECT id, code, name, is_active FROM branches WHERE organization_id=$1 ORDER BY code',[organizationId]); return r.rows; }
}