# frozen_string_literal: true

module Betterp
  class Output
    COLORS = %i[red green yellow blue magenta cyan].freeze
    EFFECTS = [:bright, nil].freeze

    def initialize(raw, source)
      @raw = raw
      @source = source
      @color = color
      @effect = effect
    end

    def format(args)
      args.map do |arg|
        style = %i[cyan black]
        header + colorize(prefix) + caller_code + Paint[arg.inspect, *style]
      end
    end

    private

    def caller_code
      return '' unless @raw.include?(':')

      path, line, *_rest = @raw.split(':')
      return '' unless File.file?(path) && line.to_i.positive?

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
      lines[0...line_number].reverse.find { |line| line.match(/\bp\b/) }
    end

    def header
      Paint % [
        +"%{standard}%{relevant}",
        :default,
        standard: ['   '],
        relevant: ['•••• ', color, effect]
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
