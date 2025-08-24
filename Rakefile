# frozen_string_literal: true

# Galtzo FLOSS Rakefile v1.0.11 - 2025-08-19
# Ruby 2.3 (Safe Navigation) or higher required
#
# CHANGELOG
# v1.0.0 - initial release w/ support for rspec, minitest, rubocop, reek, yard, and stone_checksums
# v1.0.1 - fix test / spec tasks running 2x
# v1.0.2 - fix duplicate task warning from RuboCop
# v1.0.3 - add bench tasks to run mini benchmarks (add scripts to /benchmarks)
# v1.0.4 - add support for floss_funding:install
# v1.0.5 - add support for halting in Rake tasks with binding.b (from debug gem)
# v1.0.6 - add RBS files and checksums to YARD-generated docs site
# v1.0.7 - works with vanilla ruby, non-gem, bundler-managed, projects
# v1.0.8 - improved Dir globs, add back and document rbconfig dependency
# v1.0.9 - add appraisal:update task to update Appraisal gemfiles and autocorrect with RuboCop Gradual
# v1.0.10 - add ci:act to run GHA workflows locally, and get status of remote workflows
# v1.0.11 - ci:act workflows are populated entirely dynamically, based on existing files
#
# MIT License (see License.txt)
#
# Copyright (c) 2025 Peter H. Boling (galtzo.com)
#
# Expected to work in any project that uses Bundler.
#
# Sets up tasks for appraisal, floss_funding, rspec, minitest, rubocop, reek, yard, and stone_checksums.
#
# rake appraisal:update                 # Update Appraisal gemfiles and run RuboCop Gradual autocorrect
# rake bench                            # Run all benchmarks (alias for bench:run)
# rake bench:list                       # List available benchmark scripts
# rake bench:run                        # Run all benchmark scripts (skips on CI)
# rake build                            # Build gitmoji-regex-1.0.2.gem into the pkg directory
# rake build:checksum                   # Generate SHA512 checksum of gitmoji-regex-1.0.2.gem into the checksums directory
# rake build:generate_checksums         # Generate both SHA256 & SHA512 checksums into the checksums directory, and git...
# rake bundle:audit:check               # Checks the Gemfile.lock for insecure dependencies
# rake bundle:audit:update              # Updates the bundler-audit vulnerability database
# rake ci:act[opt]                      # Run 'act' with a selected workflow
# rake clean                            # Remove any temporary products
# rake clobber                          # Remove any generated files
# rake coverage                         # Run specs w/ coverage and open results in browser
# rake floss_funding:install            # (stub) floss_funding is unavailable
# rake install                          # Build and install gitmoji-regex-1.0.2.gem into system gems
# rake install:local                    # Build and install gitmoji-regex-1.0.2.gem into system gems without network ac...
# rake reek                             # Check for code smells
# rake reek:update                      # Run reek and store the output into the REEK file
# rake release[remote]                  # Create tag v1.0.2 and build and push gitmoji-regex-1.0.2.gem to rubygems.org
# rake rubocop                          # alias rubocop task to rubocop_gradual
# rake rubocop_gradual                  # Run RuboCop Gradual
# rake rubocop_gradual:autocorrect      # Run RuboCop Gradual with autocorrect (only when it's safe)
# rake rubocop_gradual:autocorrect_all  # Run RuboCop Gradual with autocorrect (safe and unsafe)
# rake rubocop_gradual:check            # Run RuboCop Gradual to check the lock file
# rake rubocop_gradual:force_update     # Run RuboCop Gradual to force update the lock file
# rake spec                             # Run RSpec code examples
# rake test                             # Run tests
# rake yard                             # Generate YARD Documentation

# External gems
require "bundler/gem_tasks" if !Dir[File.join(__dir__, "*.gemspec")].empty?

# Detect if the invoked task is spec/test to avoid eagerly requiring the library,
# which would load code before SimpleCov can start (when running `rake spec`).
invoked_tasks = Rake.application.top_level_tasks
running_specs = invoked_tasks.any? { |t| t == "spec" || t == "test" || t == "coverage" }

if running_specs
  # Define minimal rspec tasks locally to keep coverage accurate
  begin
    require "rspec/core/rake_task"
    desc("Run RSpec code examples")
    RSpec::Core::RakeTask.new(:spec)
    desc("Run tests")
    task(:test => :spec)
  rescue LoadError
    # If rspec isn't available, let it fail when the task is invoked
  end
else
  require "kettle/dev"

  # Define a base default task early so other files can enhance it.
  desc "Default tasks aggregator"
  task :default do
    puts "Default task complete."
  end

  Kettle::Dev.install_tasks

  ### RELEASE TASKS
  # Setup stone_checksums
  begin
    require "stone_checksums"

    GemChecksums.install_tasks
  rescue LoadError
    desc("(stub) build:generate_checksums is unavailable")
    task("build:generate_checksums") do
      warn("NOTE: stone_checksums isn't installed, or is disabled for #{RUBY_VERSION} in the current environment")
    end
  end
end
