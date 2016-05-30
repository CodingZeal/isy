require_relative 'exceptions'

module Isy
  module Methods
    # Isy::Methods#isy
    #
    # The primary use of Isy is through the #isy method, which is included into Object upon initialization
    #
    # == Usage
    #
    # You can call isy from any point, but it's intended use is to be treated like a "guard clause" to
    # assert method argument types before those arguments are used (and potentially wreak havoc
    # throughout the implementation:
    #
    #   def fullname segments
    #     isy segments, Array
    #   end
    #
    # The first argument is the subject of the test (i.e. what should match the proceeding assertion)
    # The second argument is the type.
    #
    # If the subject doesn't match the provided type, then it raises a formatted exception describing
    # what argument _value_ was a type mismatch (as an `Isy::ArgumentTypeMismatch` exception).
    #
    # == Usage with an operation
    #
    # Optionally, in place of a type as the second argument, you can pass a block, and perform
    # a more complex comparison operation:
    #
    #   def fullname segments
    #     isy segments { |seg| seg.length == 3 }
    #   end
    #
    # As illustrated above, `isy` yields to the operation the first argument (segments).  The expectation
    # is that the value returned by the operation (block) is a boolen (true => passes, false => failed).
    #
    def isy subject, *args, &evaluation
      if evaluation.nil? && args[0].nil?
        raise ArgumentError,
          'Object#isy requires either a type or evaluation block'
      end

      evaluation ||= lambda { |s| s.is_a? args[0] }

      unless evaluation.call(subject)
        raise Isy::ArgumentTypeMismatch.new(
          subject: subject,
          caller_method: caller_locations(1,1)[0].label
        )
      end
    end
  end
end
