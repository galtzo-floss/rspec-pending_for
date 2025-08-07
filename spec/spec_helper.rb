# frozen_string_literal: true

# RSpec Configs
require_relative "config/byebug"
require_relative "config/rspec/rspec_core"
require_relative "config/rspec/rspec_block_is_expected"

# NOTE: Gemfiles for older rubies won't have kettle-soup-cover.
#       The rescue LoadError handles that scenario.
begin
  require "kettle-soup-cover"
  require "simplecov" if Kettle::Soup::Cover::DO_COV # `.simplecov` is run here!
rescue LoadError => error
  # check the error message and re-raise when unexpected
  raise error unless error.message.include?("kettle")
end

# This gem
require "rspec-pending_for"
