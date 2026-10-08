import { randomUUID } from 'node:crypto';
import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
@Injectable()
export class RequestIdMiddleware implements NestMiddleware { use(req: Request, res: Response, next: NextFunction) { const requestId = req.header('x-request-id') ?? randomUUID(); res.setHeader('x-request-id', requestId); (req as Request & { requestId?: string }).requestId = requestId; next(); } }