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
      value_year = get_year(data)
      value_full_date = get_full_date(data)
      value_dash = get_dash_data(data)
      value_month = get_month_by_list(data)
      next_index = index + 1

      if value_year
        add_to_structure(:year ,value_year, index, next_index, data_arr)
      end

      if value_full_date
        add_to_structure(:year ,value_full_date[0], index, next_index, data_arr)
        add_to_structure(:month ,value_full_date[1], index, next_index, data_arr)
        add_to_structure(:day ,value_full_date[2], index, next_index, data_arr)
      end

      if value_dash
        add_to_structure(:year ,value_dash[0], index, next_index, data_arr, '-')
        add_to_structure(:year ,value_dash[1], index, next_index, data_arr)
      end

      if value_month
        add_to_structure(:month ,value_month, index, next_index, data_arr)
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

  def get_full_date(string)
    if string =~ (/\d{4}-\d{2}-\d{2}/)
      string.split("-")
    elsif string =~ (/\d{2}-\d{2}-\d{4}/)
      string.split("-").reverse
    elsif string =~ (/\d{4}\.\d{2}\.\d{2}/)
      string.split(".")
    elsif string =~ (/\d{2}\.\d{2}\.\d{4}/)
      string.split(".").reverse
    elsif string =~ (/\d{4}\/\d{2}\/\d{2}/)
      string.split("/")
    elsif string =~ (/\d{2}\/\d{2}\/\d{4}/)
      string.split("/").reverse
    else
      nil
    end
  end

  def get_dash_data(string)
    if string =~ (/\d{4}-\d{4}/)
      string.split("-")
    else
      nil
    end
  end

  def get_month_by_list(string)
    month = ['January','February','March','April','May','June','July','August','September','October','November','December']
    index = month.index(string)
    if index
      sprintf('%02d',(index+1))
    else
      nil
    end
  end

  def add_to_structure (type ,value, index, next_index, data_arr, key_word = nil)
    set_structura
    if value
      @structura[:type] = type
      @structura[:value] = value
    end

    if value && @main_arr.last
      @main_arr.last[:distance] = calc_index(index)
    end

    if @key_words && @key_words.include?(data_arr[next_index])
      @structura[:key_words] << data_arr[next_index]
    end

    if key_word
      @structura[:key_words] << key_word
    end

    if value
      @main_arr <<  @structura
      value = nil
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
    @structura = {type: nil, value: nil, distance: 0, key_words: []}
  end
end
