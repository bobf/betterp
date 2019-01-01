# frozen_string_literal: true

module Betterp
  class Output
    COLORS = %i[red green yellow blue magenta cyan].freeze
    EFFECTS = [:bright, nil].freeze

    def initialize(raw, source, options = {})
      @raw = raw
      @source = source
      @color = color
      @effect = effect
      @pretty = options.fetch(:pretty, false)
    end

    def format(args)
      args.map do |arg|
        style = %i[cyan black]
        header + colorize(prefix) + caller_code + Paint[pretty(arg), *style]
      end
    end

    private

    def pretty(arg)
      return arg unless @pretty

      io = StringIO.new
      PP.pp(arg, io)
      return io.string unless io.string.include?("\n")

      "\n" + io.string.split("\n").map { |line| "    #{line}" }.join("\n")
    end

    def caller_code
      return '' unless @raw.include?(':')

      path, line, *_rest = @raw.split(':')
      return '' unless Pathname.new(path).readable? && line.to_i.positive?

      Paint % [
        +'%{open}%{code}%{close}',
        :default,
        open: ['{ ', :white, :default],
        code: [find_caller(line.to_i, path).to_s.strip, :blue, :black],
        close: [' } ', :white, :default]
      ]
    end

    def find_caller(line_number, path)
      lines = File.readlines(path)
      token = @pretty ? 'pp' : 'p'
      lines[0...line_number].reverse.find { |line| line.match(/\b#{token}\b/) }
    end

    def header
      Paint % [
        +"%{standard}%{relevant}",
        :default,
        standard: ['   ', :default],
        relevant: ['•••• ', @color, @effect]
      ]
    end

    def prefix
      [
        '%{path}',
        '%{separator}',
        '%{line_no}',
        '%{method_pointer}',
        '%{method_name}',
        '%{terminator}'
      ].join
    end

    def colorize(string)
      Paint % [string, :default, mapping]
    end

    def mapping
      {
        path: [@source.path],
        line_no: [@source.line_no],
        method_name: [@source.method_name],

        method_pointer: [' => ', :reset, :bright],
        separator: [':', :reset],
        terminator: [' :: ', :reset]
      }
    end

    def color
      COLORS[hash(@raw).hex % COLORS.size]
    end

    def effect
      EFFECTS[hash(hash(@raw)).hex % EFFECTS.size]
    end

    def hash(input)
      Digest::MD5.hexdigest(input)
    end
  end
end
