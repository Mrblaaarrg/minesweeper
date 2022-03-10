require "colorize"

class Timer
    def initialize
        @start = Time.new
        @finish = nil
        @duration = nil
    end

    def end_timer
        @finish = Time.new
    end

    def timer_length
        @duration = (@finish - @start).round
    end

    def timer_lap
        self.end_timer
        self.timer_length
    end

    def render
        puts "\nPlayed for #{@duration} seconds".light_white.blink
    end
end