import { Injectable, UnauthorizedException } from '@nestjs/common';
import { DatabaseService } from '../database/database.service';
@Injectable()
export class AuthService {
  constructor(private readonly db: DatabaseService) {}
  async findUserByEmail(organizationId: string, email: string) {
    const result = await this.db.query('SELECT id, organization_id, email, display_name, password_hash, is_active FROM users WHERE organization_id=$1 AND email=$2', [organizationId, email.toLowerCase().trim()]);
    if (!result.rowCount || !result.rows[0].is_active) throw new UnauthorizedException('Invalid credentials');
    return result.rows[0];
  }
}