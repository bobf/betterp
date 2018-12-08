# frozen_string_literal: true

module Betterp
  class Source
    def initialize(source, base_path)
      @source = source
      @base_path = base_path
      @path, @line_no, @method_info = source.split(':')
    end

    def path
      Pathname.new(@path).relative_path_from(Pathname.new(@base_path)).to_s
    rescue ArgumentError
      @path
    end

    def line_no
      @line_no.to_i
    end

    def method_name
      @method_info.partition('`').last.chomp("'")
    end
  end
end
