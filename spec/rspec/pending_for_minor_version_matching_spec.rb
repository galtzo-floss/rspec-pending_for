# frozen_string_literal: true

RSpec.describe Rspec::PendingFor do
  let(:host) { Class.new { include Rspec::PendingFor }.new }

  context "when a minor version is specified as a String (e.g., '3.1')" do
    it "pends for any patch version within that minor version" do
      allow(RubyVersion).to receive(:to_s).and_return("3.1.2")
      expect(host).to receive(:pending)
      expect(host.pending_for(:versions => "3.1")).to be_nil
    end

    it "skips for any patch version within that minor version" do
      allow(RubyVersion).to receive(:to_s).and_return("2.7.10")
      expect(host).to receive(:skip)
      expect(host.skip_for(:versions => "2.7")).to be_nil
    end

    it "does not pend when the current version is a different minor" do
      allow(RubyVersion).to receive(:to_s).and_return("3.2.0")
      expect(host).not_to receive(:pending)
      expect(host.pending_for(:versions => "3.1")).to be_nil
    end

    it "respects engine gate when provided" do
      allow(RubyVersion).to receive(:to_s).and_return("3.1.4")
      allow(RubyEngine).to receive(:is?).with("ruby").and_return(true)
      expect(host).to receive(:pending)
      expect(host.pending_for(:engine => "ruby", :versions => "3.1")).to be_nil
    end
  end
end
