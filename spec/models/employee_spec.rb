require 'rails_helper'

RSpec.describe Employee, type: :model do
  it "should  create employee without name" do
    code = "007"
    employee=  Employee.create_object( 
        :name => "Pebrio",
        :code =>  code,
        :enrollment_code => "223423"
      )
      
    employee.should be_valid
    
    employee.code.should == code
  end
  
  it "should_not allow object creation without name" do
    code = "007"
    employee=  Employee.create_object( 
        :name => "",
        :code =>  code,
        :enrollment_code => "223423"
      )
      
    employee.should_not be_valid
  end
  
  it "should_not allow object creation without code" do
    code = "007"
    employee=  Employee.create_object( 
        :name => "efafeawf",
        :code =>  "",
        :enrollment_code => "223423"
      )
      
    employee.should_not be_valid
  end
  
  it "should not create employee with duplicate code" do
    code = "007"
    employee=  Employee.create_object( 
        :name => "efafeawf",
        :code =>  code,
        :enrollment_code => "223423"
      )
      
    employee.should  be_valid
    
    employee_2 =  Employee.create_object( 
        :name => "efafeawf",
        :code =>  code,
        :enrollment_code => "223423"
      )
      
    employee_2.should_not  be_valid
  end
  
  context "sudah dibuatkan employee" do
    before(:each) do
      @employee_1_name = "Pebri"
      @employee_1_code = "007"
      @employee = Employee.create_object(
          :name =>  @employee_1_name,
          :code =>  @employee_1_code,
        :enrollment_code => "223423"
        )
        
        
      @employee_2_name = "Bambang"
      @employee_2_code = "009"
      @employee_2 = Employee.create_object(
          :name => @employee_2_name,
          :code => @employee_2_code,
        :enrollment_code => "24423423"
        )
    end
    
    it "should have 2 employees" do
      Employee.count.should == 2 
    end
    
    it "should create valid employee" do
      @employee.should be_valid
      @employee_2.should be_valid
    end
    
    it "should be allowed to update" do
      new_name = "Pebri134"
      new_code = "234"
      
      @employee.update_object(
          :name => new_name,
          :code => new_code,
        :enrollment_code => "223423"
        )
        
      @employee.should be_valid
      
      @employee.reload 
      
      @employee.name.should == new_name
      @employee.code.should == new_code
    end
    
    it "should not allow duplicate code" do
      @employee_2.update_object(
          :name => @employee_2_name,
          :code => @employee_1_code,
        :enrollment_code => "223423"
        )
        
      @employee_2.errors.size.should_not == 0 
      @employee_2.should_not be_valid
    end
    
    it "should be allowed to delete employee 2" do
      @employee_2.delete_object
      
      @employee_2.persisted?.should be_falsy  # be_truthy 
      
      Employee.count.should == 1 
    end
    

    
  end
  
end
