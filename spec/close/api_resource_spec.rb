# frozen_string_literal: true

RSpec.describe Close::ApiResource do

  describe ".resource_url" do
    it "Raises a not implmented error" do
      expect{Close::ApiResource.resource_url}.to raise_error(NotImplementedError)
    end
  end
  
  describe "#dirty?" do
    context "when the resource is not dirty" do
      it "returns false" do
        expect(Close::ApiResource.new.dirty?).to eq(false)
      end
    end
    context "when the resource has unsaved values" do
      it "returns true" do
        expect(Close::ApiResource.new(name: "Test").dirty?).to eq(true)
      end
    end
    context "when the resource has unsaved values and is saved" do
      it "returns false" do
        resource = Close::ApiResource.new(name: "Test")
        resource.save
        expect(resource.dirty?).to eq(false)
      end
    end
  end
  
end
