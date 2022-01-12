# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dates_from_string/version'

Gem::Specification.new do |spec|
  spec.name          = 'dates_from_string'
  spec.version       = DatesFromString::VERSION
  spec.authors       = ['Sergey Chechaev']
  spec.email         = ['kompotdrinker@gmail.com']

  spec.summary       = 'Flexible solution for finding all formats of dates in text'
  spec.description   = 'Flexible solution for finding all formats of dates in text'
  spec.homepage      = ''
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  # spec.metadata['allowed_push_host'] = "https://rubygems.org"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  spec.add_development_dependency 'pry-rails'
  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
