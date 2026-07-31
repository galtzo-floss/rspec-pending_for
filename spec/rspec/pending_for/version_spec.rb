# frozen_string_literal: true

require "anonymous_loader"
RSpec.describe Rspec::PendingFor::Version do
  it "executes the version file for coverage without redefining constants" do
    path = File.expand_path("../../../lib/rspec/pending_for/version.rb", __dir__)
    anonymous_namespace = AnonymousLoader.load(:files => path)

    expect(anonymous_namespace::Rspec::PendingFor::Version::VERSION).to eq(described_class::VERSION)
  end
end
