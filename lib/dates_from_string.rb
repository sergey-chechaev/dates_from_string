require "dates_from_string/version"
require "parsing_structure"

class DatesFromString


  PATTERNS = {
    [
      /\d{4}-\d{2}-\d{2}/,
      /\d{4}-\d{1}-\d{2}/,
      /\d{4}-\d{1}-\d{1}/,
      /\d{4}-\d{2}-\d{1}/,
    ] => -> string { string.to_s.split("-") },
    [
      /\d{2}-\d{2}-\d{4}/,
      /\d{2}-\d{1}-\d{4}/,
      /\d{1}-\d{1}-\d{4}/,
      /\d{1}-\d{2}-\d{4}/,
    ] => -> string { string.to_s.split("-").reverse },
    [
      /\d{4}\.\d{2}\.\d{2}/,
    ] => -> string { string.to_s.split(".") },
    [
      /\d{2}\.\d{2}\.\d{4}/,
    ] => -> string { string.to_s.split(".").reverse },
    [
      /\d{4}\/\d{2}\/\d{2}/,
    ] => -> string { string.to_s.split("/") },
    [
      /\d{2}\/\d{2}\/\d{4}/,
    ] => -> string { string.to_s.split("/").reverse },
  }

  DATE_COUNTRY_FORMAT = {
    default: -> {[:year,:month,:day]},
    usa: -> {[:year,:day,:month]}
  }

  def initialize(key_words = [], date_format: :default)
    @key_words = key_words
    @date_format = date_format_by_country(date_format)
  end

  def find_date(string)
    parsing_structure = ParsingStructure.new(get_structure(string))
    parsing_structure.start
  end

  def get_clear_text
    @clear_text.strip
  end

  def email_date(email)
    email.match(/(?:(?:19|20)[0-9]{2})/).to_s
  end

  def date_format_by_country(date_format)
    DATE_COUNTRY_FORMAT[date_format.to_sym].call
  end

  def get_structure(string)
    unless string.nil? || string.empty?
      @main_arr = []
      data_arr = string.split(" ")
      @indexs = []
      @first_index = []
      @clear_text = string.clone

      data_arr.each_with_index do |data, index|
        value_year = get_year(data)
        value_full_date = get_full_date(data)
        value_month_year_date = get_month_year_date(data)
        value_dash = get_dash_data(data)
        value_month = get_month_by_list(data)
        value_short_month = get_short_month(data)
        value_time = get_time(data)

        value_day = get_day(data)
        next_index = index + 1

        if value_year
          add_to_structure(:year ,value_year, index, next_index, data_arr)
        end

        if value_full_date
          if @main_arr.size == 0
            index = 0
          end
          add_to_structure(@date_format[0], value_full_date[0], index, next_index, data_arr)
          add_to_structure(@date_format[1], value_full_date[1], index, next_index, data_arr)
          add_to_structure(@date_format[2], value_full_date[2], index, next_index, data_arr)
        end

        if value_month_year_date
          add_to_structure(:year , value_month_year_date[0], index, next_index, data_arr)
          add_to_structure(:month ,value_month_year_date[1], index, next_index, data_arr)
        end

        if value_dash
          add_to_structure(:year ,value_dash[0], index, next_index, data_arr, '-')
          add_to_structure(:year ,value_dash[1], index, next_index, data_arr)
        end

        if value_month
          add_to_structure(:month ,value_month, index, next_index, data_arr)
        end

        if value_short_month
          add_to_structure(:month ,value_short_month, index, next_index, data_arr)
        end

        if value_day
          add_to_structure(:day ,value_day, index, next_index, data_arr)
        end

        if value_time
           add_to_structure(:time ,value_time, index, next_index, data_arr)
        end

      end

      return @main_arr
    else
      nil
    end
  end

  def get_time(string)
    if (result = string.match(/\d{2}:\d{2}:\d{2}/))
      @clear_text.slice!(result.to_s)
      result.to_s
    elsif (result = string.match(/\d{2}:\d{2}/))
      @clear_text.slice!(result.to_s)
      result.to_s
    else
      nil
    end
  end

  def get_year(string)
    if string =~ /^\d{4}$/
      string
    elsif string =~ /^\d{4}\.$/
      string.delete!('.')
    elsif string =~ /^\d{4}\,$/
      string.delete!(',')
    else
      nil
    end
  end

  def get_full_date(string)

    PATTERNS.keys.each do |patterns|
      patterns.each do |pattern|
        if (result = string.match(pattern))
          @clear_text.slice!(result.to_s)
          return  PATTERNS[patterns].call result
        end
      end
    end

    return nil

  end

  def get_month_year_date(string)
    if (result = string.match(/^\d{2}\.\d{4}$/))
      result.to_s.split(".").reverse
    elsif (result = string.match(/^\d{4}\.\d{2}$/))
      result.to_s.split(".")
    else
      nil
    end
  end

  def get_day(string)
    if string =~ (/^\d{2}$/)
      string
    else
      nil
    end
  end


  def get_dash_data(string)
    if (result = string.match(/\d{4}-\d{4}/))
      result.to_s.split("-")
    elsif (result = string.match(/\d{4}–\d{4}/))
      result.to_s.split("–")
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

  def get_short_month(string)
    short_month = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Apr','Sep','Oct','Nov','Dec']
    short_index = short_month.index(string)

    if short_index
      sprintf('%02d',(short_index+1))
    else
      nil
    end
  end

  def add_to_structure (type ,value, index, next_index, data_arr, key_word = nil)
    set_structura
    if value
      @first_index << index
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
    elsif @first_index[0] < index
      result = (index - @first_index[0])
    else
      result = index
    end
  end

  def set_structura
    @structura = {type: nil, value: nil, distance: 0, key_words: []}
  end
end
