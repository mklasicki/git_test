create or replace PACKAGE BODY EMP AS

 procedure set_phone_number(emp_id in number, p_phone_number in varchar2, p_mobile_phone in number) is
   v_row_count number;
 begin

   select count(*) into v_row_count from phone_numbers
     where employee_id = emp_id;

   if v_row_count = 1 then

        if p_phone_number is not null then
          update_phone_no(emp_id, p_phone_number);
          logger.log_info('Zmieniam phone_no dla pracownika o id ' || emp_id);
        end if;

        if p_mobile_phone is not null then
          dbms_output.put_line('mobile_no');
          update_mobile_no(emp_id, p_mobile_phone);
          logger.log_info('Zmieniam mobile_no dla pracownika o id ' || emp_id);
        end if;
   else

       insert into hr.phone_numbers
       values (emp_id, case
                       when p_phone_number is not null then p_phone_number
                       else null
                       end,
                    case
                       when p_mobile_phone is not null then p_mobile_phone
                       else null
                       end);

   logger.log_info('Udalo sie zapisac poprawnie numery telefonow dla pracownika o id ' || emp_id);

   end if;

   exception
     when others then
     logger.log_info('Error');

 end;


  procedure update_phone_no(emp_id in number, phone_no in varchar2) is
  msg           varchar2(4000);
  proc_name     varchar2(100);
  begin

  proc_name := 'update_phone_no';

  if length(phone_no) = 9 then

    update phone_numbers p
        set p.phone_number = phone_no
            where p.employee_id = emp_id;

    msg := 'Zmieniono numer dla pracownika o id ' || emp_id;
--    logger.save_log_data(proc_name, msg);

   else

    msg := 'Nieprawidlowa dlugosc numeru telefonu';
  --  logger.save_log_data(proc_name, msg);
   end if;

  exception
    when others then
        msg := 'Nieprawidlowa dlugosc numeru telefonu';
--        logger.save_log_data(proc_name, msg);
  end;

  procedure update_mobile_no(employee_id number,new_phone_no integer )is
  begin
    update phone_numbers
        set mobile_phone = new_phone_no
            where employee_id = employee_id;

   dbms_output.put_line('Zmieniono numer dla pracownika o id ' || employee_id);

  exception
    when others then
        dbms_output.put_line('Wystapil blad przy zmianie numeru dla pracownika o id ' || employee_id);
  end;

  procedure increase_salaries AS
  BEGIN
    for r1 in cur_emps loop
        update employees set salary = salary + v_salary_increase_rate;
    end loop;
  END increase_salaries;

  function get_avg_sal(p_dept_id int) return number AS
  v_avg_sal number := 0;
  BEGIN
   select avg(salary) into v_avg_sal from employees
    where department_id = p_dept_id;
    return v_avg_sal;
  END get_avg_sal;

  function get_emp_data(dept_id in integer) return emp_det_tab is
  emp_tab   emp_det_tab;
  v_emp     emp_det;
  v_index   integer := 1;
  begin
    for rec_cur in (select * from employees where department_id = dept_id) loop
        v_emp.first_name := rec_cur.first_name;
        v_emp.last_name := rec_cur.last_name;
        v_emp.salary := rec_cur.first_name;
        v_emp.department := rec_cur.department_id;

        emp_tab(v_index) := v_emp;
        v_index := v_index + 1;
        dbms_output.put_line('Dodato pracownika o id '|| rec_cur.employee_id);

    end loop;

    return emp_tab;
  end;

END EMP;