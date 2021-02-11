module Patterns
  PATTERNS = {
    [
      /\d{4}-\d{2}-\d{2}/,
      /\d{4}-\d{1}-\d{2}/,
      /\d{4}-\d{1}-\d{1}/,
      /\d{4}-\d{2}-\d{1}/
    ] => ->(string) { string.to_s.split('-') },
    [
      /\d{2}-\d{2}-\d{4}/,
      /\d{2}-\d{1}-\d{4}/,
      /\d{1}-\d{1}-\d{4}/,
      /\d{1}-\d{2}-\d{4}/
    ] => ->(string) { string.to_s.split('-').reverse },
    [
      /\d{4}\.\d{2}\.\d{2}/,
      /\d{4}\.\d{2}\.\d{1}/
    ] => ->(string) { string.to_s.split('.') },
    [
      /\d{2}\.\d{2}\.\d{4}/,
      /\d{1}\.\d{2}\.\d{4}/
    ] => ->(string) { string.to_s.split('.').reverse },
    [
      /\d{4}\/\d{2}\/\d{2}/,
      /\d{4}\/\d{2}\/\d{1}/
    ] => ->(string) { string.to_s.split('/') },
    [
      /\d{2}\/\d{2}\/\d{4}/,
      /\d{1}\/\d{2}\/\d{4}/
    ] => ->(string) { string.to_s.split('/').reverse }
  }.freeze

  DATE_COUNTRY_FORMAT = {
    default: -> { [:year, :month, :day] },
    bra: -> { [:day, :month, :year] },
    usa: -> { [:year, :day, :month] }
  }.freeze
end
