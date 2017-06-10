require 'spec_helper'

describe String do
  it "#camelize" do
    expect("hola".camelize).to eql("hola")
    expect("hola_que_tal".camelize).to eql("holaQueTal")
    expect("alreadyCamelized".camelize).to eql("alreadyCamelized")
  end

  it "#rubify" do
    expect("hola".rubify).to eql("hola")
    expect("holaCaracola".rubify).to eql("hola_caracola")
    expect("hola_caracola".rubify).to eql("hola_caracola")

  end
end

describe Hash do
  let(:camelized_hash) { Hash.new(fooBar: 1, anotherFooBar: 2) }
  let(:snaked_case_hash) { Hash.new(foo_bar: 1, another_foo_bar: 2) }

  it "#rubify_keys" do
    expect(camelized_hash.rubify_keys).to eq(snaked_case_hash)
    expect(snaked_case_hash.rubify_keys).to eq(snaked_case_hash)
  end

  it "#camelize_keys" do
    expect(snaked_case_hash.camelize_keys).to eq(camelized_hash)
    expect(camelized_hash.camelize_keys).to eq(camelized_hash)
  end
end