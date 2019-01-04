create or replace procedure procedureName(start_time   date,
                                                        end_time     date,
                                                        v_etl_number int,
                                                        status_flag  varchar) AS
    /*
    by chaochao 
    this is the principle of etl_md_etl_log_detail
    */
    v_sql               VARCHAR2(1000);
    status_flag         VARCHAR2(1000);
    v_insert            INT := 0;
    v_update            INT := 0;
    v_delete            INT := 0;

BEGIN
  LOOP
    //this is the time-based etl procedure 

    //success will insert the value to the dw_log_detail for each date.
    //every execution should insert one record to the detail table
    set status_flag = 'success'; //set it when this is done
    etl_md_etl_log_detail(v_etl_number,
                                 'name' ||
                                 to_char(v_date, 'yyyymmdd'),//procedureName + 日期
                                 status_flag,   //status_flag
                                 v_insert,
                                 v_update,
                                 v_delete);

    v_date := v_date + 1;
    EXIT WHEN v_date > end_time;
  END LOOP;


//this is the exception handling in etls, when it was triggerred,we can record it and know it.
EXCEPTION
  WHEN OTHERS THEN
    etl_md_etl_log_detail(      v_etl_number,
                                procedureName,
                                SQLERRM,
                                v_insert,
                                v_update,
                                v_delete);
END procedureName;