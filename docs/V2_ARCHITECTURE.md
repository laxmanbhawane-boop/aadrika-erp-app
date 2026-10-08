# Aadrika ERP V2 Architecture

## Goal
Build a production-grade universal ERP core with manufacturing, printing, packaging, MES, finance, GST, costing, quality, maintenance, assets, dispatch, CRM, reporting and backup capabilities.

## Architecture
- Universal ERP Core
- Manufacturing ERP
- MES / Shop Floor
- Printing Engine
- Packaging Engine
- Aadrika Bag Costing Engine
- Finance & Accounting
- GST / Tax Engine
- Workflow / Approval Engine
- Audit / Security Engine
- Document Engine
- Notification Engine
- Backup / Recovery Engine
- Reporting / BI Engine

## Core principle
One source of truth for masters and transaction ledgers. No duplicated customer, supplier, product, inventory or pricing records across modules.

## Critical transaction flow
CRM -> Quotation -> Sales Order -> MRP -> Purchase / Production -> QC -> Finished Goods -> Dispatch -> Invoice -> Payment -> Accounting.

## Manufacturing flow
Sales Order -> Production Order -> BOM -> Routing -> Work Orders -> Material Issue -> Production -> QC -> Scrap/Waste -> Finished Goods -> Dispatch.

## Costing
Estimated cost and actual cost must use the same cost framework and expose variance:
Material + Labour + Machine + Overhead + Waste - Scrap Recovery = Cost.

## Safety
- Missing master data must fail loudly; never silently become zero.
- Inventory changes must be transaction based.
- Financial postings must be auditable and idempotent.
- Permissions must be enforced server-side.
- Original repository must remain untouched.
