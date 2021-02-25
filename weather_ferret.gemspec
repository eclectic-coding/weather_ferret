lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "weather_ferret/version"

Gem::Specification.new do |spec|
  spec.name = "weather_ferret"
  spec.version = WeatherFerret::VERSION
  spec.authors = ["Chuck Smith"]
  spec.email = ["chuck@eclecticsaddlebag.com"]
  spec.summary = "Write a short summary, because RubyGems requires one."
  spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://github.com/eclectic-coding/weather-ferret"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")
  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/CHANGELOG.md",
    "allowed_push_host" => "TODO: Set to 'http://mygemserver.com'",
    "homepage_uri" => spec.homepage.to_s,
    "source_code_uri" => "https://github.com/eclectic-coding/weather_ferret",
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
