class PTVApi
  
  require 'open-uri'
  require 'openssl'
  require 'json'
  require 'uri'
  require 'addressable/uri'
  require_relative 'domain/stop'
  require_relative 'domain/departure'
  require_relative 'domain/transport_type'
  
  
  def initialize dev_id, key
    @dev_id = dev_id
    @key = key
  end
  
  def healthcheck
    send_request "/v2/healthcheck"
  end 
  
  def stops_near_me location, transport_type=nil
    response = send_request "/v2/nearme/latitude/#{location.lat}/longitude/#{location.long}"
    SearchResults.new(self, response).stops(transport_type)
  end
  
  def lines transport_type, name=nil
    response = send_request "/v2/lines/mode/#{transport_type}", name ? {:name => name} : {}
    response.map { |line| Line.new(self, line) }
  end
  
  def stops_on_a_line line
    response = send_request "/v2/mode/#{line.transport_type}/line/#{line.line_id}/stops-for-line"
    response.map { |result| Stop.new(self, result) }
  end
  
  def search name
    response = send_request "/v2/search/#{URI::escape(name)}"
    SearchResults.new(self, response)
  end
  
  def broad_next_departures stop, number_of_results=5
    to_departures(send_request "/v2/mode/#{stop.transport_type}/stop/#{stop.stop_id}/departures/by-destination/limit/#{number_of_results}")
  end
  
  def specific_next_departures stop, direction, number_of_results=5
    to_departures(send_request "/v2/mode/#{stop.transport_type}/line/#{direction.line.line_id}/stop/#{stop.stop_id}/directionid/#{direction.direction_id}/departures/all/limit/#{number_of_results}")
  end
  
  def stopping_pattern departure
    to_departures(send_request "/v2/mode/#{departure.platform.stop.transport_type}/run/#{departure.run.run_id}/stop/#{departure.platform.stop.stop_id}/stopping-pattern")
  end
  
  
  def send_request path, query={}
    
    query_builder = Addressable::URI.new
    query_builder.query_values = { :devid => @dev_id }.merge query
    
    uri = URI::HTTP.build({ 
      :scheme => "http", 
      :host => "timetableapi.ptv.vic.gov.au", 
      :path => path, 
      :query => query_builder.query})
      
    signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, @key, uri.path + "?" + uri.query)
    uri.query = uri.query + "&signature=#{signature}"
    JSON.parse(open(uri).read)
  end
  
  def to_departures response
    response["values"].map { |departure| Departure.new(self, departure) }
  end
  
  class SearchResults
    
    def initialize api, results
      @api = api
      @stops, @lines = results.partition { |result| result["type"] == "stop" }
    end
    
    def stops transport_type=nil
      stops = @stops.map { |stop| Stop.new(@api, stop["result"]) }
      filter_by_transport_type(stops, transport_type)
    end
    
    def lines transport_type=nil
      lines = @lines.map { |line| Line.new(@api, line["result"])}
      filter_by_transport_type(lines, transport_type)
    end
    
    def all
      self.stops.join self.lines
    end
    
    private 
    
    def filter_by_transport_type results, transport_type=nil
      results.select { |result| transport_type ? (result.transport_type == transport_type) : true }
    end
    
  end
  
end