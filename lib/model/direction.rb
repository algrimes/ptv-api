class Direction
  
  require_relative 'line'
  
  attr_reader :line, :direction_id, :linedir_id, :direction_name
  
  def initialize direction
    @line = Line.new(direction.delete("line"))
    direction.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
  
end