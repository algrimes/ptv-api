class Platform
  
  require 'model/stop'
  require 'model/direction'
  
  attr_reader :stop, :direction
  
  def initialize platform
    @stop = Stop.new(platform["stop"])
    @direction = Direction.new(platform["direction"])
  end
end