view: itochu_newsletter_summary {
  derived_table: {
    sql:
    SELECT
    EMAIL
    ,singlesend_id
    ,singlesend_name
    ,MIN(TIMESTAMP) as "FIRST_ACTIVITY"
    ,SUM(CASE WHEN EVENT = 'open' then 1 else 0 END) as open_count
    ,SUM(CASE WHEN EVENT = 'click' then 1 else 0 END) as click_count
    ,COUNT(DISTINCT CASE WHEN EVENT = 'delivered' then EMAIL else null END) as delivered_count_unique
    ,COUNT(DISTINCT CASE WHEN EVENT = 'open' then EMAIL else null END) as open_count_unique
    ,COUNT(DISTINCT CASE WHEN EVENT = 'click' then EMAIL else null END) as click_count_unique

FROM
    WORKBENCH.YKONISHI_DEV.ITOCHU_RAW
   GROUP BY 1, 2, 3
    ;;


  }
  dimension: email {
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: singlesend_id {
    sql: ${TABLE}.singlesend_id ;;
  }

  dimension: singlesend_name {
    sql: ${TABLE}.singlesend_name ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."FIRST_ACTIVITY" ;;
  }

  measure: open_count {
    sql: ${TABLE}.open_count ;;
    type: sum
    description: "Total opens, non-unique"
  }

  measure: open_unique {
    sql: ${TABLE}.open_count_unique ;;
    type: sum
    description: "Unique opens, unique per user/message"
  }

  measure: click_count {
    sql: ${TABLE}.click_count ;;
    type: sum
    description: "Total clicks, non-unique"
  }

  measure: click_unique {
    sql: ${TABLE}.click_count_unique ;;
    type: sum
    description: "Unique clicks, unique per user/message"
  }

  measure: delivered_unique {
    sql: ${TABLE}.delivered_count_unique ;;
    type: sum
    description: "Unique delivered, unique per user/message"
  }

  measure: open_rate {
    sql: ${open_unique} / ${delivered_unique} ;;
    ## Use Number here since a calculation will be performed; aggregates happen in previous metrics
    value_format: "0.00%"
    type: number
    description: "Unique opens per delivery"
  }

  measure: click_rate {
    sql: ${click_unique} / ${delivered_unique} ;;
    ## Use Number here since a calculation will be performed; aggregates happen in previous metrics
    value_format: "0.00%"
    type: number
    description: "Unique clicks per delivery"
  }

  measure: clicks_per_open_rate {
    sql: ${click_count} / ${open_unique} ;;
    ## Use Number here since a calculation will be performed; aggregates happen in previous metrics
    value_format: "0.00%"
    type: number
    description: "Number of clicks per unique open"
  }



}
