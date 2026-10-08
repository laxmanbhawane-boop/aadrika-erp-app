import { Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { readFile } from 'node:fs/promises';
import { join } from 'node:path';
import { DatabaseService } from './database.service';
@Injectable()
export class MigrationRunnerService implements OnModuleInit {
  private readonly logger = new Logger(MigrationRunnerService.name);
  constructor(private readonly db: DatabaseService) {}
  async onModuleInit() {
    await this.db.query('CREATE TABLE IF NOT EXISTS schema_migrations (version VARCHAR(50) PRIMARY KEY, applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW())');
    const version = '001_foundation';
    const existing = await this.db.query('SELECT version FROM schema_migrations WHERE version = $1', [version]);
    if (existing.rowCount) return;
    const sql = await readFile(join(process.cwd(), 'src/database/migrations/001_foundation.sql'), 'utf8');
    await this.db.transaction(async client => { await client.query(sql); await client.query('INSERT INTO schema_migrations(version) VALUES ($1)', [version]); });
    this.logger.log('Applied migration 001_foundation');
  }
}