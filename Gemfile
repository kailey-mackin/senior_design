group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec', '~>3.5'
  gem 'rspec-rails'
  gem 'guard-rspec'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~>1.3.6'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'rspec-expectations'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
end

group :production do
  gem 'pg', '~>0.2' # for Heroku deployment
  gem 'rails_12factor'
end

