require "colorize"

class Tile
    def initialize(is_bomb = false)
        @is_bomb = is_bomb
        @revealed = false
    end

    attr_reader :is_bomb

    def reveal
        @revealed = true
    end

    def set_close_bombs(bomb_count)
        @close_bombs = bomb_count
    end

    def to_s
        if @revealed
            @is_bomb ? "*".light_red : "#{@close_bombs || "~" }".light_yellow
        else
            "-".light_cyan
        end
    end
end