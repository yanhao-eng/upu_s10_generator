# frozen_string_literal: true

require_relative "lib/upu_s10_generator/version"

Gem::Specification.new do |spec|
  spec.name = "upu_s10_generator"
  spec.version = UpuS10Generator::VERSION
  spec.authors = ["Evan Yan"]
  spec.email = ["evanyanrock@gmail.com"]

  spec.summary = "Generate UPC S10 identifier"
  spec.homepage = "https://github.com/yanhao-eng/upu_s10_generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yanhao-eng/upu_s10_generator"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
