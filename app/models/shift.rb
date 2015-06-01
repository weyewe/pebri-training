class Shift < ActiveRecord::Base
    has_many :shift_allocations   # shift.shift_allocations 
    has_many :employees, :through => :shift_allocations   # shift.employees 
    
    validates_presence_of :name
    validates_presence_of :code
    validates_presence_of :start_time
    validates_presence_of :duration
    validates_uniqueness_of :code
    
    validate :duration_must_not_zero_and_less_than_24_hours
    validate :start_time_is_less_than_end_of_day
    
    def duration_must_not_zero_and_less_than_24_hours
        return if not duration.present?
        
        if duration <= 0
            self.errors.add(:duration, "Tidak boleh lebih kecil dari 0 menit")
            return self
        end
        
        if duration >= 24 * 60 
            self.errors.add(:duration, "Tidak boleh lebih besar dari satu hari penuh")
            return self
        end
    end
    
    def start_time_is_less_than_end_of_day
        return if not start_time.present?
        
        if start_time < 0
            self.errors.add(:start_time, "Tidak boleh lebih kecil dari 00:00")
            return self
        end
        
        if start_time >= 24 * 60 
            self.errors.add(:start_time, "Tidak boleh lebih besar dari 23:59")
            return self
        end
    end
    
    
    def self.create_object( params )
        new_object = self.new
        
        new_object.name = params[:name]
        new_object.code = params[:code]
        new_object.start_time = params[:start_time]
        new_object.duration = params[:duration]
        
        new_object.save
        
        return new_object
    end
    
    def update_object( params )
        self.name = params[:name]
        self.code = params[:code]
        self.start_time = params[:start_time]
        self.duration = params[:duration]
       
        self.save
       
        return self
    end
    
    def delete_object
        #1. Jika ada employee di shift tidak boleh didelete
        if self.employees.count != 0
            self.errors.add(:generic_errors, "Sudah ada employee")
            return self
        end
        
        self.destroy
    end
end
