create or replace package logger as

/*
 Pakiet do wypisywania logow na konsoli
*/

procedure save_log_data(called_proc varchar2, msg in varchar2);

procedure log_info(v_msg in varchar2);

end logger;
