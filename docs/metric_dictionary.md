# Governed metric dictionary

| Metric | Definition | SQL / LookML logic | Caveat |
|---|---|---|---|
| Revenue | Sales value of completed order items | `SUM(quantity * unit_price)` where status completed | No tax, shipping, discounts, refunds |
| Gross profit | Completed sales less synthetic item costs | `SUM(quantity * (unit_price - unit_cost))` | Not net profit |
| Gross margin % | Gross profit divided by revenue | `SAFE_DIVIDE(gross_profit, revenue)` | Null if revenue is zero |
| Order count | Number of unique completed orders | `COUNT(DISTINCT order_id)` | Fact is item-grain |
| Average order value | Revenue per completed order | `SAFE_DIVIDE(revenue, order_count)` | Not AVG of item price |
| Units sold | Completed-order item quantity | `SUM(quantity)` | Excludes cancelled orders |

Metric owner: portfolio developer (replace with your name). Review changes to metric definitions before deploying LookML. All figures are synthetic and illustrative.
