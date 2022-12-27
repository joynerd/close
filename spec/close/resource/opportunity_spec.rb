# frozen_string_literal: true

RSpec.describe Close::Opportunity do
  
  describe ".resource_url" do
    it "returns the correct resource url" do
      expect(Close::Opportunity.resource_url).to eq("api/v1/opportunity/")
    end
  end
  
end
