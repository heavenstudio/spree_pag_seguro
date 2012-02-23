# encoding: UTF-8
version = File.read(File.expand_path("../GEM_VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_pag_seguro'
  s.version     = version
  s.summary     = 'Spree extension for integration with PagSeguro payment'
  s.description = 'Spree extension for integration with PagSeguro payment. Based on spree_pp_website_standart gem'
  s.required_ruby_version = '>= 1.9.2'

  s.author            = 'Gregg Pollack, Sean Schofield, Tomasz Stachewicz, Buddhi DeSilva'
  s.email             = 'tomekrs@o2.pl'
  s.homepage          = 'http://github.com/heavenstudio/spree-pag_seguro'

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*', 'config/**/*', 'db/**/*', 'spec/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 1.0.0.rc1'
  s.add_dependency 'pag_seguro', '>= 0.1.9'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.7'
  s.add_development_dependency 'sqlite3'
end
