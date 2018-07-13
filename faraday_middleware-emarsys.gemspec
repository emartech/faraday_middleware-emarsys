# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faraday_middleware/emarsys/version'

Gem::Specification.new do |spec|

  spec.name          = "faraday_middleware-emarsys"
  spec.version       = FaradayMiddleware::Emarsys::VERSION

  spec.summary       = %q{FaradayMiddleware for Emarsys pecifications}
  spec.description   = %q{FaradayMiddleware for Emarsys pecifications}
  spec.homepage      = "https://github.com/emartech/faraday_middleware-emarsys"

  spec.license       = 'MIT'
  spec.authors       = ["Adam Luzsi", "Balint Bejczi", "karoly Bujtor"]
  spec.email         = [
    "adamluzsi@gmail.com",
    "aluzsi@emarsys.com",
    "bbejczi@emarsys.com",
    "karoly.bujtor@emarsys.com"
  ]

  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'faraday'
  spec.add_dependency 'escher-keypool'
  spec.add_dependency 'faraday_middleware-escher'

end
