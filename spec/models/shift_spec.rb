require 'rails_helper'

RSpec.describe Shift, type: :model do
  it "should create shift with code" do
    shift = Shift.create_object(
        :name => "SHIFT 1",
        :code => "sft01",
        :start_time => 590,
        :duration => 8
        )
    
    shift.should be_valid
    
    shift.code.should == "sft01"
  end
  
  it "should not create shift without name" do
    shift = Shift.create_object(
        :name => "",
        :code => "sft01",
        :start_time => 590,
        :duration => 8
        )
    
    shift.should_not be_valid
  end
  
  it "should not create shift without code" do
      shift = Shift.create_object(
          :name => "SHIFT 1",
          :code => "",
          :start_time => 560,
          :duration => 8
          )
    
    shift.should_not be_valid
  end 
  
  it "should not create shift without start time" do
      shift = Shift.create_object(
          :name => "SHIFT 1",
          :code => "sft01",
          :start_time => -2,
          :duration => 8
          )
    
    shift.should_not be_valid
  end
  
  it "should not create shift without duration" do
      shift = Shift.create_object(
          :name => "SHIFT 1",
          :code => "sft01",
          :start_time => 590,
          :duration => 0
          )
    
    shift.should_not be_valid
  end
  
  it "should not create shift with duplicate code" do
      code = "sft01"
      shift = Shift.create_object(
          :name => "SHIFT 1",
          :code => code,
          :start_time => 590,
          :duration => 8
          )
      
      shift.should be_valid
      
      shift_2 = Shift.create_object(
          :name => "SHIFT 2",
          :code => code,
          :start_time => 900,
          :duration => 8
          )
      
      shift_2.should_not be_valid
  end
  
  context "jika shift sudah ada" do
      before (:each) do
          @shift_name = "SHIFT 1"
          @shift_code = "sft01"
          @shift_start_time = 590
          @shift_duration = 8
          @shift = Shift.create_object(
              :name => @shift_name,
              :code => @shift_code,
              :start_time => @shift_start_time,
              :duration => @shift_duration
              )
          
          @shift_2_name = "SHIFT 2"
          @shift_2_code = "sft02"
          @shift_2_start_time = 900
          @shift_2_duration = 8 
          @shift_2 = Shift.create_object(
              :name => @shift_2_name,
              :code => @shift_2_code,
              :start_time => @shift_2_start_time,
              :duration => @shift_2_duration
              )
      end
      
      it "should have 2 shift" do
          Shift.count.should == 2
      end
      
      it "should create valid shift" do
          @shift.should be_valid
          @shift_2.should be_valid
      end
      
      it "should be to update" do
          new_name = "SHIFT 3"
          new_code = "sft03"
          new_start_time = 690
          new_duration = 10
          
          @shift.update_object(
              :name => new_name,
              :code => new_code,
              :start_time => new_start_time,
              :duration => new_duration
              )
          
          @shift.should be_valid
          
          @shift.reload
          
          @shift.name.should == new_name
          @shift.code.should == new_code
          @shift.start_time.should == new_start_time
          @shift.duration.should == new_duration
      end
      
      it "should not allow duplicate code" do
          @shift_2.update_object(
              :name => @shift_2_name,
              :code => @shift_code
              )
              
          @shift_2.errors.size.should_not == 0
          @shift_2.should_not be_valid
      end
      
      it "should be allow to delete shift_2" do
          @shift_2.delete_object
          
          @shift_2.persisted?.should be_falsy
          
          Shift.count.should == 1
      end
  end
end
