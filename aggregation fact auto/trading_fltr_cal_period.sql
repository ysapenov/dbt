{{ 
	config(
		materialized='table'
	)
}}

-- TRADING_FTT_SALES table filtered to show only TYCW, TYLW, LYCW and LYLW periods
SELECT T.*
FROM 
    {{ ref('trading_ftt_sales') }} T 
    INNER JOIN {{ ref('calendar') }} C 
        ON T.dim_item_status_date = C.cal_dt
WHERE 1=1 
    AND (
        c.CURRENT_WK_IND = 'Y'
        OR c.LAST_WK_IND = 'Y'
        OR c.LY_CURRENT_WK_IND = 'Y'
        OR c.LY_LAST_WK_IND = 'Y'
    )