# Executive dashboard — build specification

This repository contains a **dashboard blueprint**, not a screenshot of a live Looker deployment.

## Dashboard: Retail Executive Overview

1. Revenue — single value using `order_items.revenue`.
2. Orders — single value using `order_items.order_count`.
3. AOV — single value using `order_items.average_order_value`.
4. Gross margin — single value using `order_items.gross_margin_pct`.
5. Revenue over time — line chart by `order_items.order_month`.
6. Revenue by region — bar chart by `customers.region`.
7. Revenue by category — bar chart by `products.category`.
8. Top products — table using `products.product_name` and `order_items.revenue`.

Add a dashboard date filter mapped to `order_items.order_date`; verify date filter semantics and completed-order filters. Enable drill to product/category or order-level results as appropriate. Restrict access according to actual data sensitivity.

## Screenshot checklist

- Capture a real Looker dashboard after the Explore has been deployed.
- Capture an Explore showing selected dimensions and measures.
- Capture LookML validation results if useful.
- Redact private customer information and secrets.
- Put actual images here as `dashboard-overview.png` and `explore.png`.

Do not upload a mockup and label it as an implemented Looker dashboard.
