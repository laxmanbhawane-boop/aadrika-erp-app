import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './database/database.module';
import { HealthModule } from './health/health.module';
import { HttpModule } from './common/http/http.module';
@Module({ imports: [ConfigModule.forRoot({ isGlobal: true, envFilePath: ['.env', '.env.local'] }), DatabaseModule, HttpModule, HealthModule] })
export class AppModule {}