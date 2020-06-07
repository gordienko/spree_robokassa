# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_robokassa'
  s.version     = '1.0.0'
  s.summary     = 'Spree integration with Robokassa payment service.'
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 2.5.0'

  s.author    = 'Alexey Gordienko'
  s.email     = 'alx@anadyr.org'
  s.homepage  = 'https://github.com/gordienko/spree_robokassa'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 4.1'
  s.add_dependency 'spree_auth_devise', '~> 4.1'
  s.add_dependency 'offsite_payments', '~> 2.7.24'

end
