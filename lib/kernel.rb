# frozen_string_literal: true

# Overrides for `p` and `pp` Kernel methods.
module Kernel
  def p(*args, &block)
    raw = caller(1..1).first
    _betterp(raw, args, block)
  end

  def pp(*args, &block)
    raw = caller(1..1).first
    _betterp(raw, args, block, pretty: true)
  end

  def _betterp(raw, args, block, options = {}) # rubocop:disable Metrics/AbcSize
    source = Betterp::Source.new(raw, Dir.pwd)
    pretty = options.fetch(:pretty, false)

    block_result, duration = Betterp::TimedBlock.new(block:).result unless block.nil?

    output = Betterp::Output.new(raw, source, duration, pretty:)
    formatted_output = output.formatted(block.nil? ? args : [block_result]).join("\n")

    return formatted_output if Betterp.configuration.test_mode

    $stdout.write(formatted_output)

    return block_result unless block.nil?

    args.size > 1 ? args : args.first
  end
end
