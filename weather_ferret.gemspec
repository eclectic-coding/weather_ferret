lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'weather_ferret/version'

Gem::Specification.new do |spec|
  spec.name = 'weather_ferret'
  spec.version = WeatherFerret::VERSION
  spec.authors = ['eclecticcoding']
  spec.email = ['chuck@eclecticsaddlebag.com']

  spec.summary = 'Write a short summary, because RubyGems requires one.'
  spec.description = 'Write a longer description or delete this line.'
  spec.homepage = 'https://github.com/eclectic-coding/weather-ferret'
  spec.license = 'MIT'

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/eclectic-coding/weather_ferret'
  spec.metadata['changelog_uri'] = 'https://github.com/eclectic-coding/weather_ferret'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'colorize', '~>0.8.1'
  spec.add_development_dependency 'forecast_io', '~>2.0.0'
  spec.add_development_dependency 'geocoder', '~>1.5.0'
  # spec.add_development_dependency 'httparty', '~>0.17.0'
  spec.add_development_dependency 'json', '~>2.2.0'
  spec.add_development_dependency 'pry', '~>0.12.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  # spec.add_development_dependency 'rest-client', '~>2.1.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
