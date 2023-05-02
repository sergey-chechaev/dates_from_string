# frozen_string_literal: true

require 'dates_from_string/version'

class DatetimeFormatter
  def initialize(structure)
    @structure = structure

    @array_of_full_data = []
  end

  def start
    if @structure
      if (@structure.select { |father| father[:type] == :time }).any?
        get_year_month_day_time
      else
        get_year_month_day
      end
    end

    @array_of_full_data
  end

  def get_year_month_day_time
    set_year_month_day_time

    @structure&.each do |item|
      @year = item[:value] if item[:type] == :year

      @month = item[:value] if item[:type] == :month

      @day = item[:value] if item[:type] == :day

      @time = item[:value] if item[:type] == :time

      @array_of_full_data << [[@year, @month, @day].join('-'), @time].join(' ') if @year && @month && @day && @time
    end

    @array_of_full_data
  end

  def get_year_month_day
    set_year_month_day_time

    @structure&.each do |item|
      @year = item[:value] if item[:type] == :year

      @month = item[:value] if item[:type] == :month

      @day = item[:value] if item[:type] == :day

      @array_of_full_data << [@year, @month, @day].join('-') if @year && @month && @day
    end

    @array_of_full_data
  end

  def set_year_month_day_time
    @year = nil
    @month = nil
    @day = nil
    @time = nil
  end
end
