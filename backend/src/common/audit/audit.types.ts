export type AuditAction = 'CREATE' | 'UPDATE' | 'DELETE' | 'APPROVE' | 'REJECT' | 'POST' | 'CANCEL' | 'LOGIN' | 'LOGOUT';

export interface AuditEvent {
  tenantId: string;
  actorUserId: string;
  action: AuditAction;
  entityType: string;
  entityId: string;
  before?: unknown;
  after?: unknown;
  metadata?: Record<string, unknown>;
  occurredAt: string;
}