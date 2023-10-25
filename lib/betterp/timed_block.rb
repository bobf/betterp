# frozen_string_literal: true

module Betterp
  # Executes a block and returns the block result and duration.
  class TimedBlock
    def initialize(block:)
      @block = block
    end

    def result
      start = Time.now.utc
      block_result = block.call
      [block_result, Time.now.utc - start]
    end

    private

    attr_reader :block
  end
end
