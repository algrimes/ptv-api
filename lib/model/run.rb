class Run
  
  require 'model/transport_type'
  
  attr_reader :transport_type, :run_id, :destination_id, :destination_name
  
  def initialize run
    @transport_type =  TransportType.from_s run.delete("transport_type")
    run.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
  
end