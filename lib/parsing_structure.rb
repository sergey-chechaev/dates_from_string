require "dates_from_string/version"

class ParsingStructure

  def initialize(structure)
    @structure = structure
  end

  def start
    array_of_full_data = []
    year = nil
    month = nil
    day = nil

    @structure.each do |item|
      if item[:type] == :year && item[:distance] == 0
        year = item[:value]
      end

      if item[:type] == :month && item[:distance] == 0
        month = item[:value]
      end

      if item[:type] == :day && item[:distance] == 0
        day = item[:value]
      end

      if year && month && day
        array_of_full_data << [year,month,day].join("-")
      end
    end

    array_of_full_data
  end
end