# sales_analytics_12

dbt + DuckDB project: sources, snapshots (SCD type 2), staging views, an
incremental fact table, marts, packages (dbt_utils), a custom generic test,
doc blocks and an exposure.

## Run

```powershell
pip install dbt-duckdb
cd sales_analytics_12
dbt deps --profiles-dir .
dbt seed --profiles-dir .
dbt build --profiles-dir .
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

Run `dbt seed` before `dbt build`: the seeds stand in for an external system
that loads the `raw` schema.

## Useful commands

```powershell
dbt build --select tag:marts --profiles-dir .
dbt build --select fct_orders+ --profiles-dir .
dbt build --select +mart_monthly_revenue --profiles-dir .
dbt build --target prod --profiles-dir .
dbt test --select source:raw --profiles-dir .
```

## Schemas

| Schema | Contents |
|---|---|
| raw | seeds (act as source tables) |
| staging | stg_* views |
| marts | fct_orders and mart_* tables |
| snapshots | products_snapshot, customers_snapshot |