# frozen_string_literal: true

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
      %r{\d{4}/\d{2}/\d{2}},
      %r{\d{4}/\d{2}/\d{1}}
    ] => ->(string) { string.to_s.split('/') },
    [
      %r{\d{2}/\d{2}/\d{4}},
      %r{\d{1}/\d{2}/\d{4}}
    ] => ->(string) { string.to_s.split('/').reverse }
  }.freeze

  DATE_COUNTRY_FORMAT = {
    default: -> { %i[year month day] },
    bra: -> { %i[day month year] },
    usa: -> { %i[year day month] }
  }.freeze
end
