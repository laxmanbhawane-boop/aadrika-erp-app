import 'reflect-metadata';
import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import helmet from 'helmet';
import { AppModule } from './app.module';
import { GlobalExceptionFilter } from './common/http/global-exception.filter';
async function bootstrap() { const app = await NestFactory.create(AppModule); app.use(helmet()); app.setGlobalPrefix(process.env.API_PREFIX ?? 'api/v1'); app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true, forbidUnknownValues: true })); app.useGlobalFilters(new GlobalExceptionFilter()); await app.listen(Number(process.env.PORT ?? 3000)); }
bootstrap();