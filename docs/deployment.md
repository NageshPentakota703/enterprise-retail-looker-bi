# Deployment and verification guide

## 1. BigQuery

Create datasets `retail_raw` and `retail_analytics`. Run `sql/00_raw_schema.sql` after replacing `YOUR_GCP_PROJECT`. Load `data/*.csv` to the corresponding raw tables using BigQuery's CSV loader with header rows skipped and the DDL schema (especially `order_date DATE`, `NUMERIC` prices). Run `sql/01_curated_tables.sql`.

## 2. Validate

Run `validation/bigquery_assertions.sql`. Run `sql/02_kpi_examples.sql` and compare to `python3 scripts/validate_data.py` output. All assertions must pass.

## 3. Looker

Configure a Looker BigQuery connection `retail_bigquery` with minimum required permissions. Create a LookML project, import the LookML files, update project IDs, register the model, validate LookML, and run the `Order Items` Explore. Check generated SQL and metrics.

## 4. Dashboard

Follow `dashboards/dashboard_build_guide.md`. Save dashboard and capture genuine screenshots.

## 5. Performance evidence

For a reproducible benchmark, capture query text, dataset size, bytes billed/processed, slot time or elapsed time, and repeated runs before and after any optimization. Avoid performance-improvement claims without evidence.

## 6. Portfolio publication

Upload this repository to GitHub. Add a link to the live dashboard only if it is actually accessible to reviewers and complies with security requirements.
