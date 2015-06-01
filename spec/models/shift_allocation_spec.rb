require 'rails_helper'

RSpec.describe ShiftAllocation, type: :model do
  before (:each) do
      @shift = Shift.create_object(
            :name => "SHIFT 1",
            :code => "sft01",
            :start_time => 560,
            :duration => 8
          )
          
      @shift_2 = Shift.create_object(
            :name => "SHIFT 2",
            :code => "sft02",
            :start_time => 900,
            :duration => 8
          )
          
      @employee = Employee.create_object(
            :name => "Pebri",
            :code => "007",
            :enrollment_code => "121"
          )
      
      @employee_2 = Employee.create_object(
            :name => "Bambang",
            :code => "008",
            :enrollment_code => "122"
          )
  end  
  
  it "should create shift and employee" do
    @shift.should be_valid
    @employee.should be_valid
  end
      
  it "should create shift allocation with shift id and employee id" do
      shift_allocation = ShiftAllocation.create_object(
          :shift_id => @shift.id ,
          :employee_id => @employee.id
          )
          
      shift_allocation.persisted?.should be_truthy
      
      shift_allocation.should be_valid
      
      shift_allocation.shift_id.should == @shift.id
      shift_allocation.employee_id.should == @employee.id
  end

  it "should create shift allocation with shift id exist" do
      shift_allocation = ShiftAllocation.create_object(
          :shift_id => 0,
          :employee_id => @employee.id
          )
      
      shift_allocation.errors.size.should_not == 0 
      shift_allocation.should_not be_valid 
  end
  
  it "should create shift allocation with employee id exist" do
      shift_allocation = ShiftAllocation.create_object(
          :shift_id => @shift.id,
          :employee_id => 0
          )
      
      shift_allocation.errors.size.should_not == 0 
      shift_allocation.should_not be_valid 
  end
  
  it "should not create shift allocation with shift_id and employee_id duplicate" do
      shift_allocation = ShiftAllocation.create_object(
          :shift_id => @shift.id,
          :employee_id => @employee.id
          )
      
      shift_allocation.should be_valid
      
      shift_allocation_2 = ShiftAllocation.create_object(
          :shift_id => @shift.id,
          :employee_id => @employee.id
          )
      
      shift_allocation_2.should_not be_valid
  end
  
  context "jika shift sudah ada" do
      before (:each) do
          @shift_allocation = ShiftAllocation.create_object(
              :shift_id => @shift.id,
              :employee_id => @employee.id
              )
          
          @shift_allocation_2 = ShiftAllocation.create_object(
              :shift_id => @shift_2.id,
              :employee_id => @employee_2.id
              )
      end
      
      it "should not update shift allocation with shift id and employee id" do
            @shift_allocation.update_object(
                  :shift_id => @shift.id,
                  :employee_id => @employee_2.id
                  )
              
            @shift_allocation.should be_valid
              
            @shift_allocation.reload
              
            @shift_allocation.shift_id.should == @shift.id
            @shift_allocation.employee_id.should == @employee_2.id
            
      end
      
      it "should not duplicate shift id and employee id" do
          @shift_allocation_2.update_object(
                  :shift_id => @shift.id,
                  :employee_id => @employee.id
                  )
         
          @shift_allocation_2.should_not be_valid
      end
  end
  
  
end
