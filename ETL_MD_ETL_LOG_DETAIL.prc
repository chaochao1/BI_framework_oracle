/* by chaochao
created at 2018-12-29
This is the log etl for the framework, every etl script should run in it.
Every execution will insert one record to our detail table.
用于插入每次etl运行信息的etl日志脚本。
*/
CREATE OR REPLACE
PROCEDURE etl_md_etl_log_detail(
	v_etl_number INT,
	v_etl_name VARCHAR2,
	v_error_code VARCHAR2,
	v_error_message VARCHAR2,
	v_insert INT,
	v_update INT,
	v_delete INT
) AS
BEGIN
	INSERT INTO dw_log_detail(
		etl_number,
		etl_name,
		error_code,
		error_message,
		v_insert,
		v_update,
		v_delete,
		create_time
	)
VALUES
	(
		v_etl_number,
		v_etl_name,
		v_error_code,
		v_error_message,
		v_insert,
		v_update,
		v_delete,
		SYSDATE
	) ; COMMIT ;
END etl_md_etl_log_detail ;

/*
create table dw_log_detail(
	id int  constraint pk_id primary key,
	etl_number int,
	etl_name varchar2(2000),
	error_code varchar2(50),
	error_message varchar2(1000),
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