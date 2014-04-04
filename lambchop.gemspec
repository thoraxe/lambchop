Gem::Specification.new do |s|
  s.name          = 'lambchop'
  s.version       = '0.2.0'
  s.summary       = "Create puppet DSL from arbitrary files."
  s.description   = "You shouldn't have to learn Puppet's DSL just to generate a manifest for a single config file. Lambchop automates that for you."
  s.authors       = ["Erik M Jacobs"]
  s.email         = 'erikmjacobs@gmail.com'
  s.homepage      = 'https://github.com/thoraxe/lambchop'
  s.files         = ["lib/lambchop.rb", "lib/util/parser.rb"]
  s.license       = 'GPL-3.0'
  s.require_path = 'lib'
  s.add_development_dependency "rspec"
end
