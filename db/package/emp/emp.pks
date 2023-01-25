create or replace PACKAGE EMP AS

    /*
      Pakiet do zarzadzania pracownikami
    */

    v_salary_increase_rate number := 1000;
    type emp_det_tab is table of emp_det index by pls_integer;
    cursor cur_emps is select * from employees;

    procedure set_phone_number(emp_id in number, p_phone_number in varchar2, p_mobile_phone in number);
    procedure update_phone_no(emp_id in number, phone_no in varchar2);
    procedure update_mobile_no(employee_id in number, new_phone_no in integer );
    procedure increase_salaries;
    function get_avg_sal(p_dept_id int) return number;
    function get_emp_data(dept_id in integer) return emp_det_tab;

END EMP;