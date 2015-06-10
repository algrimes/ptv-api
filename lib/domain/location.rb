class Location
  
  attr_reader :lat, :long
  
  def initialize(api, lat, long)
    @api = api
    @lat = lat
    @long = long
  end
  
  def stops_near_me transport_type=nil
    api.stops_near_me(self, transport_type)
  end
  
end