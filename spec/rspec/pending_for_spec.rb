# frozen_string_literal: true

RSpec.describe Rspec::PendingFor do
  # Make the methods callable for the purposes of testing
  module Rspec
    module PendingFor
      extend self
    end
  end

  it "has a version number" do
    expect(Rspec::PendingFor::VERSION).not_to be_nil
  end

  describe "#pending_for" do
    context "missing args" do
      it("raises an error") do
        expect { described_class.pending_for }.to raise_error Rspec::PendingFor::EngineOrVersionsRequired
      end
    end

    context "with engine" do
      it("calls pending when engine is a match") do
        allow(RubyEngine).to receive(:is?).and_return(true)
        expect(described_class).to receive(:pending)
        expect(described_class.pending_for(:engine => "ruby")).to be_nil
      end

      it("does not call pending when engine is not a match") do
        allow(RubyEngine).to receive(:is?).and_return(false)
        expect(described_class).not_to receive(:pending)
        expect(described_class.pending_for(:engine => "ruby")).to be_nil
      end
    end

    context "with versions" do
      context "as nil" do
        it("raises an error") do
          expect { described_class.pending_for(:versions => nil) }.to raise_error Rspec::PendingFor::EngineOrVersionsRequired
        end

        context "with engine" do
          it("calls pending when engine is a match") do
            allow(RubyEngine).to receive(:is?).and_return(true)
            expect(described_class).to receive(:pending)
            expect(described_class.pending_for(:engine => "ruby", :versions => nil)).to be_nil
          end

          it("does not call pending when engine is not a match") do
            allow(RubyEngine).to receive(:is?).and_return(false)
            expect(described_class).not_to receive(:pending)
            expect(described_class.pending_for(:engine => "ruby", :versions => nil)).to be_nil
          end
        end
      end

      context "as empty array" do
        it("does not call pending when version is not a match") do
          allow(RubyVersion).to receive(:to_s).and_return("2.1.5")
          expect(described_class).not_to receive(:pending)
          expect(described_class.pending_for(:versions => [])).to be_nil
        end

        context "with engine" do
          it("calls pending when engine is a match") do
            allow(RubyEngine).to receive(:is?).and_return(true)
            expect(described_class).to receive(:pending)
            expect(described_class.pending_for(:engine => "ruby", :versions => [])).to be_nil
          end

          it("does not call pending when engine is not a match") do
            allow(RubyEngine).to receive(:is?).and_return(false)
            expect(described_class).not_to receive(:pending)
            expect(described_class.pending_for(:engine => "ruby", :versions => [])).to be_nil
          end
        end
      end

      context "as string" do
        before { allow(RubyVersion).to receive(:to_s).and_return("2.1.5") }

        context "version is a match" do
          it("calls pending") do
            expect(described_class).to receive(:pending)
            expect(described_class.pending_for(:versions => "2.1.5")).to be_nil
          end

          context "and engine" do
            it("is a match calls pending") do
              allow(RubyEngine).to receive(:is?).and_return(true)
              expect(described_class).to receive(:pending)
              expect(described_class.pending_for(:engine => "ruby", :versions => "2.1.5")).to be_nil
            end

            it("is not a match does not call pending") do
              allow(RubyEngine).to receive(:is?).and_return(false)
              expect(described_class).not_to receive(:pending)
              expect(described_class.pending_for(:engine => "ruby", :versions => "2.1.5")).to be_nil
            end
          end
        end

        context "version is not a match" do
          it("does not call pending when version is not a match") do
            expect(described_class).not_to receive(:pending)
            expect(described_class.pending_for(:versions => "2.2.3")).to be_nil
          end

          context "and engine" do
            it("is a match does not call pending") do
              allow(RubyEngine).to receive(:is?).and_return(true)
              expect(described_class).not_to receive(:pending)
              expect(described_class.pending_for(:engine => "ruby", :versions => "2.2.3")).to be_nil
            end

            it("is not a match does not call pending") do
              allow(RubyEngine).to receive(:is?).and_return(false)
              expect(described_class).not_to receive(:pending)
              expect(described_class.pending_for(:engine => "ruby", :versions => "2.2.3")).to be_nil
            end
          end
        end
      end

      context "as array of strings" do
        before { allow(RubyVersion).to receive(:to_s).and_return("2.1.5") }

        context "version is a match" do
          it("calls pending") do
            expect(described_class).to receive(:pending)
            expect(described_class.pending_for(:versions => %w[2.1.5 2.2.3])).to be_nil
          end

          context "and engine" do
            it("is a match calls pending") do
              allow(RubyEngine).to receive(:is?).and_return(true)
              expect(described_class).to receive(:pending)
              expect(described_class.pending_for(:engine => "ruby", :versions => %w[2.1.5 2.2.3])).to be_nil
            end

            it("is not a match does not call pending") do
              allow(RubyEngine).to receive(:is?).and_return(false)
              expect(described_class).not_to receive(:pending)
              expect(described_class.pending_for(:engine => "ruby", :versions => %w[2.1.5 2.2.3])).to be_nil
            end
          end
        end

        context "version is not a match" do
          it("does not call pending when version is not a match") do
            expect(described_class).not_to receive(:pending)
            expect(described_class.pending_for(:versions => %w[2.0.0 2.2.3])).to be_nil
          end

          context "and engine" do
            it("is a match does not call pending") do
              allow(RubyEngine).to receive(:is?).and_return(true)
              expect(described_class).not_to receive(:pending)
              expect(described_class.pending_for(:engine => "ruby", :versions => %w[2.0.0 2.2.3])).to be_nil
            end

            it("is not a match does not call pending") do
              allow(RubyEngine).to receive(:is?).and_return(false)
              expect(described_class).not_to receive(:pending)
              expect(described_class.pending_for(:engine => "ruby", :versions => %w[2.0.0 2.2.3])).to be_nil
            end
          end
        end
      end
    end

    context "with ranges" do
      before { allow(RubyVersion).to receive(:to_s).and_return("2.1.5") }

      it "calls pending for Gem::Version inclusive range that contains current" do
        range = Gem::Version.new("2.1.0")..Gem::Version.new("2.1.9")
        expect(described_class).to receive(:pending)
        expect(described_class.pending_for(:versions => [range])).to be_nil
      end

      it "also supports passing a single Gem::Version range directly (not in an array)" do
        range = Gem::Version.new("2.1.0")..Gem::Version.new("2.1.9")
        expect(described_class).to receive(:pending)
        expect(described_class.pending_for(:versions => range)).to be_nil
      end

      it "does not call pending for Gem::Version exclusive range that excludes upper bound" do
        range = Gem::Version.new("2.1.0")...Gem::Version.new("2.1.5")
        expect(described_class).not_to receive(:pending)
        expect(described_class.pending_for(:versions => [range])).to be_nil
      end

      it "calls pending for Integer major version inclusive range" do
        range = 2..3
        expect(described_class).to receive(:pending)
        expect(described_class.pending_for(:versions => [range])).to be_nil
      end

      it "does not call pending for Integer major version exclusive upper bound when current is excluded" do
        allow(RubyVersion).to receive(:to_s).and_return("3.0.0")
        range = 2...3
        expect(described_class).not_to receive(:pending)
        expect(described_class.pending_for(:versions => [range])).to be_nil
      end

      it "respects engine gate with ranges (jruby example)" do
        allow(RubyVersion).to receive(:to_s).and_return("2.6.8")
        allow(RubyEngine).to receive(:is?).with("jruby").and_return(true)
        expect(described_class).to receive(:pending)
        expect(described_class.pending_for(:engine => "jruby", :versions => [2..2])).to be_nil
      end

      it "does not pend when engine does not match even if range matches" do
        allow(RubyVersion).to receive(:to_s).and_return("2.6.8")
        allow(RubyEngine).to receive(:is?).with("jruby").and_return(false)
        expect(described_class).not_to receive(:pending)
        expect(described_class.pending_for(:engine => "jruby", :versions => [2..3])).to be_nil
      end
    end
  end

  describe "#skip_for" do
    context "with ranges" do
      before { allow(RubyVersion).to receive(:to_s).and_return("2.1.5") }

      it "calls skip for Gem::Version inclusive range that contains current" do
        range = Gem::Version.new("2.1.0")..Gem::Version.new("2.1.9")
        expect(described_class).to receive(:skip)
        expect(described_class.skip_for(:versions => [range])).to be_nil
      end

      it "also supports passing a single Gem::Version range directly (not in an array)" do
        range = Gem::Version.new("2.1.0")..Gem::Version.new("2.1.9")
        expect(described_class).to receive(:skip)
        expect(described_class.skip_for(:versions => range)).to be_nil
      end

      it "does not call skip for Gem::Version exclusive range that excludes upper bound" do
        range = Gem::Version.new("2.1.0")...Gem::Version.new("2.1.5")
        expect(described_class).not_to receive(:skip)
        expect(described_class.skip_for(:versions => [range])).to be_nil
      end

      it "calls skip for Integer major version inclusive range" do
        range = 2..3
        expect(described_class).to receive(:skip)
        expect(described_class.skip_for(:versions => [range])).to be_nil
      end

      it "also supports passing a single Integer major range directly (not in an array)" do
        range = 2..3
        expect(described_class).to receive(:skip)
        expect(described_class.skip_for(:versions => range)).to be_nil
      end

      it "does not call skip for Integer major version exclusive upper bound when current is excluded" do
        allow(RubyVersion).to receive(:to_s).and_return("3.0.0")
        range = 2...3
        expect(described_class).not_to receive(:skip)
        expect(described_class.skip_for(:versions => [range])).to be_nil
      end

      it "respects engine gate with ranges (jruby example)" do
        allow(RubyVersion).to receive(:to_s).and_return("2.6.8")
        allow(RubyEngine).to receive(:is?).with("jruby").and_return(true)
        expect(described_class).to receive(:skip)
        expect(described_class.skip_for(:engine => "jruby", :versions => [2..2])).to be_nil
      end

      it "does not skip when engine does not match even if range matches" do
        allow(RubyVersion).to receive(:to_s).and_return("2.6.8")
        allow(RubyEngine).to receive(:is?).with("jruby").and_return(false)
        expect(described_class).not_to receive(:skip)
        expect(described_class.skip_for(:engine => "jruby", :versions => [2..3])).to be_nil
      end
    end

    context "missing args" do
      it("raises an error") do
        expect { described_class.skip_for }.to raise_error Rspec::PendingFor::EngineOrVersionsRequired
      end
    end

    context "with engine" do
      it("calls skip when engine is a match") do
        allow(RubyEngine).to receive(:is?).and_return(true)
        expect(described_class).to receive(:skip)
        expect(described_class.skip_for(:engine => "ruby")).to be_nil
      end

      it("does not call skip when engine is not a match") do
        allow(RubyEngine).to receive(:is?).and_return(false)
        expect(described_class).not_to receive(:skip)
        expect(described_class.skip_for(:engine => "ruby")).to be_nil
      end
    end

    context "with versions" do
      context "as nil" do
        it("raises an error") do
          expect { described_class.skip_for(:versions => nil) }.to raise_error Rspec::PendingFor::EngineOrVersionsRequired
        end

        context "with engine" do
          it("calls skip when engine is a match") do
            allow(RubyEngine).to receive(:is?).and_return(true)
            expect(described_class).to receive(:skip)
            expect(described_class.skip_for(:engine => "ruby", :versions => nil)).to be_nil
          end

          it("does not call skip when engine is not a match") do
            allow(RubyEngine).to receive(:is?).and_return(false)
            expect(described_class).not_to receive(:skip)
            expect(described_class.skip_for(:engine => "ruby", :versions => nil)).to be_nil
          end
        end
      end

      context "as empty array" do
        it("does not call skip when version is not a match") do
          allow(RubyVersion).to receive(:to_s).and_return("2.1.5")
          expect(described_class).not_to receive(:skip)
          expect(described_class.skip_for(:versions => [])).to be_nil
        end

        context "with engine" do
          it("calls skip when engine is a match") do
            allow(RubyEngine).to receive(:is?).and_return(true)
            expect(described_class).to receive(:skip)
            expect(described_class.skip_for(:engine => "ruby", :versions => [])).to be_nil
          end

          it("does not call skip when engine is not a match") do
            allow(RubyEngine).to receive(:is?).and_return(false)
            expect(described_class).not_to receive(:skip)
            expect(described_class.skip_for(:engine => "ruby", :versions => [])).to be_nil
          end
        end
      end

      context "as string" do
        before { allow(RubyVersion).to receive(:to_s).and_return("2.1.5") }

        context "version is a match" do
          it("calls skip") do
            expect(described_class).to receive(:skip)
            expect(described_class.skip_for(:versions => "2.1.5")).to be_nil
          end

          context "and engine" do
            it("is a match calls skip") do
              allow(RubyEngine).to receive(:is?).and_return(true)
              expect(described_class).to receive(:skip)
              expect(described_class.skip_for(:engine => "ruby", :versions => "2.1.5")).to be_nil
            end

            it("is not a match does not call skip") do
              allow(RubyEngine).to receive(:is?).and_return(false)
              expect(described_class).not_to receive(:skip)
              expect(described_class.skip_for(:engine => "ruby", :versions => "2.1.5")).to be_nil
            end
          end
        end

        context "version is not a match" do
          it("does not call skip when version is not a match") do
            expect(described_class).not_to receive(:skip)
            expect(described_class.skip_for(:versions => "2.2.3")).to be_nil
          end

          context "and engine" do
            it("is a match does not call skip") do
              allow(RubyEngine).to receive(:is?).and_return(true)
              expect(described_class).not_to receive(:skip)
              expect(described_class.skip_for(:engine => "ruby", :versions => "2.2.3")).to be_nil
            end

            it("is not a match does not call skip") do
              allow(RubyEngine).to receive(:is?).and_return(false)
              expect(described_class).not_to receive(:skip)
              expect(described_class.skip_for(:engine => "ruby", :versions => "2.2.3")).to be_nil
            end
          end
        end
      end

      context "as array of strings" do
        before { allow(RubyVersion).to receive(:to_s).and_return("2.1.5") }

        context "version is a match" do
          it("calls skip") do
            expect(described_class).to receive(:skip)
            expect(described_class.skip_for(:versions => %w[2.1.5 2.2.3])).to be_nil
          end

          context "and engine" do
            it("is a match calls skip") do
              allow(RubyEngine).to receive(:is?).and_return(true)
              expect(described_class).to receive(:skip)
              expect(described_class.skip_for(:engine => "ruby", :versions => %w[2.1.5 2.2.3])).to be_nil
            end

            it("is not a match does not call skip") do
              allow(RubyEngine).to receive(:is?).and_return(false)
              expect(described_class).not_to receive(:skip)
              expect(described_class.skip_for(:engine => "ruby", :versions => %w[2.1.5 2.2.3])).to be_nil
            end
          end
        end

        context "version is not a match" do
          it("does not call skip when version is not a match") do
            expect(described_class).not_to receive(:skip)
            expect(described_class.skip_for(:versions => %w[2.0.0 2.2.3])).to be_nil
          end

          context "and engine" do
            it("is a match does not call skip") do
              allow(RubyEngine).to receive(:is?).and_return(true)
              expect(described_class).not_to receive(:skip)
              expect(described_class.skip_for(:engine => "ruby", :versions => %w[2.0.0 2.2.3])).to be_nil
            end

            it("is not a match does not call skip") do
              allow(RubyEngine).to receive(:is?).and_return(false)
              expect(described_class).not_to receive(:skip)
              expect(described_class.skip_for(:engine => "ruby", :versions => %w[2.0.0 2.2.3])).to be_nil
            end
          end
        end
      end
    end
  end
end
