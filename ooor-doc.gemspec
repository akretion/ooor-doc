$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ooor-doc/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ooor-doc"
  s.version     = OoorDoc::VERSION
  s.authors     = ["Raphael Valyi - www.akretion.com"]
  s.email       = ["raphael.valyi@akretion.com"]
  s.homepage    = "http://github.com/akretion/ooor-doc"
  s.summary     = "UML and OpenERP classes auto-documentation OOOR tools"
  s.description = "UML and OpenERP classes auto-documentation OOOR tools"

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "ooor"
end
