-- Completed-order metrics, using fact grain correctly.
SELECT
  SUM(line_revenue) AS revenue,
  SUM(line_gross_profit) AS gross_profit,
  COUNT(DISTINCT order_id) AS order_count,
  SAFE_DIVIDE(SUM(line_revenue), COUNT(DISTINCT order_id)) AS aov,
  SAFE_DIVIDE(SUM(line_gross_profit), SUM(line_revenue)) AS gross_margin_pct
FROM `YOUR_GCP_PROJECT.retail_analytics.fact_order_items`
WHERE status = 'completed';

-- Revenue by region (many-to-one join preserves fact grain).
SELECT c.region, SUM(f.line_revenue) AS revenue
FROM `YOUR_GCP_PROJECT.retail_analytics.fact_order_items` f
JOIN `YOUR_GCP_PROJECT.retail_analytics.dim_customers` c USING (customer_id)
WHERE f.status = 'completed'
GROUP BY c.region ORDER BY revenue DESC;

-- Monthly revenue with month-over-month change.
WITH monthly AS (
  SELECT DATE_TRUNC(order_date, MONTH) AS month, SUM(line_revenue) AS revenue
  FROM `YOUR_GCP_PROJECT.retail_analytics.fact_order_items`
  WHERE status = 'completed'
  GROUP BY 1
)
SELECT month, revenue,
  SAFE_DIVIDE(revenue - LAG(revenue) OVER (ORDER BY month),
              LAG(revenue) OVER (ORDER BY month)) AS mom_growth_pct
FROM monthly ORDER BY month;
