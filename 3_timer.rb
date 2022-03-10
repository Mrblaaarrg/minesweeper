class Timer
    def initialize
        @start = Time.new
        @finish = nil
        @seconds_passed = 0
        @duration = nil
    end

    def end_timer
        @finish = Time.new
    end

    def timer_length
        @duration = (@finish - @start).round
    end

    def render
        puts @seconds_passed
    end
end