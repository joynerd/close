# frozen_string_literal: true

require_relative "lib/close/version"

Gem::Specification.new do |spec|
  spec.name = "close"
  spec.version = Close::VERSION
  spec.authors = ["JoyNerd LLC"]
  spec.email = ["developers@joynerd.io"]

  spec.summary = "A ruby wrapper for the close.com API"
  spec.description = "A ruby wrapper for the close.com API that offers caching."
  spec.homepage = "https://github.com/joynerd/close"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/joynerd/close.git"
  spec.metadata["changelog_uri"] = "https://github.com/joynerd/changelog.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "ostruct"
  spec.add_dependency "faraday", ">= 2.0.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
