class Departure
  
  require_relative 'platform'
  require_relative 'run'
  require 'time_difference'
  
  attr_reader :platform, :run, :time, :direction
  
  def initialize api, departure
    @platform = Platform.new(api, departure["platform"])
    @run = Run.new(departure["run"])
    @time = Time.parse(departure["time_timetable_utc"])
  end
  
  def departing_in_mins
    TimeDifference.between(Time.now, @time.localtime).in_minutes.to_i.to_s
  end
  
end