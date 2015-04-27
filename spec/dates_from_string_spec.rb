require 'spec_helper'

describe DatesFromString do
  subject { DatesFromString.new }

  # it 'has a version number' do
  #   expect(DatesFromString::VERSION).not_to be nil
  # end

  it 'get date structure from string' do
    input = 'he was born in 1988'
    output = [[:year,'1988',nil,nil]]
    expect(subject.get_structure(input)).to eq(output)
  end
end
