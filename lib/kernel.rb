module Kernel
  def p(*args)
    Betterp::Output.new(caller(1..1).first).format(args).each do |output|
      STDOUT.write(output + "\n")
    end
    args.size > 1 ? args : args.first
  end
end
