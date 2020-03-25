# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-jsontcp"
  spec.version       = "1.1"
  spec.authors       = ["Kim Gert Nielsen"]
  spec.email         = ["me@greyhat.dk"]

  spec.description   = "Plugin for fluentd to send JSON to a TCP socket"
  spec.summary       = spec.description
  spec.homepage      = "https://greyhat.dk"
  spec.has_rdoc      = false

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "fluentd", [">= 0.10.58", "< 2"]
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", ">= 12.3.3"
end
