require 'active_record'

class Department < ActiveRecord::Base

  def add_employee(new_employee)
    new_employee.department_id = self.id
    new_employee.save
  end

  def department_employees
    Employee.where(department_id: self.id).to_a
  end

  def department_salary
    employees = department_employees
    employees.reduce(0.0) {|sum, e| sum + e.salary}
  end

  def department_raise(alloted_amount)
    employees = department_employees
    raise_eligible = employees.select {|e| yield(e)}
    amount = alloted_amount / raise_eligible.length
    raise_eligible.each {|e| e.raise_by_amount(amount)}
  end

  def total_department_employees
    employees = department_employees
    employees.count
  end

  def least_paid_employee
    employees = department_employees
    low_to_high_salaries = employees.sort_by {|employee| employee.salary}
    low_to_high_salaries[0]
  end
end
