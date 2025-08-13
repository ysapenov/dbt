# Fact Segmentation Models

This folder contains SQL models for automated aggregation and filtering of fact table in the dbt project.  
So, the large fact table segmented to the two parts, which allows to import data to the Power BI reports.

## Models

### 1. trading_agg_week_opt.sql

This model performs weekly aggregation of trading data, optimized for performance and further usage as a fact table.

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

### 2. trading_fltr_cal_period.sql

This model filters trading data based on calendar periods for this and last week, and same period last year.

#### Purpose
The purpose of this model is to provide a filtered view of trading data for the specified time periods, allowing for more focused analysis and reporting.

#### Key Features
1. Time-based filtering: Applies filters based on calendar periods (e.g., specific weeks for this and last year).
2. Preserves granularity: Maintains the original item level granularity of the trading data while applying time-based filters.

#### Dependencies
This model depends on the following sources:
- `trading_ftt_sales`: Daily trading fact table
- `calendar`: Calendar dimension table
