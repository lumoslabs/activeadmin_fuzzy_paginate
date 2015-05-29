# -*- encoding: utf-8 -*-
require File.expand_path('../lib/activeadmin_fuzzy_paginate/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Anthony Zacharakis"]
  gem.email         = ["anthony@lumoslabs.com"]
  gem.description   = %q{Allow a resource to be "fuzzy paginated" so that aggregate queries like count aren't called on the collections}
  gem.summary       = %q{Allow a resource to be "fuzzy paginated" so that aggregate queries like count aren't called on the collections}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "activeadmin_fuzzy_paginate"
  gem.require_paths = ["lib"]
  gem.version       = ActiveadminFuzzyPaginate::VERSION

  gem.add_runtime_dependency 'activeadmin', '>= 0.4'
  gem.add_runtime_dependency 'kaminari'
end
