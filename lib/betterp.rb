# frozen_string_literal: true

require 'digest'
require 'pathname'
require 'pp' # rubocop:disable Lint/RedundantRequireStatement
require 'stringio'
require 'time'

require 'paintbrush'
require 'rouge'

require 'kernel'
require 'betterp/configuration'
require 'betterp/output'
require 'betterp/source'
require 'betterp/timed_block'
require 'betterp/version'

# Enhanced debug output library.
module Betterp
  def self.root
    Pathname.new(File.dirname(__dir__))
  end

  def self.configuration
    @configuration || Configuration.new
  end

  def self.configure
    @configuration = Configuration.new
    yield @configuration
  end
end
