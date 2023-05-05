# frozen_string_literal: true

require 'dates_from_string/version'

module DatetimeFormatter
  def self.compile_dates(structure)
    if structure.any? { |father| father[:type] == :time }
      get_year_month_day_time structure
    else
      get_year_month_day structure
    end
  end

  def self.get_year_month_day_time(structure)
    year = month = day = time = nil
    structure.filter_map do |item|
      case item[:type]
      when :year  then year = item[:value]
      when :month then month = item[:value]
      when :day   then day = item[:value]
      when :time  then time = item[:value]
      end

      [[year, month, day].join('-'), time].join(' ') if year && month && day && time
    end
  end

  def self.get_year_month_day(structure)
    year = month = day = nil
    structure.filter_map do |item|
      case item[:type]
      when :year  then year = item[:value]
      when :month then month = item[:value]
      when :day then day = item[:value]
      else next
      end

      [year, month, day].join('-') if year && month && day
    end
  end
end
