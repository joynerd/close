# frozen_string_literal: true

RSpec.describe Close::Lead do
  
  describe ".resource_url" do
    it "returns the correct resource url" do
      expect(Close::Lead.resource_url).to eq("api/v1/lead/")
    end
  end

  describe ".list" do
    it "returns a list of leads" do
      list = Close::Lead.list
      expect(list).to be_a(Array)
      expect(list.first).to be_a(Close::Lead)
    end
  end
  
end
