[![Gem](https://img.shields.io/gem/v/dates_from_string.svg?style=flat-square)](https://rubygems.org/gems/dates_from_string)
[![Build Status](https://travis-ci.org/sergey-chechaev/dates_from_string.svg?branch=master)](https://travis-ci.org/sergey-chechaev/dates_from_string)
# DatesFromString

Flexible solution for finding dates in text. After parsing text, the gem return flexible structure of dates, that allow getting a date by you own logic use distance for next date type and keywords between dates. Gem also support find a year in email and find a date in structure.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dates_from_string'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dates_from_string

## Usage


```ruby
text = "1988-1990 and 2000 and one more date 04.04.2015"        # parsing text
key_words = ['between','-']                                     # you can define special separator
options = {
  date_format: :usa,                                            # year,day,month by default year,month,day
  ordinals: ['nd', 'st', 'th']                                  # a string list that might accompany a day, default none
}                               
dates_from_string = DatesFromString.new(key_words, options)     # define DatesFromString object
dates_from_string.get_structure(text)                           # parsing text

#=> returns
#  [{:type=>:year, :value=>"1988", :distance=>0, :key_words=>["-"]},
#  {:type=>:year, :value=>"1990", :distance=>2, :key_words=>[]},
#  {:type=>:year, :value=>"2000", :distance=>5, :key_words=>[]},
#  {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
#  {:type=>:day, :value=>"04", :distance=>0, :key_words=>[]},
#  {:type=>:month, :value=>"04", :distance=>0, :key_words=>[]}]

:type       # type of date year, month or day
:value      # value of date
:distance   # distance for next date type
:key_words  # special words, symbols that separate dates

# find date in structure
text = "забрать машину из ремонта 2015-02-02 23:00:10"
dates_from_string = DatesFromString.new
dates_from_string.find_date(text)

#=> return
#  ["2015-02-02 23:00:10"]


# find year in email
date_from_string = DatesFromString.new()
input = '1test1988@gmail.com'
date_from_string.email_date(input)
#=> return
#  "1988"
```





Examples:

```ruby
input = '1988 between 1990'
key_words = ['between']
dates_from_string = DatesFromString.new(key_words)
dates_from_string.get_structure(input)

#=> return
#  [{:type=>:year, :value=>"1988", :distance=>2, :key_words=>["between"]},
#  {:type=>:year, :value=>"1990", :distance=>0, :key_words=>[]}]

input = '2013/07/09 one date and he born in 1990'
dates_from_string.get_structure(input)

#=> return
#  [{:type=>:year, :value=>"2013", :distance=>0, :key_words=>[]},
#  {:type=>:month, :value=>"07", :distance=>0, :key_words=>[]},
#  {:type=>:day, :value=>"09", :distance=>7, :key_words=>[]},
#  {:type=>:year, :value=>"1990", :distance=>0, :key_words=>[]}]

input = '1990 1988 year 2013 bla bla bla 2015 a b c d i f g qwe 2016'
dates_from_string.get_structure(input)

#=> return
#  [{:type=>:year, :value=>"1990", :distance=>1, :key_words=>[]},
#  {:type=>:year, :value=>"1988", :distance=>2, :key_words=>[]},
#  {:type=>:year, :value=>"2013", :distance=>4, :key_words=>[]},
#  {:type=>:year, :value=>"2015", :distance=>9, :key_words=>[]},
#  {:type=>:year, :value=>"2016", :distance=>0, :key_words=>[]}]

input = 'August 1961'
dates_from_string.get_structure(input)

#=> return
#  [{:type=>:month, :value=>"08", :distance=>1, :key_words=>[]},
#  {:type=>:year, :value=>"1961", :distance=>0, :key_words=>[]}]

input = '10 April 1948'
dates_from_string.get_structure(input)

#=> return
# [{:type=>:day, :value=>"10", :distance=>1, :key_words=>[]},
# {:type=>:month, :value=>"04", :distance=>1, :key_words=>[]},
# {:type=>:year, :value=>"1948", :distance=>0, :key_words=>[]}]
#

input = 'circa 1960 and full date 07 Jun 1941'
dates_from_string.get_structure(input)

#=> return
# [{:type=>:year, :value=>"1960", :distance=>4, :key_words=>[]},
# {:type=>:day, :value=>"07", :distance=>1, :key_words=>[]},
# {:type=>:month, :value=>"06", :distance=>1, :key_words=>[]},
# {:type=>:year, :value=>"1941", :distance=>0, :key_words=>[]}]

obj = DatesFromString.new(['and'])
input = 'between 1960 and 1965'
obj.get_structure(input)

#=> return
# [{:type=>:year, :value=>"1960", :distance=>2, :key_words=>['and']},
# {:type=>:year, :value=>"1965", :distance=>0, :key_words=>[]},]

dates_from_string_with_ordinals = DatesFromString.new(['and'], ordinals: ['st', 'th', 'nd'])
input = 'around September 2nd, 2013'
dates_from_string_with_ordinals.get_structure(input)

#=> return
# [{:type=>:month, :value=>"09", :distance=>1, :key_words=>[]},
# {:type=>:day, :value=>"2", :distance=>1, :key_words=>[]},
# {:type=>:year, :value=>"2013", :distance=>0, :key_words=>[]}]

input = "In September 2011, following a change in the law extending
         the presidential term from four years to six,[5] Putin announced
         that he would seek a third, non-consecutive term as President in
         the 2012 presidential election, an announcement which led to
         large-scale protests in many Russian cities. In March 2012 he won the election,
         which was criticized for procedural irregularities, and is serving a six-year term"
dates_from_string.get_structure(input)

#=> return
# [{:type=>:month, :value=>"09", :distance=>1, :key_words=>[]},
# {:type=>:year, :value=>"2011", :distance=>30, :key_words=>[]},
# {:type=>:year, :value=>"2012", :distance=>15, :key_words=>[]},
# {:type=>:month, :value=>"03", :distance=>1, :key_words=>[]},
# {:type=>:year, :value=>"2012", :distance=>0, :key_words=>[]}]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dates_from_string/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
