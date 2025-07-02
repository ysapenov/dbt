{{ 
	config(
		materialized='table'
	) 
}}

{# Declaring lists for storing dimensions(dim) and measures(ftt) #}
{%- set dim_columns = [] -%}
{%- set ftt_columns = [] -%}

{# Starting the loop that scans the TRADING_FTT_SALES model in the trading.yml file and fills DIM_COLUMNS and FTT_COLUMNS lists with corresponding objects #}
{%- for node in graph.nodes.values() | selectattr("resource_type", "in", ["model"]) -%}
    {%- if node.name == 'trading_ftt_sales' -%}
        {%- for column in node.columns -%}
            {%- if column.startswith("DIM_") -%}
                {%- do dim_columns.append(column) -%}
            {%- else -%}
                {%- do ftt_columns.append(column) -%}
            {%- endif -%} 
        {%- endfor -%}
    {%- endif -%}
{%- endfor -%}

with FTT_SALES as (
    select *
    from {{ ref('trading_ftt_sales') }}
),
---
CAL as (
    select *
    from {{ ref('calendar') }}
),
---
PRD as (
    select *
    from {{ ref('product') }}
)
select
	--/////////////////////////////////--
	-- calendar grain
	--/////////////////////////////////--
	CAL.MERCH_YR_WK
	, CAL.WTD_START_CAL_DT
	--/////////////////////////////////--
	-- product grain 
	--/////////////////////////////////--
	, PRD.OPTION_ID
	--/////////////////////////////////--
	-- sales grain
	--/////////////////////////////////--
	, FTT_SALES.DIM_LOCATION_ID
	, FTT_SALES.DIM_CHANNEL_ID
	, FTT_SALES.DIM_INVENTORY_TYPE_CODE
	, FTT_SALES.DIM_PRODUCT_STATUS_DESC 
	, FTT_SALES.DIM_PRODUCT_STATUS_GROUP 
	{% for column in ftt_columns -%}
        , sum({{ column }}) as {{ column }}
    {% endfor %}
from 
	FTT_SALES
	left join CAL on
		FTT_SALES.DIM_ITEM_STATUS_DATE = CAL.CAL_DT
	left join PRD on
		FTT_SALES.DIM_TCH_ITEM_PK = PRD.ITEM_PK 
group by ALL
