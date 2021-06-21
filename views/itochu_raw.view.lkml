view: itochu_raw {
  sql_table_name: "YKONISHI_DEV"."ITOCHU_RAW"
    ;;

  dimension: asm_group_id {
    type: string
    sql: ${TABLE}."ASM_GROUP_ID" ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: email {
    hidden: yes
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: event {
    type: string
    sql: ${TABLE}."EVENT" ;;
  }

  dimension: ip {
    type: string
    sql: ${TABLE}."IP" ;;
  }

  dimension: marketing_campaign_id {
    type: string
    sql: ${TABLE}."MARKETING_CAMPAIGN_ID" ;;
  }

  dimension: marketing_campaign_name {
    type: string
    sql: ${TABLE}."MARKETING_CAMPAIGN_NAME" ;;
  }

  dimension: segment_category {
    type: string
    sql: ${TABLE}."SEGMENT_CATEGORY" ;;
  }

  dimension: sg_content_type {
    type: string
    sql: ${TABLE}."SG_CONTENT_TYPE" ;;
  }

  dimension: sg_event_id {
    type: string
    sql: ${TABLE}."SG_EVENT_ID" ;;
  }

  dimension: sg_message_id {
    type: string
    sql: ${TABLE}."SG_MESSAGE_ID" ;;
  }

  dimension: sg_user_id {
    type: string
    sql: ${TABLE}."SG_USER_ID" ;;
  }

  dimension: singlesend_id {
    type: string
    sql: ${TABLE}."SINGLESEND_ID" ;;
  }

  dimension: singlesend_name {
    type: string
    sql: ${TABLE}."SINGLESEND_NAME" ;;
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
    sql: ${TABLE}."TIMESTAMP" ;;
  }

  dimension: top_category {
    type: string
    sql: ${TABLE}."TOP_CATEGORY" ;;
  }

  dimension: useragent {
    type: string
    sql: ${TABLE}."USERAGENT" ;;
  }

  measure: count {
    type: count
    drill_fields: [marketing_campaign_name, singlesend_name]
  }

}
