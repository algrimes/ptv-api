class Stop
  
  require_relative 'transport_type'
  require_relative 'location'
  
  attr_reader :suburb, :transport_type, :location_name, :location, :stop_id
  
  def initialize(api, args)
    @api = api
    @transport_type =  TransportType.from_s args["transport_type"]
    @location = Location.new(args["lat"], args["long"])
    @suburb = args["suburb"]
    @stop_id = args["stop_id"]
    @location_name = args["location_name"]
  end
  
  def departures
    @api.broad_next_departures(self)
  end
  
  def lines
    @api.broad_next_departures(self).collect { |departure| departure.platform.direction.line }.uniq { |line| line.line_id }
  end
  
  def platforms
    @api.broad_next_departures(self, 1).collect { |departure| departure.platform }
  end
  
end