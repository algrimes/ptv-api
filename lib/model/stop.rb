class Stop
  
  require 'model/transport_type'
  require 'model/location'
  
  attr_reader :suburb, :transport_type, :location_name, :location, :stop_id
  
  def initialize(args)
    @transport_type =  TransportType.from_s args.delete("transport_type")
    @location = Location.new(args.delete("lat"), args.delete("long"))
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
  
end