module Betterp
  class Output
    COLORS = %i[
      red
      green
      yellow
      blue
      magenta
      cyan
    ].freeze

    EFFECTS = [:bright, nil].freeze

    def initialize(source)
      @source = source
    end

    def format(args)
      args.map do |arg|
        colorize("#{@source}: ") + arg.inspect
      end
    end

    private

    def colorize(string)
      Paint[string, color, effect]
    end

    def color
      COLORS[hash(@source).hex % COLORS.size]
    end

    def effect
      EFFECTS[hash(hash(@source)).hex % EFFECTS.size]
    end

    def hash(input)
      Digest::MD5.hexdigest(input)
    end
  end
end
