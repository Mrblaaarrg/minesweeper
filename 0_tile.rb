require "colorize"

class Tile
    def initialize(is_bomb = false)
        @is_bomb = is_bomb
        @flagged = false
        @revealed = false
        @neighbors = []
    end

    attr_reader :is_bomb, :flagged, :revealed, :neighbors

    def reveal
        if @flagged
            false
        else
            @revealed = true
        end
    end

    def flag
        if @revealed
            false
        else
            @flagged = true
        end
    end

    def unflag
        @flagged = false
    end

    def get_neighbors(neighbors)
        @neighbors = neighbors
    end

    def get_bomb_count
        @close_bombs = @neighbors.count { |tile| tile.is_bomb }
    end

    def inspect
        {
            "id" => self.object_id,
            "is_bomb" => @is_bomb,
            "revealed" => @revealed,
            "flagged" => @flagged
            # "neighbors" => @neighbors
        }.inspect
    end

    def to_s
        if @flagged
            "F".light_magenta.bold
        elsif @revealed
            @is_bomb ? "*".light_red.bold : "#{@close_bombs || "~" }".light_yellow
        else
            "-".light_cyan
        end
    end
end