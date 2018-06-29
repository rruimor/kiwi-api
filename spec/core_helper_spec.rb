require 'spec_helper'

describe CoreHelper do
  def rubify_keys(hash)
    CoreHelper.rubify_keys(hash)
  end

  def camelize_keys(hash)
    CoreHelper.camelize_keys(hash)
  end

  let(:camelized_hash) { {fooBar: 1, anotherFooBar: 2} }
  let(:snaked_case_hash) { {foo_bar: 1, another_foo_bar: 2} }

  describe "#rubify_keys" do
    it "converts they keys to a snaked case hash" do
      expect(rubify_keys(snaked_case_hash)).to eq(snaked_case_hash)
    end

    it "does nothing when the case is already snaked case" do
      expect(rubify_keys(camelized_hash)).to eq(snaked_case_hash)
    end
  end

  describe "#camelize_keys" do
    it "converts snaked case to camelized" do
      expect(camelize_keys(snaked_case_hash)).to eq(camelized_hash)
    end

    it "does nothing when it is already camelized" do
      expect(camelize_keys(camelized_hash)).to eq(camelized_hash)
    end
  end
end
