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
        colorize(prefix) + Paint[arg.inspect, :default, :bright]
      end
    end

    private

    def prefix
      # rubocop:disable Style/FormatStringToken
      [
        '%{path}',
        '%{separator}',
        '%{line_no}',
        '%{method_pointer}',
        '%{method_name}',
        '%{terminator}'
      ].join
      # rubocop:enable Style/FormatStringToken
    end

    def colorize(string)
      # rubocop:disable Style/FormatString
      Paint % [string, color, mapping]
      # rubocop:enable Style/FormatString
    end

    def mapping
      {
        path: [@source.path, color, :underline, effect],
        line_no: [@source.line_no, :underline, color, effect],
        method_name: [@source.method_name, :reset, color, effect],

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
