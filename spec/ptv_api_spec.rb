require 'ptv_api'
require 'json'
require 'model/location'
require 'model/stop'
require 'open-uri'

describe "ptv api" do
  
  before do
    @devid = "my-devid"
    @key = "my-key"
    @api = PTVApi.new(@devid, @key)
  end
  
  it "can perform the healthcheck" do
    response = @api.healthcheck
    expect response.include? "securityTokenOK"
  end
  
  it "can get stops near you" do
    response = double("Object", :read => [
      {"result" => { "stop_id" => 123, "transport_type" => "tram" }},
      {"result" => { "stop_id" => 456, "transport_type" => "train" }}
    ].to_json)
    
    expect(OpenURI).to receive(:open_uri).and_return(response)
    
    stops = @api.stops_near_me Location.new("123.2443", "-64.432")
    
    expect(stops[0].transport_type).to be_a(TransportType::Tram)
    expect(stops[0].stop_id).to be(123)
    expect(stops[1].transport_type).to be_a(TransportType::Train)
    expect(stops[1].stop_id).to be(456)
  end 
  
  it "can get broad next departures" do
    response = double("Object", :read => {"values" => [
      "platform" => {
        "stop" => {
          "transport_type" => "train"
        },
        "direction" => {
          "line" => {
            "transport_type" => "train"              #WTF...
          }
        }
      },
      "run" => {
        "transport_type" => "train"
      },
      "time_timetable_utc" => "2020-01-10T14:30Z"
    ]}.to_json)
    
    expect(OpenURI).to receive(:open_uri).and_return(response)
    
    departures = @api.broad_next_departures Stop.new({"stop_id" => 123, "transport_type" => "tram" }), 5
    
    expect(departures[0].platform.stop.transport_type).to be_a(TransportType::Train)
    expect(departures[0].platform.direction.line.transport_type).to be_a(TransportType::Train)
    expect(departures[0].run.transport_type).to be_a(TransportType::Train)
    expect(departures[0].time.year).to be(2020)
  end
  
end
