class Line
  
  require_relative 'transport_type'
  
  attr_reader :transport_type, :line_id, :line_name, :line_number
  
  def initialize args
    @transport_type = TransportType.from_s args.delete("transport_type")
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
  
end