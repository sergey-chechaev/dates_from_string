require "dates_from_string/version"
require "pry-rails"

class DatesFromString

  def initialize(key_words = [])
    @main_arr =[]
    @key_words = key_words
  end

  def find_date(sructure)

  end

  def get_structure(string)
    data_arr = string.split(" ")
    @indexs = []

    data_arr.each_with_index do |data, index|
      set_structura
      value = get_year(data)
      next_index = index + 1

      if value
        @structura[:type] = :year
        @structura[:value] = value
      end

      if value && @main_arr.last
        @main_arr.last[:distance] = calc_index(index)
      end

      if @key_words.any? && @key_words.include?(data_arr[next_index])
        @structura[:key_words] << data_arr[next_index]
      end

      if value
        @main_arr <<  @structura
        value = nil
      end

    end

    return @main_arr
  end

  def get_year(string)
    if string =~ /^\d{4}$/
      string
    else
      nil
    end
  end

  def calc_index(index)
    result = nil
    @indexs << index
    if @indexs.count > 1
      result = (index - @indexs[-2])
    else
      result = index
    end
  end

  def set_structura
    @structura = {type: nil, value: nil, distance: nil, key_words: []}
  end
end
