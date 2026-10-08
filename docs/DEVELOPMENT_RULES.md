# V2 Development Rules

1. Do not modify the original repository.
2. Work on v2-development until a release is approved.
3. Build domain services before duplicate UI logic.
4. Every business transaction must have an immutable audit trail.
5. Inventory is ledger/transaction based; never silently overwrite stock.
6. Financial values use decimal-safe monetary types.
7. Missing master/rate/tax data produces an explicit validation error, never zero.
8. Server-side authorization is mandatory.
9. Database migrations are forward-only and versioned.
10. Estimated and actual costing share one costing model.
11. Production, inventory, QC, scrap and costing must reconcile.
12. All important operations must be idempotent.
13. Attachments and documents require versioning and access control.
14. Tests are required for costing, tax, inventory and financial posting rules.
15. No module is considered complete when it is only a screen/mock.
