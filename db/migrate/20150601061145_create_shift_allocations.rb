class CreateShiftAllocations < ActiveRecord::Migration
  def change
    create_table :shift_allocations do |t|
      t.integer :shift_id
      t.integer :employee_id 
      t.boolean :is_deleted, :default => false 
      t.datetime :deleted_at 

      t.timestamps
    end
  end
end
