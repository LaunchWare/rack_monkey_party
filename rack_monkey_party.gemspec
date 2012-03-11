# -*- encoding: utf-8 -*-
require File.expand_path('../lib/monkey_party/rack/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dan Pickett"]
  gem.email         = ["dpickett@enlightsolutions.com"]
  gem.description   = %q{A rack endpoint for adding subscribers to an email list}
  gem.summary       = %q{A rack endpoint for adding subscribers to an email list: uses the monkey_party web wrapper }
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rack_monkey_party"
  gem.require_paths = ["lib"]
  gem.version       = MonkeyParty::Rack::VERSION

  gem.add_dependency "rack"
  gem.add_dependency "monkey_party"
  gem.add_dependency "json"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rack-test"
  gem.add_development_dependency "fakeweb"
  gem.add_development_dependency "vcr"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency 'mocha'
end

