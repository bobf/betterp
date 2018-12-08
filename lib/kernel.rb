# frozen_string_literal: true

module Kernel
  def p(*args)
    raw = caller(1..1).first
    source = Betterp::Source.new(raw, Dir.pwd)

    Betterp::Output.new(raw, source).format(args).each do |output|
      STDOUT.write(output + "\n")
    end

    args.size > 1 ? args : args.first
  end
end
