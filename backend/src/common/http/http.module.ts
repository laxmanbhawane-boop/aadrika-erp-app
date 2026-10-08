import { Global, MiddlewareConsumer, Module } from '@nestjs/common';
import { RequestIdMiddleware } from './request-id.middleware';
@Global()
@Module({})
export class HttpModule { configure(consumer: MiddlewareConsumer) { consumer.apply(RequestIdMiddleware).forRoutes('*'); } }