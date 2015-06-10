class Platform
  
  require_relative 'stop'
  require_relative 'direction'
  
  attr_reader :stop, :direction
  
  def initialize api, platform
    @api = api
    @stop = Stop.new(api, platform["stop"])
    @direction = Direction.new(api, platform["direction"])
  end
  
  def departures
    @api.specific_next_departures(@stop, @direction)
  end
  
end