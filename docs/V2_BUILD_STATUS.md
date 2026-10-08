# Aadrika ERP V2 — Build Status

Last updated: 2026-10-08

## Repository
- Repository: aadrika-erp-app
- Active branch: v2-development
- Original repository: aadrika_erp_app — DO NOT MODIFY

## Completed implementation

### Phase 0 — Foundation
- [x] NestJS backend foundation
- [x] PostgreSQL database layer
- [x] Versioned migration runner
- [x] Health endpoint
- [x] Global validation
- [x] Global error response
- [x] Request ID
- [x] Security headers baseline
- [x] Audit event foundation

### Phase 1 — Identity & Organization
- [x] Organizations
- [x] Branches
- [x] Users
- [x] Roles
- [x] Permissions
- [x] User-role assignments
- [x] User-branch assignments
- [x] Refresh session storage
- [x] Authentication service/guard foundation

### Phase 2 — Master Data
- [x] UOM
- [x] Tax / HSN / SAC
- [x] Warehouses
- [x] Customers
- [x] Suppliers
- [x] Item categories
- [x] Items/products
- [x] Item UOM conversions
- [x] Master Data APIs

### Phase 3 — CRM
- [x] Leads
- [x] Opportunities
- [x] Requirements
- [x] Activities/follow-ups
- [x] CRM APIs

### Phase 4 — Sales
- [x] Quotations foundation
- [x] Quotation lines
- [x] Sales Orders foundation
- [x] Sales Order lines
- [x] Sales APIs

### Phase 5 — Inventory
- [x] Stock locations/bins
- [x] Stock balances
- [x] Inventory transaction ledger
- [x] Batch/serial fields
- [x] Transactional stock posting
- [x] Inventory APIs

## Current status
Backend foundation and core commercial/inventory foundations are being built incrementally.

## Next implementation sequence
1. Procurement
2. Product/BOM and costing engine
3. MRP/planning
4. Manufacturing/PPC
5. Printing engine
6. Packaging/bag costing engine
7. Quality
8. Scrap/waste/recovery
9. Machines and maintenance
10. Asset management
11. Dispatch/logistics
12. Finance/accounting
13. GST
14. Expenses/cost centres
15. Documents
16. Reports/MIS
17. Workflow/approval engine
18. Notifications
19. Backup/recovery
20. Flutter/Web frontend
21. Integration and end-to-end testing
22. Production-readiness review

## Non-negotiable build rules
- Single source of truth for master data.
- No duplicate domain tables without an explicit architectural reason.
- Forward-only versioned migrations.
- Inventory is transaction/ledger based.
- Financial values use decimal-safe database types.
- Missing rates/master/tax data must produce validation errors, not silent zero values.
- Important operations must be atomic and idempotent where applicable.
- Authorization must be enforced server-side.
- Business transactions must have audit history.
- Estimated and actual costing must use a common costing model.
- ERP screens are not considered complete until their backend, persistence, validation and tests exist.
- Original aadrika_erp_app repository remains untouched.

## Visual/UI status
The official Shree Aadrika Innovations brand guidelines are the visual reference:
- Navy Blue #294272
- Teal Green #00685C
- Gold #CEA314
- White
- Montserrat typography
- Approved logo clear-zone/background rules

The frontend will be built against the completed backend domain model rather than creating disconnected mock screens.

## Definition of complete
V2 is considered complete only after:
- backend APIs are implemented
- database migrations are implemented
- frontend workflows are connected to APIs
- permissions are enforced
- critical calculations are tested
- inventory/finance transactions reconcile
- production/quality/scrap/costing flows reconcile
- backup/restore is tested
- end-to-end tests pass
- production readiness review is completed

This file is the high-level progress tracker. Git commit history remains the source of truth for actual code changes.
