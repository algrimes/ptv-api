class Search
  
  def initialize api
    @api = api
  end
  
  def stop_search name
    @api.search name
  end
  
  def stop_search topLeftLat, topLeftLong, bottomRightLat, bottomRightLong
    
  end
  
  def line_search name
    
  end
  
end