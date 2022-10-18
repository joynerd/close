# frozen_string_literal: true

RSpec.describe Close::CustomActivityType do
  
  describe ".resource_url" do
    it "returns the correct resource url" do
      expect(Close::CustomActivityType.resource_url).to eq("api/v1/custom_activity/")
    end
  end
  
end
