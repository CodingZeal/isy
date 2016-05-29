require 'spec_helper'
require 'squawk'

describe Kernel do
  describe '#squawk' do
    context "when the first argument matches the type of the second" do
      specify do
        expect { squawk 'test value', String }.not_to raise_error
      end
    end

    context "when the first argument doesn't match the type of the second" do
      specify do
        expect { squawk 'test value', Hash }
          .to raise_error Squawk::ArgumentTypeMismatch
      end
    end

    context "when the provided block evaluates to false" do
      specify do
        expect { squawk(:foo) { |_| false } }
          .to raise_error Squawk::ArgumentTypeMismatch
      end
    end

    context 'when only the subject is provided' do
      specify do
        expect { squawk(:foo) }
          .to raise_error ArgumentError
      end
    end
  end

  describe '#is' do
    it { is_expected.to respond_to :is }
  end
end
