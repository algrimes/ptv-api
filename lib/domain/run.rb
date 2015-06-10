class Run
  
  require_relative 'transport_type'
  
  attr_reader :transport_type, :run_id, :destination_id, :destination_name
  
  def initialize run
    @transport_type =  TransportType.from_s run["transport_type"]
    @run_id = run["run_id"]
    @destination_id = run["destination_id"]
    @destination_name = run["destination_name"]
  end
  
end