# frozen_string_literal: true

RSpec.describe "Minor version matching for pending_for/skip_for" do
  before do
    # Make the methods callable for the purposes of testing
    module Rspec
      module PendingFor
        extend self
      end
    end
  end

  describe Rspec::PendingFor do
    context "when a minor version is specified as a String (e.g., '3.1')" do
      it "pends for any patch version within that minor version" do
        allow(RubyVersion).to receive(:to_s).and_return("3.1.2")
        expect(described_class).to receive(:pending)
        expect(described_class.pending_for(:versions => "3.1")).to be_nil
      end

      it "skips for any patch version within that minor version" do
        allow(RubyVersion).to receive(:to_s).and_return("2.7.10")
        expect(described_class).to receive(:skip)
        expect(described_class.skip_for(:versions => "2.7")).to be_nil
      end

      it "does not pend when the current version is a different minor" do
        allow(RubyVersion).to receive(:to_s).and_return("3.2.0")
        expect(described_class).not_to receive(:pending)
        expect(described_class.pending_for(:versions => "3.1")).to be_nil
      end

      it "respects engine gate when provided" do
        allow(RubyVersion).to receive(:to_s).and_return("3.1.4")
        allow(RubyEngine).to receive(:is?).with("ruby").and_return(true)
        expect(described_class).to receive(:pending)
        expect(described_class.pending_for(:engine => "ruby", :versions => "3.1")).to be_nil
      end
    end
  end
end
