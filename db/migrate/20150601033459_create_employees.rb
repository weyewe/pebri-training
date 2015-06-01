class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name 
      t.string :code 
      
      t.string :enrollment_code 
      

      t.timestamps
    end
  end
end
