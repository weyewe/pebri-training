class ShiftAllocation < ActiveRecord::Base
    belongs_to :shift
    belongs_to :employee
    
    validates_presence_of :shift_id
    validates_presence_of :employee_id
    
    # validates_uniqueness_of :shift_id
    # validates_uniqueness_of :employee_id
    
    validate :valid_shift_id
    validate :valid_employee_id
    validate :unique_employee_and_shift_combination
    
    def unique_employee_and_shift_combination
        return if not employee_id.present? 
        return if not shift_id.present?
        
        past_data_list = ShiftAllocation.where(
                :employee_id => self.employee_id,
                :shift_id => self.shift_id,
                :is_deleted => false 
            )
            
        if not self.persisted? and past_data_list.count != 0
            self.errors.add(:shift_id, "Shift dan employee tidak boleh duplicate")
            self.errors.add(:employee_id, "Shift dan employee tidak boleh duplicate")
            return self
        elsif self.persisted? and past_data_list.count > 0 
            past_data = past_data_list.first 
            if past_data.id != self.id
                self.errors.add(:shift_id, "Shift dan employee tidak boleh duplicate")
                return self 
            end
        end
        
    end
    
    def valid_shift_id
        return if not shift_id.present? 
        
        object = Shift.find_by_id shift_id 
        
        if object.nil?
            self.errors.add(:shift_id, "Harus ada shift id")
            return self
        end
    end
    
    def valid_employee_id
        return if not employee_id.present?
        
        object = Employee.find_by_id employee_id
        
        if object.nil?
            self.errors.add(:employee_id, "Harus ada employee id")
            return self
        end
    end
    
    def self.create_object( params )
        new_object = self.new
        
        new_object.shift_id = params[:shift_id]
        new_object.employee_id = params[:employee_id]
        new_object.save 
        
        return new_object
    end
    
    def update_object( params )
        self.shift_id = params[:shift_id]
        self.employee_id = params[:employee_id]
        
        self.save   
        
        return save
    end
    
    
end
