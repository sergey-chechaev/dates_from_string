require "dates_from_string/version"

class ParsingStructure

  def initialize(structure)
    @structure = structure

    @array_of_full_data = []
  end

  def start
    if @structure
      if (@structure.select {|father| father[:type] == :time }).any?
        get_year_month_day_time
      else
        get_year_month_day
      end
    end

    return @array_of_full_data
  end

  def get_year_month_day_time
    set_year_month_day_time

    if @structure
      @structure.each do |item|
        if item[:type] == :year
          @year = item[:value]
        end

        if item[:type] == :month
          @month = item[:value]
        end

        if item[:type] == :day
          @day = item[:value]
        end

        if item[:type] == :time
          @time = item[:value]
        end

        if @year && @month && @day && @time
          @array_of_full_data << [[@year,@month,@day].join("-"), @time].join(" ")
        end
      end
    end

    @array_of_full_data
  end

  def get_year_month_day
    set_year_month_day_time

    if @structure
      @structure.each do |item|
        if item[:type] == :year
          @year = item[:value]
        end

        if item[:type] == :month
          @month = item[:value]
        end

        if item[:type] == :day
          @day = item[:value]
        end

        if @year && @month && @day
          @array_of_full_data << [@year,@month,@day].join("-")
        end
      end
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
