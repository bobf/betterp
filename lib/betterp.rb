# frozen_string_literal: true

require 'digest'
require 'pathname'
require 'pp'

require 'paint'

require 'kernel'
require 'betterp/output'
require 'betterp/source'
require 'betterp/version'

module Betterp
  def self.root
    Pathname.new(File.dirname(__dir__))
  end
end
