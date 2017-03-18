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

    it 'find full date year month and day format USA' do
      date_from_string = DatesFromString.new(date_format: :usa)
      input = '01/23/1988'
      output = [
        {:type=>:year, :value=>"1988", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"23", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"01", :distance=>0, :key_words=>[]}
      ]

      expect(date_from_string.get_structure(input)).to eq(output)
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
        {:type=>:year, :value=>"1984", :distance=>2, :key_words=>[]},
        {:type=>:year, :value=>"1986", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'day month by string and year' do
      input = '10 Dec 1948'
      output = [
        {:type=>:day, :value=>"10", :distance=>1, :key_words=>[]},
        {:type=>:month, :value=>"12", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1948", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'day month ny string and year' do
      input = '10 Dec 1948 ane one more year 1988'
      output = [
        {:type=>:day, :value=>"10", :distance=>1, :key_words=>[]},
        {:type=>:month, :value=>"12", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1948", :distance=>5, :key_words=>[]},
        {:type=>:year, :value=>"1988", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'day month by string full month' do
      input = '10 April 1948'
      output = [
        {:type=>:day, :value=>"10", :distance=>1, :key_words=>[]},
        {:type=>:month, :value=>"04", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1948", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'grap date from not valid string one' do
      input = '[CDATA[11.07.1989]]'
      output = [
        {:type=>:year, :value=>"1989", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"07", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"11", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'grap date circa year and full data' do
      input = 'circa 1960 and full date 07 Jun 1941'
      output = [
        {:type=>:year, :value=>"1960", :distance=>4, :key_words=>[]},
        {:type=>:day, :value=>"07", :distance=>1, :key_words=>[]},
        {:type=>:month, :value=>"06", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1941", :distance=>0, :key_words=>[]},
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'grap date between tho dates and add key words' do
      obj = DatesFromString.new(['and'])
      input = 'between 1960 and 1965'
      output = [
        {:type=>:year, :value=>"1960", :distance=>2, :key_words=>['and']},
        {:type=>:year, :value=>"1965", :distance=>0, :key_words=>[]},
      ]

      expect(obj.get_structure(input)).to eq(output)
    end

    it 'grap data from long text' do
      input = "For 16 years Putin was an officer in the KGB,
               rising to the rank of Lieutenant Colonel before
               he retired to enter politics in his native Saint
               Petersburg in 1991. He moved to Moscow in 1996 and
               joined President Boris Yeltsin's administration where
               he rose quickly, becoming Acting President on 31 December
               1999 when Yeltsin unexpectedly resigned"
      output = [
        {:type=>:day, :value=>"16", :distance=>28, :key_words=>[]},
        {:type=>:year, :value=>"1991", :distance=>6, :key_words=>[]},
        {:type=>:year, :value=>"1996", :distance=>15, :key_words=>[]},
        {:type=>:day, :value=>"31", :distance=>1, :key_words=>[]},
        {:type=>:month, :value=>"12", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"1999", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'grap data from long text two' do
      input = "In September 2011, following a change in the law extending
               the presidential term from four years to six,[5] Putin announced
               that he would seek a third, non-consecutive term as President in
               the 2012 presidential election, an announcement which led to
               large-scale protests in many Russian cities. In March 2012 he won the election,
               which was criticized for procedural irregularities, and is serving a six-year term"
      output = [
        {:type=>:month, :value=>"09", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"2011", :distance=>30, :key_words=>[]},
        {:type=>:year, :value=>"2012", :distance=>15, :key_words=>[]},
        {:type=>:month, :value=>"03", :distance=>1, :key_words=>[]},
        {:type=>:year, :value=>"2012", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'grap data from long text three' do
      input = "During Putin  first premiership and presidency (1999–2008)
               real incomes in Russia rose by a factor of 2.5, while real
               wages more than tripled; unemployment and poverty more than halved.
               Russians' self-assessed life satisfaction also rose significantly.
               Putin's first presidency was marked by high economic growth: the
               Russian economy grew for eight straight years, seeing GDP increase by
               72% in PPP (as for nominal GDP, 600%).This growth was a combined result
               of the 2000s commodities boom, high oil prices, as well as prudent economic
               and fiscal policies."
      output = [
        {:type=>:year, :value=>"1999", :distance=>6, :key_words=>['-']},
        {:type=>:year, :value=>"2008", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find month.year' do
      input = "10.1964"
      output = [
        {:type=>:year, :value=>"1964", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"10", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find year.moth' do
      input = "1964.10"
      output = [
        {:type=>:year, :value=>"1964", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"10", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'no string' do
      input = ""
      output = nil
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'nil' do
      input = nil
      output = nil
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'no date' do
      input = "bla bla no date"
      output = []
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'no date' do
      input = "bla bla no date"
      output = []
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'get crash date' do
      input = "29-2-1969"
      output = [
        {:type=>:year, :value=>"1969", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"2", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"29", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'get crash date two' do
      input = "1969-2-29"
      output = [
        {:type=>:year, :value=>"1969", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"2", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"29", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'get crash date two' do
      input = "1969-2-2"
      output = [
        {:type=>:year, :value=>"1969", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"2", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"2", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'get crash date one more' do
      input = "2-2-1969"
      output = [
        {:type=>:year, :value=>"1969", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"2", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"2", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'get crash date one more' do
      input = "2-02-1969"
      output = [
        {:type=>:year, :value=>"1969", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"02", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"2", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end

    it 'get crash date revert' do
      input = "1969-02-2"
      output = [
        {:type=>:year, :value=>"1969", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"02", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"2", :distance=>0, :key_words=>[]},
      ]
      expect(subject.get_structure(input)).to eq(output)
    end


    it 'find full date year month and day and time format one' do
      input = '2015-02-02 in 23:00:10'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"02", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"02", :distance=>2, :key_words=>[]},
        {:type=>:time, :value=>"23:00:10", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find dates in simple structure' do
      input = '23.04.2013'
      output = ['2013-04-23']

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find dates in simple structure 2' do
      input = '2015-04-01'
      output = ['2015-04-01']

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find dates in simple structure 3' do
      input = '01-04-2015'
      output = ['2015-04-01']

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find dates in simple structure 4' do
      input = 'bla bla bla 01-04-2015'
      output = ['2015-04-01']

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find dates in simple structure 5' do
      input = 'bla bla bla 01-04-2015 идф идф идф'
      output = ['2015-04-01']

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find single digit days' do
      input = '3/13/2017'
      output = ['2017-13-3']

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find dates in simple structure 5' do
      input = ""
      output = []

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find full date year month and day and time format two' do
      input = 'забрать машину из ремонта 2015-02-02 23:00:10'
      output = [
        {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
        {:type=>:month, :value=>"02", :distance=>0, :key_words=>[]},
        {:type=>:day, :value=>"02", :distance=>5, :key_words=>[]},
        {:type=>:time, :value=>"23:00:10", :distance=>0, :key_words=>[]}
      ]

      expect(subject.get_structure(input)).to eq(output)
    end

    it 'find dates in simple structure 6' do
      input = "забрать машину из ремонта 2015-02-02 23:00:10"
      output = ["2015-02-02 23:00:10"]

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find dates in simple structure 7' do
      input = "Создай задачу забрать машину из ремонта 2015-02-02 в 23:00:10"
      output = ["2015-02-02 23:00:10"]

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find dates in simple structure 8' do
      input = "Создай задачу забрать машину из ремонта 2015-02-02 в 23:00"
      output = ["2015-02-02 23:00"]

      expect(subject.find_date(input)).to eq(output)
    end

    it 'find dates in simple structure 9' do
      input = "Создай задачу забрать машину из ремонта 2015-02-02 23:00"
      output = "Создай задачу забрать машину из ремонта"
      subject.find_date(input)
      expect(subject.get_clear_text).to eq(output)
    end

    it 'find dates in simple structure 10' do
      input = "Создай задачу забрать машину из ремонта 2015-02-02 23:30:40"
      output = "Создай задачу забрать машину из ремонта"
      subject.find_date(input)
      expect(subject.get_clear_text).to eq(output)
    end

    it "find year in email one" do
      date_from_string = DatesFromString.new()
      input = 'test1988@gmail.com'
      output = "1988"

      expect(date_from_string.email_date(input)).to eq(output)
    end

    it "find year in email two" do
      date_from_string = DatesFromString.new()
      input = '1test1988@gmail.com'
      output = "1988"

      expect(date_from_string.email_date(input)).to eq(output)
    end

    it "find year in email three" do
      date_from_string = DatesFromString.new()
      input = '1test11988@gmail.com'
      output = "1988"

      expect(date_from_string.email_date(input)).to eq(output)
    end

  end
end
