class Direction
  
  require 'model/line'
  
  attr_reader :line, :linedir_id, :direction_name
  
  def initialize direction
    @line = Line.new(direction.delete("line"))
    direction.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
  
end