class Line
  
  require_relative 'transport_type'
  
  attr_reader :transport_type, :line_id, :line_name, :line_number
  
  def initialize api, args
    @api = api
    @transport_type = TransportType.from_s args["transport_type"]
    @line_id = args["line_id"]
    @line_name = args["line_name"]
    @line_number = args["line_number"]    
  end
  
  def stops
    @api.stops_on_a_line(self)
  end
  
end