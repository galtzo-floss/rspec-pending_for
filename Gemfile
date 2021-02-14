# frozen_string_literal: true

# This Gemfile copies liberally from https://github.com/rspec/rspec-core/blob/main/Gemfile
source 'https://rubygems.org'

# Specify your gem's dependencies in rspec-pending_for.gemspec
gemspec

ruby_version = Gem::Version.new(RUBY_VERSION)
if ruby_version < Gem::Version.new('1.9.3')
  gem 'rake', '< 11.0.0' # rake 11 requires Ruby 1.9.3 or later
elsif ruby_version < Gem::Version.new('2.0.0')
  gem 'rake', '< 12.0.0' # rake 12 requires Ruby 2.0.0 or later
elsif ruby_version < Gem::Version.new('2.2.0')
  gem 'rake', '< 13.0.0' # rake 13 requires Ruby 2.2.0 or later
else
  gem 'rake', '> 13.0.0'
end

gem 'yard', '~> 0.9.24', :require => false

### deps for rdoc.info
group :documentation do
  gem 'github-markup', :platform => :mri
  gem 'redcarpet', :platform => :mri
end

group :development, :test do
  if ruby_version >= Gem::Version.new('2.4')
    # No need to run byebug / pry on earlier versions
    gem 'byebug', :platform => :mri
    gem 'pry', :platform => :mri
    gem 'pry-byebug', :platform => :mri
  end

  if ruby_version >= Gem::Version.new('2.7')
    # No need to run rubocop or simplecov on earlier versions
    gem 'rubocop', '~> 1.9', :platform => :mri
    gem 'rubocop-md', :platform => :mri
    gem 'rubocop-minitest', :platform => :mri
    gem 'rubocop-packaging', :platform => :mri
    gem 'rubocop-performance', :platform => :mri
    gem 'rubocop-rake', :platform => :mri
    gem 'rubocop-rspec', :platform => :mri

    gem 'simplecov', '~> 0.21', :platform => :mri
  end
end

group :test do
  gem 'test-unit', '~> 3.0' if ruby_version >= Gem::Version.new('2.2')

  # Version 5.12 of minitest requires Ruby 2.4
  gem 'minitest', '< 5.12.0' if ruby_version < Gem::Version.new('2.4.0')
end

gem 'contracts', '< 0.16' if ruby_version < Gem::Version.new('1.9.0')
