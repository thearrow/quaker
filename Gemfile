source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'mongoid', :github=>"mongoid/mongoid"
gem 'slim'
gem 'unicorn'
gem 'unicorn-rails'
gem 'multi_json'
gem 'oj'
gem 'httparty'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'haml-rails'
  gem 'haml2slim'
  gem 'html2haml'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'mongoid-rspec', '>= 1.6.0', :github=>"evansagge/mongoid-rspec"
end


# Heroku Gems
gem 'rails_12factor', group: :production
gem 'newrelic_rpm'