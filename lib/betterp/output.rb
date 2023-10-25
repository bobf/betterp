# frozen_string_literal: true

module Betterp
  # Transforms default output from `Kernel.p` into enhanced, colorized output with source
  # filename, line number, method name, and duration when used with a block.
  class Output
    COLORS = %i[red green yellow blue purple cyan red_b green_b yellow_b blue_b purple_b cyan_b].freeze

    def initialize(raw, source, duration, options = {})
      @raw = raw
      @source = source
      @duration = duration
      @color = color
      @pretty = options.fetch(:pretty, false)
    end

    def formatted(args)
      (@pretty ? args : args.map(&:inspect)).map do |arg|
        output = [
          header, colorized_prefix, colorized_duration, caller_code, colorized_pretty(arg)
        ].compact.join(' ').chomp
        "#{output}\n"
      end
    end

    private

    def colorized_duration
      return nil if @duration.nil?

      duration = @duration * 1000
      color = Betterp.configuration.profiling_threshold.color(duration)
      Paintbrush.paintbrush { "[#{send color, "#{Float(format('%.2g', duration))}ms"}]" }
    end

    def colorized_pretty(arg)
      Paintbrush.paintbrush { cyan pretty(arg) }
    end

    def pretty(arg)
      return arg unless @pretty

      io = StringIO.new
      PP.pp(arg, io)
      return io.string unless io.string.include?("\n")

      "\n#{io.string.split("\n").map { |line| "  #{line}" }.join("\n")}"
    end

    def caller_code
      return nil unless @raw.include?(':')

      path, line, *_rest = @raw.split(':')
      return nil unless Pathname.new(path).readable? && line.to_i.positive?

      Paintbrush.paintbrush do
        white "{ #{blue find_caller(line.to_i, path).to_s.strip} }"
      end
    end

    def find_caller(line_number, path)
      lines = File.readlines(path)
      token = @pretty ? 'pp' : 'p'
      lines[0...line_number].reverse.find { |line| line.match(/\b#{token}\b/) }
    end

    def header
      Paintbrush.paintbrush { send @color, '####' }
    end

    def colorized_prefix
      Paintbrush.paintbrush do
        "#{blue_b @source.path}:#{cyan_b @source.line_no} => [#{green "##{@source.method_name}"}]"
      end
    end

    def color
      COLORS[hash(@raw).hex % COLORS.size]
    end

    def hash(input)
      Digest::MD5.hexdigest(input)
    end
  end
end
