class Model::Stop
  
  attr_reader :suburb, :transport_type, :location_name, :lat, :long, :stop_id
  
  def initialize(args)
    @transport_type =  Model::TransportType.from_s args.delete("transport_type")
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
  
end