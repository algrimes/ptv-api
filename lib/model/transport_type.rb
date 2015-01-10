class TransportType
  
  class Train
    def id 
      0 
    end
  end
  
  class Tram
    def id 
      1 
    end
  end
  
  class Bus
    def id 
      2 
    end
  end
  
  class Vline
    def id 
      3 
    end
  end
  
  class Nightrider
    def id 
      4 
    end
  end
  
  def self.from_s transport_type
    const_get("TransportType::#{[transport_type.slice(0).capitalize, transport_type.slice(1..-1)].join}").new
  end
  
end