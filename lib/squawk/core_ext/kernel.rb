require 'squawk/exceptions'

module Kernel
  def squawk subject, *args, &evaluation
    if evaluation.nil? && args[0].nil?
      raise ArgumentError,
        'Kernel#squawk requires either a type or evaluation block'
    end

    evaluation ||= lambda { |s| s.is_a? args[0] }

    unless evaluation.call(subject)
      raise Squawk::ArgumentTypeMismatch, subject
    end
  end

  alias :is :squawk
end
