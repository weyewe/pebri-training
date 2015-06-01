
(1.upto 100).each do |x|
    Employee.create_object( 
        :name => "Pebri #{x}",
        :code => "#{x}"
    )
end
