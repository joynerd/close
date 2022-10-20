# frozen_string_literal: true

RSpec.describe Close::APIResource do

  describe ".resource_url" do
    it "Raises a not implmented error" do
      expect{Close::APIResource.resource_url}.to raise_error(NotImplementedError)
    end
  end
  
  describe "#dirty?" do
    context "when the resource is not dirty" do
      it "returns false" do
        expect(Close::APIResource.new.dirty?).to eq(false)
      end
    end
    context "when the resource has unsaved values" do
      it "returns true" do
        expect(Close::APIResource.new(name: "Test").dirty?).to eq(true)
      end
    end
  end
  
end
