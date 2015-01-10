require 'ptv_api'

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
  
end
