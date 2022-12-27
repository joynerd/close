# frozen_string_literal: true

RSpec.describe Close::Organization do
  
  describe ".resource_url" do
    it "returns the correct resource url" do
      expect(Close::Organization.resource_url).to eq("api/v1/organization/")
    end
  end
  
end
