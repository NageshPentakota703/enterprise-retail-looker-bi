view: order_items {
  sql_table_name: `YOUR_GCP_PROJECT.retail_analytics.fact_order_items` ;;
  dimension: order_item_id { primary_key: yes type: string sql: ${TABLE}.order_item_id ;; }
  dimension: order_id { type: string sql: ${TABLE}.order_id ;; }
  dimension: customer_id { hidden: yes type: string sql: ${TABLE}.customer_id ;; }
  dimension: product_id { hidden: yes type: string sql: ${TABLE}.product_id ;; }
  dimension: status { type: string sql: ${TABLE}.status ;; }
  dimension_group: order { type: time timeframes: [date, week, month, year] datatype: date sql: ${TABLE}.order_date ;; }
  dimension: quantity { type: number sql: ${TABLE}.quantity ;; }
  dimension: line_revenue { type: number hidden: yes sql: ${TABLE}.line_revenue ;; }
  dimension: line_gross_profit { type: number hidden: yes sql: ${TABLE}.line_gross_profit ;; }

  measure: revenue {
    type: sum
    sql: ${TABLE}.line_revenue ;;
    filters: [status: "completed"]
    value_format_name: usd
  }
  measure: gross_profit {
    type: sum
    sql: ${TABLE}.line_gross_profit ;;
    filters: [status: "completed"]
    value_format_name: usd
  }
  measure: order_count {
    type: count_distinct
    sql: ${order_id} ;;
    filters: [status: "completed"]
  }
  measure: units_sold {
    type: sum
    sql: ${TABLE}.quantity ;;
    filters: [status: "completed"]
  }
  measure: average_order_value {
    type: number
    sql: SAFE_DIVIDE(${revenue}, ${order_count}) ;;
    value_format_name: usd
  }
  measure: gross_margin_pct {
    type: number
    sql: SAFE_DIVIDE(${gross_profit}, ${revenue}) ;;
    value_format_name: percent_2
  }
}
