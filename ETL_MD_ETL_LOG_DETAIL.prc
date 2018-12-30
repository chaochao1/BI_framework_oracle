/* by chaochao
created at 2018-12-29
This is the log etl for the framework, every etl script should run in it.
Every execution will insert one record to our detail table.
The location will 
*/
CREATE OR REPLACE
procedure etl_md_etl_log_detail(
v_etl_number int,
v_etl_name varchar2,
SQLERRM varchar2,
v_insert int,
v_update int,
v_delete int				  
) as

BEGIN
	INSERT into dw_log_detail 
		(etl_number, etl_name, SQLERRM, v_insert, v_update, v_delete, create_time)
		values (v_etl_number, v_etl_name, SQLERRM, v_insert, v_update, v_delete, SYSDATE);
	commit;
END etl_md_etl_log_detail;


/*
create table dw_log_detail(
	id int  constraint pk_id primary key,
	etl_number int,
	etl_name varchar2(2000),
	SQLERRM varchar2(1000),
	v_insert int,
	v_update int,
	v_delete int,
	create_time DATE,
	primary key(ID)
);


create sequence dw_log_detail_eid_SEQ MINVALUE 1 NOMAXVALUE INCREMENT BY 1 START WITH 1 NOCACHE;



create or replace Trigger dw_log_detail_ins_trg before insert on dw_log_detail for each row when (new.eid is null)
BEGIN
	select dw_log_detail_eid_SEQ.nextval into :new.eid from dual;
END;
*/