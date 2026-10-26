-- BigQuery scripting ASSERT statements; replace YOUR_GCP_PROJECT.
ASSERT (SELECT COUNT(*) = COUNT(DISTINCT order_item_id)
        FROM `YOUR_GCP_PROJECT.retail_analytics.fact_order_items`)
AS 'fact_order_items primary key not unique';
ASSERT (SELECT COUNT(*) = COUNT(DISTINCT customer_id)
        FROM `YOUR_GCP_PROJECT.retail_analytics.dim_customers`)
AS 'dim_customers key not unique';
ASSERT (SELECT COUNT(*) = COUNT(DISTINCT product_id)
        FROM `YOUR_GCP_PROJECT.retail_analytics.dim_products`)
AS 'dim_products key not unique';
ASSERT (SELECT COUNT(*) = 0 FROM `YOUR_GCP_PROJECT.retail_analytics.fact_order_items` f
        LEFT JOIN `YOUR_GCP_PROJECT.retail_analytics.dim_customers` c USING (customer_id)
        WHERE c.customer_id IS NULL) AS 'orphaned customers';
ASSERT (SELECT COUNT(*) = 0 FROM `YOUR_GCP_PROJECT.retail_analytics.fact_order_items` f
        LEFT JOIN `YOUR_GCP_PROJECT.retail_analytics.dim_products` p USING (product_id)
        WHERE p.product_id IS NULL) AS 'orphaned products';
ASSERT (SELECT COUNT(*) = 0 FROM `YOUR_GCP_PROJECT.retail_analytics.fact_order_items`
        WHERE quantity <= 0 OR unit_price < 0 OR unit_cost < 0 OR order_date IS NULL)
AS 'invalid fact values';
ASSERT (
  (SELECT SUM(line_revenue) FROM `YOUR_GCP_PROJECT.retail_analytics.fact_order_items` WHERE status = 'completed')
  =
  (SELECT SUM(i.quantity * i.unit_price) FROM `YOUR_GCP_PROJECT.retail_raw.order_items` i
   JOIN `YOUR_GCP_PROJECT.retail_raw.orders` o USING (order_id) WHERE o.status = 'completed')
) AS 'revenue reconciliation failed';
