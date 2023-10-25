# frozen_string_literal: true

module Betterp
  # Misc. configuration options for Betterp library.
  class Configuration
    attr_accessor :test_mode
    attr_writer :profiling_thresholds

    # Configures colors to use for different profiling durations, defines low, medium, and high
    # colors.
    class ProfilingThreshold
      attr_writer :low, :high

      def color(duration)
        return :green if low?(duration)
        return :yellow if medium?(duration)

        :red if high?(duration)
      end

      private

      def low?(duration)
        duration <= low
      end

      def medium?(duration)
        duration.between?(low, high)
      end

      def high?(duration)
        duration >= high
      end

      def low
        @low || 10
      end

      def high
        @high || 100
      end
    end

    def profiling_threshold
      @profiling_threshold ||= ProfilingThreshold.new
    end
  end
end
