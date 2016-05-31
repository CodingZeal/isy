require 'spec_helper'
require 'isy'

describe Isy do
  it 'has a version number' do
    expect(Isy::VERSION).not_to be nil
  end

  describe '#isy' do
    context "when the first argument matches the type of the second" do
      specify do
        expect { isy 'test value', String }.not_to raise_error
      end
    end

    context "when the first argument doesn't match the type of the second" do
      specify do
        expect { isy 'test value', Hash }
          .to raise_error Isy::ArgumentTypeMismatch
      end
    end

    context "when the provided block evaluates to true" do
      specify do
        expect { isy(:foo) { |_| true } }.not_to raise_error
      end
    end

    context "when the provided block evaluates to false" do
      specify do
        expect { isy(:foo) { |_| false } }
          .to raise_error Isy::ArgumentTypeMismatch
      end
    end

    context 'when only the subject is provided' do
      specify do
        expect { isy(:foo) }
          .to raise_error ArgumentError
      end
    end
  end

  describe '#isy?' do
    subject { isy? test_value, type }

    context 'when the subject passes' do
      let(:test_value) { 'test value' }
      let(:type) { String }

      it { is_expected.to eq true }
    end

    context 'when the subject fails' do
      let(:test_value) { 'test value' }
      let(:type) { Hash }

      it { is_expected.to eq false }
    end
  end
end

