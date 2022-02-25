class CreateEmployeeAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_addresses do |t|
      t.string :house_name
      t.string :street_name
      t.string :road
      t.belongs_to :employee, foreign_key: true

      t.timestamps
    end
  end
end
