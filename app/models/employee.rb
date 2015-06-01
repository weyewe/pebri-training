class Employee < ActiveRecord::Base
    has_many :attendances 
    has_many :shift_allocations
    has_many :shifts, :through => :shift_allocations # employee.shifts
    
    
    validates_presence_of :name 
    validates_presence_of :code
    validates_presence_of :enrollment_code
    validates_uniqueness_of :code
    validates_uniqueness_of :enrollment_code
    
    
    def self.create_object( params ) 
        new_object = self.new  # new_object = Employee.new
        
        new_object.name = params[:name]
        new_object.code = params[:code]
        new_object.enrollment_code = params[:enrollment_code]
        
        new_object.save
        
        return new_object
    end
    
    # employee_object.update_object 
    def update_object( params ) 
        self.name = params[:name]
        self.code = params[:code]
        self.enrollment_code = params[:enrollment_code]
        
        self.save
        
        return self 
    end
    
    def delete_object

        
        # 1. jika sudah ada attendance, tidak boleh di delete
        if self.attendances.count != 0 
            self.errors.add(:generic_errors, "Sudah ada attendance")
            return self 
        end
        
        self.destroy 
    end
    
    # Employee.create() 
    # employee.update() 
    # employee.destroy
    
    
end
