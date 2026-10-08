# Aadrika ERP V2 — Procurement Scope

Procurement is designed for SHREE AADRIKA INNOVATIONS LLP as a multi-product custom packaging and printing manufacturer. It is not bag-only and is not a generic office-purchasing module.

## Product families supported
- Paper bags and shopping bags
- Mono/folding cartons
- Rigid/luxury boxes
- Corrugated packaging
- Labels and stickers
- Tags/hang tags
- Sleeves, envelopes and wraps
- Pouches
- Corporate/gift packaging
- Retail/promotional packaging
- Custom packaging products
- Printing and finishing/job-work services

## Procurement categories
1. Paper, board and substrates
2. Bag components and handles
3. Printing inks and consumables
4. Lamination/coating/finishing materials
5. Adhesives and pasting materials
6. Packaging/packing materials
7. Production consumables
8. Machine spares and tooling
9. Outsourced/job-work services
10. Other production-linked materials

## Transaction flow
Demand/MRP -> Purchase Requisition -> Approval -> RFQ -> Supplier Quotations -> Supplier Comparison -> Supplier Selection -> PO Approval -> Purchase Order -> Expected Delivery -> GRN -> Incoming QC -> Accepted/Rejected/Hold -> Inventory or Return -> Landed Cost -> Purchase Invoice -> 3-way match -> Finance/Payment -> Supplier Performance.

## Core controls
- Organization/branch scoped
- Approval workflow configurable by amount/category
- PO revisions are immutable/versioned
- No stock increase before GRN
- Rejected/hold material cannot become usable stock
- Purchase return creates inventory transactions
- Landed cost is calculated separately from tax
- PO/GRN/invoice quantities and rates support 3-way matching
- Supplier price history retained
- All material and financial transactions audited
- Decimal-safe money/quantity calculations
- Missing item/UOM/tax/rate masters produce validation errors, never silent zero values
- Idempotency required for critical receipt/posting operations

## Aadrika-specific procurement intelligence
Procurement must expose material requirements from BOM/MRP for any product family, not only bags. A product BOM can request paper/board, ink, adhesive, handles, laminate, magnets, labels, cartons, consumables or outsourced process services according to its routing.

## Future integrations
Procurement must integrate with Product Master, BOM, MRP, Inventory, Manufacturing, Printing, Packaging, Quality, Scrap/Recovery, Costing, Finance, GST, Documents and Reports/MIS.
