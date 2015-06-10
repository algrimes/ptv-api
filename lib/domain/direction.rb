class Direction
  
  require_relative 'line'
  
  attr_reader :line, :direction_id, :linedir_id, :direction_name
  
  def initialize api, direction
    @line = Line.new(api, direction["line"])
    @direction_id = direction["direction_id"]
    @linedir_id = direction["linedir_id"]
    @direction_name = direction["direction_name"]
  end
  
end