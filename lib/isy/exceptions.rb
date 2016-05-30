module Isy
  class ArgumentTypeMismatch < ArgumentError
    def initialize subject:, caller_method:
      super "#{subject.inspect} isn't a valid argument for ##{caller_method}"
    end
  end
end
