# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinesp_client/version'

Gem::Specification.new do |spec|
  spec.name          = "sinesp-client"
  spec.version       = SinespClient::VERSION
  spec.authors       = ["Antonio Schiavon"]
  spec.email         = ["aschiavon91@gmail.com"]

  spec.summary       = "Another version of sinesp client gem"
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/aschiavon91/sinesp_client"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end
  files = `git ls-files -z`
  
  spec.files         = files.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end.delete("#{__FILE__}")
  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "httparty"

end
