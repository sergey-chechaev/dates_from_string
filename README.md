# DatesFromString

Flexible solution for finding dates in text. After parsing text gem return flexible structure of dates, also you can get array of dates.


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
text = "1988-1990 and 2000 and one more date 28.04.2015"    # parsing text
key_words = ['between','-']                                 # you can define special separator
dates_from_string = DatesFromString.new('-')                # define DatesFromString object
dates_from_string.get_structure(text)                       # parsing text

#=> returns
#  [{:type=>:year, :value=>"1988", :distance=>0, :key_words=>["-"]},
#  {:type=>:year, :value=>"1990", :distance=>2, :key_words=>[]},
#  {:type=>:year, :value=>"2000", :distance=>5, :key_words=>[]},
#  {:type=>:year, :value=>"2015", :distance=>0, :key_words=>[]},
#  {:type=>:month, :value=>"04", :distance=>0, :key_words=>[]},
#  {:type=>:day, :value=>"28", :distance=>0, :key_words=>[]}]

:type       # type of date year, month or day
:value      # value of date
:distance   # distance for next date type
:key_words  # special words, symbols that separate dates 
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
