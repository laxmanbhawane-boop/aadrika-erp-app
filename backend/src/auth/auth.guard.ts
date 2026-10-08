import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';
@Injectable()
export class AuthGuard implements CanActivate {
  canActivate(context: ExecutionContext) {
    const request=context.switchToHttp().getRequest<{headers:Record<string,string|undefined>}>();
    if (!request.headers.authorization?.startsWith('Bearer ')) throw new UnauthorizedException('Authentication required');
    return true;
  }
}