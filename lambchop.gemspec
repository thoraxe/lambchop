require 'rubygems'
require 'rubygems/package_task'

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'lambchop'
  s.version      = PKG_VERSION
  s.summary      = "Create puppet DSL from arbitrary files."
  s.description  = "You shouldn't have to learn Puppet's DSL just to generate a manifest for a single config file. Lambchop automates that for you."
  s.authors      = ["Erik M Jacobs"]
  s.email        = 'erikmjacobs@gmail.com'
  s.homepage     = 'https://github.com/thoraxe/lambchop'
  s.files        = PKG_FILES
  s.license      = 'GPL-3.0'
  s.require_path = 'lib'
  s.autorequire  = 'rake'

  s.add_development_dependency "rspec"
end

Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
