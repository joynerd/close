# frozen_string_literal: true

RSpec.describe Close::Activity do
  
  describe ".resource_url" do
    it "returns the correct resource url" do
      expect(Close::Activity.resource_url).to eq("api/v1/activity/")
    end
  end

  describe ".list" do
    it "returns a list of custom activity types" do
      list = Close::Activity.list
      expect(list).to be_a(Array)
      expect(list.first).to be_a(Close::Activity)
    end
  end
  
end
