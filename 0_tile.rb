require "colorize"

class Tile
    def initialize(is_bomb = false)
        @is_bomb = is_bomb
        @is_flagged = false
        @revealed = false
        @neighbors = []
    end

    attr_reader :is_bomb, :neighbors

    def reveal
        if @is_flagged
            false
        else
            @revealed = true
        end
    end

    def flag
        @is_flagged = true
    end

    def unflag
        @is_flagged = false
    end

    def get_neighbors(neighbors)
        @neighbors += neighbors
    end

    def inspect
        {
            "id" => self.object_id,
            "is_bomb" => @is_bomb,
            "revealed" => @revealed,
            # "neighbors" => @neighbors
        }.inspect
    end

    def to_s
        if @revealed
            @is_bomb ? "*".light_red : "#{@close_bombs || "~" }".light_yellow
        else
            "-".light_cyan
        end
    end
end