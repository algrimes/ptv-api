class Platform
  
  require_relative 'stop'
  require_relative 'direction'
  
  attr_reader :stop, :direction
  
  def initialize api, platform
    @stop = Stop.new(api, platform["stop"])
    @direction = Direction.new(api, platform["direction"])
  end
end