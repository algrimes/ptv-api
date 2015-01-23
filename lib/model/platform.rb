class Platform
  
  require_relative 'stop'
  require_relative 'direction'
  
  attr_reader :stop, :direction
  
  def initialize platform
    @stop = Stop.new(platform["stop"])
    @direction = Direction.new(platform["direction"])
  end
end