class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :shift_allocation_id 
      t.integer :employee_id 
      
      
      t.datetime :attendance_date 
      t.datetime :time_in
      t.datetime :time_out 
      t.integer :status  , :default => ATTENDANCE_STATUS[:present] # present, sick, bla bla lba

      t.timestamps
    end
  end
end
