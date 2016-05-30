require "isy/version"
require "isy/exceptions"

module Isy
  def self.bind!
    Object.instance_eval do
      include Isy::Methods
    end
  end

  module Methods
    def isy subject, *args, &evaluation
      if evaluation.nil? && args[0].nil?
        raise ArgumentError,
          'Object#isy requires either a type or evaluation block'
      end

      evaluation ||= lambda { |s| s.is_a? args[0] }

      unless evaluation.call(subject)
        raise Isy::ArgumentTypeMismatch, subject
      end
    end
  end
end

Isy.bind!
