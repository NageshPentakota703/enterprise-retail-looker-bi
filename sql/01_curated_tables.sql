-- BigQuery Standard SQL; run AFTER raw tables are loaded. Replace YOUR_GCP_PROJECT.
CREATE OR REPLACE TABLE `YOUR_GCP_PROJECT.retail_analytics.dim_customers` AS
SELECT customer_id, customer_name, state, region
FROM `YOUR_GCP_PROJECT.retail_raw.customers`;

CREATE OR REPLACE TABLE `YOUR_GCP_PROJECT.retail_analytics.dim_products` AS
SELECT product_id, product_name, category
FROM `YOUR_GCP_PROJECT.retail_raw.products`;

CREATE OR REPLACE TABLE `YOUR_GCP_PROJECT.retail_analytics.fact_order_items`
PARTITION BY order_date
CLUSTER BY customer_id, product_id AS
SELECT
  i.order_item_id, i.order_id, o.customer_id, i.product_id,
  o.order_date, o.status, i.quantity, i.unit_price, i.unit_cost,
  CAST(i.quantity * i.unit_price AS NUMERIC) AS line_revenue,
  CAST(i.quantity * (i.unit_price - i.unit_cost) AS NUMERIC) AS line_gross_profit
FROM `YOUR_GCP_PROJECT.retail_raw.order_items` i
JOIN `YOUR_GCP_PROJECT.retail_raw.orders` o USING (order_id);
-- All statuses are retained; the LookML measures explicitly filter completed sales.
