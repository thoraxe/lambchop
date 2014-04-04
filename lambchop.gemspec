$:.push File.expand_path("../lib", __FILE__)
require "lambchop/version"

Gem::Specification.new do |s|
  s.name             = 'lambchop'
  s.version          = Lambchop.version
  s.platform         = Gem::Platform::RUBY
  s.summary          = "Create puppet DSL from arbitrary files."
  s.description      = "You shouldn't have to learn Puppet's DSL just to generate a manifest for a single config file. Lambchop automates that for you."
  s.authors          = ["Erik M Jacobs"]
  s.email            = 'erikmjacobs@gmail.com'
  s.homepage         = 'https://github.com/thoraxe/lambchop'
  s.files            = Dir['{lib,test}/**/*', 'README*']
  s.test_files       = Dir['test/**/*']
  s.extra_rdoc_files = Dir['README*']
  s.license          = 'GPL-3.0'
  s.require_path     = 'lib'
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
end
