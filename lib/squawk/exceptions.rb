module Squawk
  class ArgumentTypeMismatch < ArgumentError
    def initialize subject
      super "#{subject.inspect} isn't a valid argument"
    end
  end
end
