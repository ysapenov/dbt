# Aggregation Fact Auto

This folder contains SQL models for automated aggregation of fact tables in our dbt project.

## Models

### trading_agg_week_opt.sql

This model performs weekly aggregation of trading data, optimized for performance and further usage as fact table in the Power BI report.

#### Purpose
The purpose of this model is to aggregate daily trading data into a weekly summary, providing a more condensed view of trading activities while optimizing query performance.

#### Key Features
1. Dynamic column handling: Automatically detects and aggregates measure columns from the source model.
2. Time-based aggregation: Groups data by merchandise year and week.
3. Product and sales granularity: Maintains granularity at the product option and sales dimension levels.

#### Dependencies
This model depends on the following sources:
- `trading_ftt_sales`: Daily trading fact table
- `calendar`: Calendar dimension table
- `product`: Product dimension table
