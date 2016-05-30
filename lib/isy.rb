require 'isy/version'
require 'isy/methods'

module Isy
  def self.bind! # :nodoc:
    Object.instance_eval do
      include Isy::Methods
    end
  end
end

Isy.bind!
