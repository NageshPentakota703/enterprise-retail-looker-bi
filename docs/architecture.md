# Architecture and modeling decisions

## Source systems

Four synthetic CSV files represent orders, order items, products and customers. The project deliberately does not pretend to connect to live SAP, CRM or e-commerce APIs.

## Curated warehouse

- `fact_order_items` grain: one unique `order_item_id`.
- `dim_customers` grain: one row per `customer_id`.
- `dim_products` grain: one row per `product_id`.
- Fact rows retain completed and cancelled status. Measures explicitly filter to completed orders.
- Fact date partitioning supports date-range filtering. Clustering is an illustrative choice and should be benchmarked before claiming improvements.

## Semantic layer

LookML uses a fact-centered Explore with many-to-one joins. Revenue and gross profit are filtered measures. AOV divides completed revenue by distinct completed orders; it must not be summed across categories because orders can contain multiple categories. Category-level AOV means category-attributed revenue divided by orders containing that category, not overall order AOV.

## Data quality

Local Python tests verify keys, relationships, valid values and metric calculations. BigQuery ASSERT statements validate curated tables and reconcile revenue to raw inputs.

## Security

Do not commit service account keys, credentials, connection strings or customer records. This repository does not provision IAM roles or Looker access filters; configure and test access controls in your own environment before claiming them.
