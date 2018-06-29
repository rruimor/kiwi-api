require 'spec_helper'

describe KiwiApi::FlightResult do
  it "should be able to initialze a Flight Result" do
    expect(KiwiApi::FlightResult.new).to_not be_nil
  end
end
