import { Injectable } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';

@Injectable()
export class CrmService {
  constructor(private readonly db: DatabaseService) {}

  async listLeads(organizationId: string) {
    return (await this.db.query(
      'SELECT id,code,company_name,contact_name,email,phone,source,status,assigned_user_id,created_at FROM crm_leads WHERE organization_id=$1 ORDER BY created_at DESC',
      [organizationId],
    )).rows;
  }

  async listOpportunities(organizationId: string) {
    return (await this.db.query(
      'SELECT id,code,name,customer_id,lead_id,stage,expected_value,probability,expected_close_date,assigned_user_id FROM crm_opportunities WHERE organization_id=$1 ORDER BY created_at DESC',
      [organizationId],
    )).rows;
  }

  async listRequirements(organizationId: string) {
    return (await this.db.query(
      'SELECT id,title,opportunity_id,customer_id,description,quantity,uom_id,target_date,status FROM crm_requirements WHERE organization_id=$1 ORDER BY created_at DESC',
      [organizationId],
    )).rows;
  }

  async listActivities(organizationId: string) {
    return (await this.db.query(
      'SELECT id,activity_type,subject,lead_id,opportunity_id,customer_id,due_at,completed_at,assigned_user_id FROM crm_activities WHERE organization_id=$1 ORDER BY due_at NULLS LAST,created_at DESC',
      [organizationId],
    )).rows;
  }
}