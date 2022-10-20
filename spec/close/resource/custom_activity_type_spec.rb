# frozen_string_literal: true

RSpec.describe Close::CustomActivityType do
  
  describe ".resource_url" do
    it "returns the correct resource url" do
      expect(Close::CustomActivityType.resource_url).to eq("api/v1/custom_activity/")
    end
  end

  describe ".list" do
    it "returns a list of custom activity types" do
      list = Close::CustomActivityType.list
      expect(list).to be_a(Array)
      expect(list.first).to be_a(Close::CustomActivityType)
    end
  end
  
end
