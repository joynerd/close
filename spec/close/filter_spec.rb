# frozen_string_literal: true

RSpec.describe Close::Filter do

  describe ".load_query" do
    context "when the query exists in memory" do
      it "returns the query" do
        Close::Filter.add_query(:test, "test")
        expect(Close::Filter.load_query(:test)).to eq("\"test\"")
      end
    end
    context "when the query does not exist in memory but in file" do
      it "returns the query" do
        expect(Close::Filter.load_query(:find_lead_by_contact_email)).to be_a(String)
      end
    end
    context "when the query does not exist in memory or file" do
      it "raises an error" do
        expect{Close::Filter.load_query(:unknown)}.to raise_error(Close::QueryNotFoundError)
      end
    end
  end

  describe ".add_query" do
    context "no query exists with that name" do
      it "adds the query" do
        Close::Filter.add_query(:test, "test")
        expect(Close::Filter.class_variable_get(:@@queries)['test']).to eq("\"test\"")
      end
    end
    context "a query exists with that name" do
      it "overwrites the query" do
        Close::Filter.add_query(:test, "test")
        Close::Filter.add_query(:test, "test2")
        expect(Close::Filter.class_variable_get(:@@queries)['test']).to eq("\"test2\"")
      end
    end
  end

  describe ".apply_params" do
    context "with a single param instance" do
      it "returns a string with the param replaced" do
        expect(Close::Filter.apply_params("%TEST%", {test: "foo"})).to eq("foo")
      end
    end
    context "with multiple params" do
      it "returns a string with the params replaced" do
        expect(Close::Filter.apply_params("%TEST% %TEST_TWO%", {test: "foo", test_two: "bar"})).to eq("foo bar")
      end
    end
  end

  describe ".preflight_params" do
    context "when all params are present" do
      it "does not raise an error" do
        expect{Close::Filter.preflight_params({name: "Test", type: "string"}, ['name', 'type'])}.not_to raise_error
      end
    end
    context "when a required param is missing" do
      it "raises an error" do
        expect{Close::Filter.preflight_params({name: "Test"}, ['name', 'type'])}.to raise_error(Close::MissingParameterError)
      end
    end
  end

  describe ".load_query_from_file" do
    context "when the file exists" do
      it "returns a string" do
        expect(Close::Filter.load_query_from_file("find_lead_by_contact_email")).to be_a(String)
      end
    end
    context "when the file does not exist" do
      it "raises an error" do
        expect{Close::Filter.load_query_from_file("non_existent_file")}.to raise_error(Close::QueryNotFoundError)
      end
    end
  end

  describe ".find_params" do
    context "when there are many params" do
      it "returns the correct params" do
        params = Close::Filter.find_params("this is a %TEST%, that should only return %TEST% and %TEST_TWO% but not %TEST_3% or %TEST_THREE")
        expect(params).to eq(['test', 'test_two'])
      end
    end
  end
  
end
