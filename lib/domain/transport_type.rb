module TransportType
  
  TRAIN = 0
  TRAM = 1
  BUS = 2
  VLINE = 3
  NIGHTRIDER = 4
  
  def self.from_s transport_type
    const_get("TransportType::#{transport_type.upcase}")
  end
  
end