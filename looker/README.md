# LookML project

Import `models/retail.model.lkml` and `views/*.view.lkml` into your Looker development project. Replace `YOUR_GCP_PROJECT` and configure a BigQuery connection named `retail_bigquery`.

**Important:** Looker project model files are conventionally placed at project root or in `models/` depending on project configuration; ensure the model is registered in your Looker instance. The include path `/views/*.view.lkml` is relative to the project root.

Test in Development Mode: Validate LookML, open the Order Items Explore, compare completed-order revenue and AOV to `sql/02_kpi_examples.sql`, test region/category breakdowns, and inspect generated SQL. Promote through your normal Git/deployment process.

The use of `SAFE_DIVIDE` in type:number measures assumes the BigQuery SQL dialect. For other databases, adjust SQL expressions.
