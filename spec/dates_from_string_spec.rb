require 'spec_helper'

describe DatesFromString do
  subject { DatesFromString.new(['between','-']) }

  describe '#get_structure' do

    it 'find one year' do
      input = 'he was born in 1990'
      output = [{:type=>:year, :value=>"1990", :distance=>0, :key_words=>[]}]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find two year' do
      input = '1990 1988 year of his probably birthday'
      output = [
        {:type=>:year, :value=>"1990", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1988", :distance=>0, :key_words=>[]}
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
        {:type=>:year, :value=>"2016", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find full date year month and day format one' do
      input = '2015-02-02'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"02", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"02", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find full date year month and day format two' do
      input = '2015.02.02'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"02", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"02", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find full date year month and day format three' do
      input = '02-02-2015'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"02", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"02", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find full date year month and day format four' do
      input = '02.02.2015'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"02", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"02", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find full date year month and day format five' do
      input = '12/07/2014'
      output = [
        {:type=>:year, :value=>"2014", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"07", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"12", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find full date year month and day format six' do
      input = '2013/07/09'
      output = [
        {:type=>:year, :value=>"2013", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"07", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"09", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find full date and year ' do
      input = '2013/07/09 one date and he born in 1990'
      output = [
        {:type=>:year, :value=>"2013", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"07", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"09", :distance=>7, :key_words=>[]},
        {:type=>:year, :value=>"1990", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find short date one' do
      input = '00/00/2015 one year'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"00", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"00", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find short date two' do
      input = '00/10/2015 one year'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"10", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"00", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find short date three' do
      input = '2015/10/00 one year'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"10", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"00", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find short date four' do
      input = '2015/00/00 one year'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"00", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"00", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'year and special word between' do
      input = '1988 between 1990'
      output = [
        {:type=>:year, :value=>"1988", :distance=>2, :key_words=>['between']},
        {:type=>:year, :value=>"1990", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'year and special sympol' do
      input = '1988 - 1990'
      output = [
        {:type=>:year, :value=>"1988", :distance=>2, :key_words=>['-']},
        {:type=>:year, :value=>"1990", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'year and special sympol other way' do
      input = '1988-1990'
      output = [
        {:type=>:year, :value=>"1988", :distance=>0, :key_words=>['-']},
        {:type=>:year, :value=>"1990", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'year and special sympol other way and one more year' do
      input = '1988-1990 and 2000'
      output = [
        {:type=>:year, :value=>"1988", :distance=>0, :key_words=>['-']},
        {:type=>:year, :value=>"1990", :distance=>2, :key_words=>[]},
        {:type=>:year, :value=>"2000", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'year and special sympol other way and year and full date' do
      input = '1988-1990 and 2000 and one more date 28.04.2015'
      output = [
        {:type=>:year, :value=>"1988", :distance=>0, :key_words=>['-']},
        {:type=>:year, :value=>"1990", :distance=>2, :key_words=>[]},
        {:type=>:year, :value=>"2000", :distance=>5, :key_words=>[]},
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"04", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"28", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'month by string and year' do
      input = 'August 1961'
      output = [
        {:type=>:month, :value=>"08", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1961", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'month by string and year and one more' do
      input = 'August 1961'
      output = [
        {:type=>:month, :value=>"08", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1961", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)

      input_2 = '2012'
      output_2 = [
        {:type=>:year, :value=>"2012", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input_2)).to eq(output_2)
    end

    it 'two year and between' do
      input = 'Between 1984 and 1986'
      output = [
        {:type=>:year, :value=>"1984", :distance=>3, :key_words=>[]},
        {:type=>:year, :value=>"1986", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'day month ny string and year' do
      input = '10 Dec 1948'
      output = [
        {:type=>:year, :value=>"1984", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"12", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"10", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end
  end
end
