# frozen_string_literal: true

# External Libraries
require "ruby_version"
require "ruby_engine"

# This gem
require_relative "pending_for/version"
require_relative "pending_for/engine_or_versions_required"
require_relative "pending_for/build"
require_relative "pending_for/rspec"

module Rspec
  # Use with Rspec by including in your example groups, just like any other Rspec helpers:
  #
  #     RSpec.configure do |c|
  #       c.include Rspec::PendingFor
  #     end
  #
  module PendingFor
    # How to pend specs that break due to bugs in Ruby interpreters or versions
    #
    #     it("blah is blah") do
    #       pending_for(engine: "ruby", versions: "2.1.5")
    #       expect("blah").to eq "blah"
    #     end
    #
    # Not using named parameters because still supporting Ruby 1.9
    #
    # @param options [Hash] pending configuration
    # @option options [String,Symbol] :engine ("ruby") Ruby engine name to match, e.g. :ruby, :jruby, :truffleruby
    # @option options [String,Array<String,Range>] :versions
    #   A single version string or an Array of version specs. Each spec can be:
    #   - String: exact version match (e.g., "2.7.8")
    #   - Range<Gem::Version>: inclusive/exclusive bounds respected (e.g., Gem::Version.new("2.6.0")...Gem::Version.new("3.0.0"))
    #   - Range<Integer>: compares Ruby major version (e.g., 2..3). Inclusive/exclusive respected.
    #   JRuby/TruffleRuby are supported via RUBY_VERSION compatibility for Integer ranges and Gem::Version ranges.
    # @option options [String] :reason Custom message to display when pending
    def pending_for(options = {})
      modify_example_with(:pending, options)
    end

    # How to pend specs that break due to bugs in Ruby interpreters or versions
    #
    #     it("blah is blah") do
    #       skip_for(engine: "jruby", versions: "2.2.2")
    #       expect("blah").to eq "blah"
    #     end
    #
    # Not using named parameters because still supporting Ruby 1.9
    #
    # @param options [Hash] skip configuration
    # @option options [String,Symbol] :engine ("ruby") Ruby engine name to match, e.g. :ruby, :jruby, :truffleruby
    # @option options [String,Array<String,Range>] :versions
    #   A single version string or an Array of version specs. Each spec can be:
    #   - String: exact version match (e.g., "2.7.8")
    #   - Range<Gem::Version>: inclusive/exclusive bounds respected (e.g., Gem::Version.new("2.6.0")...Gem::Version.new("3.0.0"))
    #   - Range<Integer>: compares Ruby major version (e.g., 2..3). Inclusive/exclusive respected.
    #   JRuby/TruffleRuby are supported via RUBY_VERSION compatibility for Integer ranges and Gem::Version ranges.
    # @option options [String] :reason Custom message to display when skipping
    def skip_for(options = {})
      modify_example_with(:skip, options)
    end

    private

    def modify_example_with(message, options)
      raise(EngineOrVersionsRequired, "#{message}_for") unless options[:engine] || options[:versions]

      build = Build.new(options)
      send(message, build.message) if build.current_matches_specified?
    end
  end
end
