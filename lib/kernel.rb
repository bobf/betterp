# frozen_string_literal: true

module Kernel
  def p(*args)
    raw = caller(1..1).first
    _betterp(raw, args)
  end

  def pp(*args)
    raw = caller(1..1).first
    _betterp(raw, args, pretty: true)
  end

  def _betterp(raw, args, options = {})
    source = Betterp::Source.new(raw, Dir.pwd)
    pretty = options.fetch(:pretty, false)

    Betterp::Output.new(raw, source, pretty: pretty).format(args).each do |str|
      STDOUT.write(str + "\n")
    end

    args.size > 1 ? args : args.first
  end
end
