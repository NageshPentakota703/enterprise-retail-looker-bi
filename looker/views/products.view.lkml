view: products {
  sql_table_name: `YOUR_GCP_PROJECT.retail_analytics.dim_products` ;;
  dimension: product_id { primary_key: yes type: string sql: ${TABLE}.product_id ;; }
  dimension: product_name { type: string sql: ${TABLE}.product_name ;; }
  dimension: category { type: string sql: ${TABLE}.category ;; }
}
