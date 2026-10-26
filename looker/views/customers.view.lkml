view: customers {
  sql_table_name: `YOUR_GCP_PROJECT.retail_analytics.dim_customers` ;;
  dimension: customer_id { primary_key: yes type: string sql: ${TABLE}.customer_id ;; }
  dimension: customer_name { type: string sql: ${TABLE}.customer_name ;; }
  dimension: state { type: string sql: ${TABLE}.state ;; }
  dimension: region { type: string sql: ${TABLE}.region ;; }
}
