-- Run in BigQuery after replacing YOUR_GCP_PROJECT. Load CSV data separately.
CREATE SCHEMA IF NOT EXISTS `YOUR_GCP_PROJECT.retail_raw`;
CREATE SCHEMA IF NOT EXISTS `YOUR_GCP_PROJECT.retail_analytics`;
CREATE TABLE IF NOT EXISTS `YOUR_GCP_PROJECT.retail_raw.customers` (customer_id STRING, customer_name STRING, state STRING, region STRING);
CREATE TABLE IF NOT EXISTS `YOUR_GCP_PROJECT.retail_raw.products` (product_id STRING, product_name STRING, category STRING, unit_price NUMERIC, unit_cost NUMERIC);
CREATE TABLE IF NOT EXISTS `YOUR_GCP_PROJECT.retail_raw.orders` (order_id STRING, customer_id STRING, order_date DATE, status STRING);
CREATE TABLE IF NOT EXISTS `YOUR_GCP_PROJECT.retail_raw.order_items` (order_item_id STRING, order_id STRING, product_id STRING, quantity INT64, unit_price NUMERIC, unit_cost NUMERIC);
