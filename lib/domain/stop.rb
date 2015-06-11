class Stop
  
  require_relative 'transport_type'
  require_relative 'location'
  
  attr_reader :suburb, :transport_type, :location_name, :location, :stop_id
  
  def initialize(api, args)
    @api = api
    @transport_type =  TransportType.from_s args["transport_type"]
    @location = Location.new(@api, args["lat"], args["lon"])
    @suburb = args["suburb"]
    @stop_id = args["stop_id"]
    @location_name = args["location_name"]
  end
  
  def departures
    @api.broad_next_departures(self)
  end
  
  def lines_served
    @api.lines(@transport_type).select { |line| line.stops.any? { |stop| stop.stop_id == @stop_id } }
  end
  
  def platforms
    @api.broad_next_departures(self, 1).collect { |departure| departure.platform }
  end
  
end