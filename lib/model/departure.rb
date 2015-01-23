class Departure
  
  require_relative 'platform'
  require_relative 'run'
  
  attr_reader :platform, :run, :time
  
  def initialize departure
    @platform = Platform.new(departure["platform"])
    @run = Run.new(departure["run"])
    @time = Time.parse(departure["time_timetable_utc"])
  end
  
end