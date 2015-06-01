class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :name
      t.string :code 
      # t.datetime :start_time
      t.integer :start_time  # 9:30 => 9*60 + 30 
      t.integer :duration # in minutes 
      
       

      t.timestamps
    end
  end
end
