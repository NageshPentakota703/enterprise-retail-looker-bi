connection: "retail_bigquery"
include: "/views/*.view.lkml"

explore: order_items {
  label: "Order Items"
  description: "Completed-order revenue and profitability analysis; fact grain is one order item."
  join: customers {
    type: left_outer
    sql_on: ${order_items.customer_id} = ${customers.customer_id} ;;
    relationship: many_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${order_items.product_id} = ${products.product_id} ;;
    relationship: many_to_one
  }
}
