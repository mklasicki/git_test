create or replace package body logger as

procedure log_info(v_msg in varchar2) is
begin
  dbms_output.put_line('[' || user  || '] ---- ' || v_msg);
end;

procedure save_log_data(called_proc in varchar2,  msg in varchar2) is
pack_name   varchar2(100) := 'nazwa pakietu';
stmt        varchar2(4000);
inserted    timestamp := systimestamp;
begin
stmt := 'insert into logs values ( ' || pack_name || ', ' || ':pro , :ins , :message)';

execute immediate stmt
     using called_proc,inserted, msg;
end;

end logger;