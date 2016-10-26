require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection({
  adapter: 'sqlite3',
  database: 'employee_reviews.sqlite3'
  })

class InitialMigration < ActiveRecord::Migration[5.0]

  def change
    create_table :department do |t|
      t.string :name
    end

    create_table :employee do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.float :salary
      t.integer :department_id
    end
  end

end


begin
  InitialMigration.migrate(:down)
rescue
end

InitialMigration.migrate(:up)
