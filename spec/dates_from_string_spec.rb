require 'spec_helper'

describe DatesFromString do
  subject { DatesFromString.new }

  describe '#get_structure' do

    it 'find one year' do
      input = 'he was born in 1990'
      output = [{:type=>:year, :value=>"1990", :distance=>nil, :key_words=>[]}]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find two year' do
      input = '1990 1988 year of his probably birthday'
      output = [
        {:type=>:year, :value=>"1990", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1988", :distance=>nil, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find many year and many distance' do
      input = '1990 1988 year 2013 bla bla bla 2015 a b c d i f g qwe 2016'
      output = [
        {:type=>:year, :value=>"1990", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1988", :distance=>2, :key_words=>[]},
        {:type=>:year, :value=>"2013", :distance=>4, :key_words=>[]},
        {:type=>:year, :value=>"2015", :distance=>9, :key_words=>[]},
        {:type=>:year, :value=>"2016", :distance=>nil, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find full date year month and day format one' do
      input = '2015-02-02'
      output = [
        {:type=>:year, :value=>"2015", :distance=>nil, :key_words=>[]},
        {:type=>:month, :value=>"02", :distance=>nil, :key_words=>[]},
        {:type=>:day, :value=>"01", :distance=>nil, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end
  end
end
