require './employee'
require 'active_record'


class Department < ActiveRecord::Base

  def add_employee(new_employee)
    new_employee.department_id = self.id
    new_employee.save
  end

  def department_salary
    a = Employee.where(department_id: self.id).to_a
    a.reduce(0.0) {|sum, e| sum + e.salary}
  end

  def department_raise(alloted_amount)
    a = Employee.where(department_id: self.id).to_a
    raise_eligible = a.select {|e| yield(e)}
    amount = alloted_amount / raise_eligible.length
    raise_eligible.each {|e| e.raise_by_amount(amount)}
  end
end
