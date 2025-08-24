# frozen_string_literal: true

RSpec.describe Rspec::PendingFor::Build do
  it "can be instantiated" do
    expect(described_class.new).to be_a described_class
  end

  describe "#relevant_versions" do
    it "defaults to empty array" do
      expect(described_class.new.relevant_versions).to eq []
    end

    it "nil becomes empty array" do
      expect(described_class.new(:versions => nil).relevant_versions).to eq []
    end

    it "can be set" do
      expect(described_class.new(:versions => "2.2.3").relevant_versions).to eq ["2.2.3"]
    end

    it "can be set to an array" do
      expect(described_class.new(:versions => ["2.2.3", "2.2.1"]).relevant_versions).to eq ["2.2.3", "2.2.1"]
    end
  end

  describe "#relevant_engine" do
    it "defaults to nil" do
      expect(described_class.new.relevant_engine).to be_nil
    end

    it "nil stays nil" do
      expect(described_class.new(:engine => nil).relevant_engine).to be_nil
    end

    it "can be set" do
      expect(described_class.new(:engine => "ruby").relevant_engine).to eq "ruby"
    end
  end

  describe "#reason" do
    it "defaults to nil" do
      expect(described_class.new.reason).to be_nil
    end

    it "nil stays nil" do
      expect(described_class.new(:reason => nil).reason).to be_nil
    end

    it "can be set" do
      expect(described_class.new(:reason => "ruby is broken").reason).to eq "ruby is broken"
    end
  end

  describe "#message" do
    before do
      allow(RubyVersion).to receive(:to_s).and_return(current_version)
      allow(RubyEngine).to receive(:is?).and_return(engine_match)
    end

    let(:engine_match) { true }
    let(:current_version) { "2.1.5" }

    context "current engine matches" do
      it "defaults to a nice message" do
        expect(described_class.new(:engine => "rbx").message).to eq "Behavior is broken due to a bug in the Ruby engine Rubinius"
      end

      context "current version matches" do
        it "defaults to a nice message" do
          expect(described_class.new(:engine => "rbx", :versions => "2.1.5").message).to match(/Behavior is broken in Ruby versions .*2\.1\.5.* due to a bug in the Ruby engine \(Rubinius\)/)
        end
      end

      context "current version does not match" do
        it "has nil message" do
          expect(described_class.new(:engine => "rbx", :versions => "2.0.0").message).to be_nil
        end
      end
    end

    context "current version matches" do
      it "defaults to a nice message" do
        expect(described_class.new(:versions => "2.1.5").message).to match(/Behavior is broken in Ruby versions .*2\.1\.5.* due to a bug in the Ruby engine/)
      end
    end

    context "current version does not match" do
      it "defaults to a nice message" do
        expect(described_class.new(:versions => "2.0.0").message).to be_nil
      end
    end

    context "current engine does not match" do
      let(:engine_match) { false }

      it "defaults to a nice message" do
        expect(described_class.new(:engine => "ruby").message).to be_nil
      end
    end

    context "when a reason overrides default messaging" do
      it "uses provided reason when engine only (all versions)" do
        allow(RubyEngine).to receive(:is?).and_return(true)
        expect(
          described_class.new(:engine => "ruby", :reason => "custom reason").message,
        ).to eq("custom reason")
      end

      it "uses provided reason when engine+versions matches" do
        allow(RubyEngine).to receive(:is?).and_return(true)
        allow(RubyVersion).to receive(:to_s).and_return("2.1.5")
        expect(
          described_class.new(:engine => "rbx", :versions => "2.1.5", :reason => "because turtles").message,
        ).to eq("because turtles")
      end

      it "uses provided reason when no engine but versions match" do
        allow(RubyVersion).to receive(:to_s).and_return("2.1.5")
        expect(
          described_class.new(:versions => ["2.1.5"], :reason => "no engine reason").message,
        ).to eq("no engine reason")
      end
    end

    context "with an unknown engine" do
      it "warns about unrecognized engine" do
        allow(RubyEngine).to receive(:is?).and_return(false)
        expect { described_class.new(:engine => "schruby") }.
          to output(/not known to rspec-pending_for/).to_stderr
      end
    end

    context "with version matching fallback via Range#cover? and String ranges" do
      before { allow(RubyEngine).to receive(:is?).and_return(nil) }

      it "matches when String range covers current" do
        allow(RubyVersion).to receive(:to_s).and_return("2.1.5")
        b = described_class.new(:versions => [("2.1.0")..("2.1.9")])
        expect(b.message).to include("Behavior is broken")
      end

      it "does not match when String range does not cover current" do
        allow(RubyVersion).to receive(:to_s).and_return("2.1.5")
        b = described_class.new(:versions => [("2.2.0")..("2.2.9")])
        expect(b.message).to be_nil
      end
    end

    context "when Gem::Version.new fails to parse the current version" do
      it "handles unrecognized version spec objects by returning no match" do
        allow(RubyVersion).to receive(:to_s).and_return("2.1.5")
        expect(
          described_class.new(:versions => [Object.new]).message,
        ).to be_nil
      end

      it "does not match Gem::Version ranges when version is malformed" do
        allow(RubyVersion).to receive(:to_s).and_return("9.1.17.0 (2.6.8)")
        gv_range = Gem::Version.new("2.6.0")..Gem::Version.new("3.0.0")
        b1 = described_class.new(:versions => [gv_range])
        expect(b1.message).to be_nil
      end

      it "still matches integer major version ranges when version is malformed" do
        allow(RubyVersion).to receive(:to_s).and_return("9.1.17.0 (2.6.8)")
        b2 = described_class.new(:versions => [9..9])
        expect(b2.message).to include("Behavior is broken")
      end
    end

    context "with nil relevant_versions (coverage focused)" do
      it "treats nil as no match via branch return" do
        # Create a subclass that returns nil to exercise the nil branch
        klass = Class.new(described_class) do
          def relevant_versions
            nil
          end
        end
        allow(RubyVersion).to receive(:to_s).and_return("2.1.5")
        b = klass.new # message computed via versions_include_current?
        expect(b.message).to be_nil
      end
    end
  end
end
