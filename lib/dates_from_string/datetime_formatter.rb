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
      year = item[:value] if item[:type] == :year

      month = item[:value] if item[:type] == :month

      day = item[:value] if item[:type] == :day

      time = item[:value] if item[:type] == :time

      [[year, month, day].join('-'), time].join(' ') if year && month && day && time
    end
  end

  def self.get_year_month_day(structure)
    year = month = day = nil
    structure.filter_map do |item|
      year = item[:value] if item[:type] == :year
      month = item[:value] if item[:type] == :month
      day = item[:value] if item[:type] == :day

      [year, month, day].join('-') if year && month && day
    end
  end
end
