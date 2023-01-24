create or replace package body test_pck is

/*
 * Marcin Klasicki DC-1000: test 001
 * Marcin Klasicki DC-1100 test 002
*/

function print_string(input in varchar2) return varchar2
is
begin

  dbms_output.put_line('input val: ' || input);

end;

end test_pck;