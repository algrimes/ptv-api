class PTVApi
  
  require 'open-uri'
  require 'openssl'
  require 'json'
  require_relative 'model/stop'
  require_relative 'model/departure'
  
  
  def initialize dev_id, key
    @dev_id = dev_id
    @key = key
  end
  
  def healthcheck
    send_request "/v2/healthcheck"
  end 
  
  def stops_near_me location
    response = send_request "/v2/nearme/latitude/#{location.lat}/longitude/#{location.long}"
    response.map { |result| Stop.new(result["result"]) }
  end
  
  def broad_next_departures stop, number_of_results=5
    to_departures(send_request "/v2/mode/#{stop.transport_type.id}/stop/#{stop.stop_id}/departures/by-destination/limit/#{number_of_results}")
  end
  
  def specific_next_departures stop, direction, number_of_results=5
    to_departures(send_request "/v2/mode/#{stop.transport_type.id}/line/#{direction.line.line_id}/stop/#{stop.stop_id}/directionid/#{direction.direction_id}/departures/all/limit/#{number_of_results}")
  end
  
  def stopping_pattern departure
    to_departures(send_request "/v2/mode/#{departure.platform.stop.transport_type.id}/run/#{departure.run.run_id}/stop/#{departure.platform.stop.stop_id}/stopping-pattern")
  end
  
  private 
  
  def send_request path
    uri = URI::HTTP.build({ 
      :scheme => "http", 
      :host => "timetableapi.ptv.vic.gov.au", 
      :path => path, 
      :query => "devid=#{@dev_id}"})
      
    signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, @key, uri.path + "?" + uri.query)
    uri.query = uri.query + "&signature=#{signature}"
    JSON.parse(open(uri).read)
  end
  
  def to_departures response
    response["values"].map { |departure| Departure.new(departure) }
  end
  
end